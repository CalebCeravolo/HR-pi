#include <math.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include "../../functions.h"
#include "../../pins.h"

#define DATA_ADDR ENC_RAISE_LOWER

/*
 * Set TICKS_OVER_REFERENCE to that count and REFERENCE_DISTANCE_CM to the distance you moved.
 * The values are different for each column because the linear axis is different.
 * TICKS_PER_CM is derived; all targets use centimeters.
 */
#define REFERENCE_DISTANCE_CM 10.0f
#define TICKS_OVER_REFERENCE 1000.0f /* replace with measured ticks for REFERENCE_DISTANCE_CM */
#define TICKS_PER_CM (TICKS_OVER_REFERENCE / REFERENCE_DISTANCE_CM)
#define CM_TOLERANCE 0.05f //how close to the target we want to get to before stopping (momentum of the motor)

/* Motion monitoring: if encoder speed stays below this while still far from the
 * target, the column is treated as stuck. Tune after measuring normal cruise speed. */
#define CONTROL_SAMPLE_US 10000
#define MIN_SPEED_TICKS_S (0.05f * TICKS_PER_CM) /* same scale as former 0.05 cm/s */
#define STALL_CONFIRM_SAMPLES 3
#define STALL_GRACE_US 300000 /* ignore stall until the motor has had time to ramp */
#define STALL_MIN_GAP_CM 0.12f /* do not apply stall logic when this close to target */

static int sigint = 0;
static void intHandler(int dummy) { sigint = 1; }

/** Same SPI command as Executables/resetEnc (fpga_reset_encoder). */
static void ResetENC(uint8_t encoder_channel) {
  fpga_reset_encoder(encoder_channel);
}

static int column_top_hall_enabled(void) { return (COLUMN_TOP_HALL_PIN >= 0); }

static void column_top_hall_setup(void) {
  if (!column_top_hall_enabled()) {
    return;
  }
  pinMode(COLUMN_TOP_HALL_PIN, INPUT);
  pullUpDnControl(COLUMN_TOP_HALL_PIN, PUD_UP);
}

/** True when the top Hall limit indicates the column is at mechanical top. */
static int column_at_top_hall(void) {
  if (!column_top_hall_enabled()) {
    return 0;
  }
  return digitalRead(COLUMN_TOP_HALL_PIN) == COLUMN_TOP_HALL_AT_TOP;
}

static void read_position(int32_t *ticks, float *cm) {
  *ticks = fpga_safetran(DATA_ADDR);
  *cm = (float)(*ticks) / TICKS_PER_CM;
}

/**
 * Instantaneous encoder speed from two samples (ticks/s).
 * Sign matches encoder direction: rising tick count → positive.
 */
static float column_velocity_ticks_s(int32_t ticks_before, int32_t ticks_after,
                                     long elapsed_usec) {
  if (elapsed_usec <= 0) {
    return 0.0f;
  }
  float delta_ticks = (float)(ticks_after - ticks_before);
  return delta_ticks * (1000000.0f / (float)elapsed_usec);
}

static long timeval_diff_usec(const struct timeval *a, const struct timeval *b) {
  return (long)(b->tv_sec - a->tv_sec) * 1000000L + (b->tv_usec - a->tv_usec);
}

/**
 * Returns 1 if measured speed magnitude is below the minimum (ticks/s).
 */
static int column_stall_detected(float speed_ticks_s) {
  return fabsf(speed_ticks_s) < MIN_SPEED_TICKS_S;
}

static int raiseLowerTo(float target_cm, int raise_pin, int lower_pin) {
  pinMode(raise_pin, OUTPUT);
  pinMode(lower_pin, OUTPUT);
  column_top_hall_setup();

  int32_t ticks;
  float cm;
  read_position(&ticks, &cm);
  float distance_remaining = fabsf(cm - target_cm);

  if (cm < target_cm && column_at_top_hall()) {
    ResetENC((uint8_t)ENC_RAISE_LOWER);
    read_position(&ticks, &cm);
    fprintf(stderr,
            "ERROR: Column top Hall limit active; cannot raise toward %.3f cm "
            "(current %.3f cm). Encoder reset at top.\n",
            target_cm, cm);
    digitalWrite(raise_pin, 0);
    digitalWrite(lower_pin, 0);
    return -1;
  }

  if (cm > target_cm) {
    digitalWrite(raise_pin, 0);
    digitalWrite(lower_pin, 1);
  } else {
    digitalWrite(raise_pin, 1);
    digitalWrite(lower_pin, 0);
  }

  struct timeval move_start, tv_a, tv_b;
  gettimeofday(&move_start, NULL);
  int stall_count = 0;

  while (distance_remaining > CM_TOLERANCE) {
    if (sigint) {
      digitalWrite(raise_pin, 0);
      digitalWrite(lower_pin, 0);
      break;
    }

    int32_t ticks_start = ticks;
    gettimeofday(&tv_a, NULL);
    usleep(CONTROL_SAMPLE_US);
    read_position(&ticks, &cm);
    gettimeofday(&tv_b, NULL);
    long elapsed = timeval_diff_usec(&tv_a, &tv_b);
    float speed_ticks_s = column_velocity_ticks_s(ticks_start, ticks, elapsed);
    long since_start_us =
        timeval_diff_usec(&move_start, &tv_b);

    distance_remaining = fabsf(cm - target_cm);

    if (cm < target_cm && column_at_top_hall()) {
      digitalWrite(raise_pin, 0);
      digitalWrite(lower_pin, 0);
      ResetENC((uint8_t)ENC_RAISE_LOWER);
      read_position(&ticks, &cm);
      fprintf(stderr,
              "Stopped: column top Hall limit reached before target "
              "(target %.3f cm, actual %.3f cm). Encoder reset at top.\n",
              target_cm, cm);
      break;
    }

    if (since_start_us >= (long)STALL_GRACE_US &&
        distance_remaining > STALL_MIN_GAP_CM &&
        column_stall_detected(speed_ticks_s)) {
      stall_count++;
      if (stall_count >= STALL_CONFIRM_SAMPLES) {
        fprintf(stderr,
                "ERROR: Column motion stopped: encoder speed %.4f ticks/s is below "
                "%.4f ticks/s (stall / end of travel).\n",
                speed_ticks_s, MIN_SPEED_TICKS_S);
        digitalWrite(raise_pin, 0);
        digitalWrite(lower_pin, 0);
        break;
      }
    } else {
      stall_count = 0;
    }
  }
  digitalWrite(raise_pin, 0);
  digitalWrite(lower_pin, 0);
  printf("Target: %.3f cm (%.1f ticks)\nActual: %.3f cm (%d ticks)\n", target_cm,
         target_cm * TICKS_PER_CM, cm, (int)ticks);
  return (distance_remaining > CM_TOLERANCE) ? -1 : 0;
}

int main(int argc, char *argv[]) {
  signal(SIGINT, intHandler);
  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);
  int rc = raiseLowerTo((float)vals[0], H42A_1, H42A_2);
  return (rc < 0) ? 1 : 0;
}

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

/* Motion monitoring: if the encoder speed stays below this while we are still far
 * from the target, the column is stuck (end of travel, obstruction). Values are
 * in cm/s; tune after measuring normal cruise speed on your axis. */
#define CONTROL_SAMPLE_US 10000
#define MIN_SPEED_CM_S 0.05f
#define STALL_CONFIRM_SAMPLES 3
#define STALL_GRACE_US 300000 /* ignore stall until the motor has had time to ramp */
#define STALL_MIN_GAP_CM 0.12f /* do not apply stall logic when this close to target */

static int sigint = 0;
static void intHandler(int dummy) { sigint = 1; }

static void read_position(int32_t *ticks, float *cm) {
  *ticks = fpga_safetran(DATA_ADDR);
  *cm = (float)(*ticks) / TICKS_PER_CM;
}

/**
 * Instantaneous linear speed from two encoder samples (cm/s).
 * Sign matches encoder direction: rising position → positive.
 */
static float column_velocity_cm_s(int32_t ticks_before, int32_t ticks_after,
                                  long elapsed_usec) {
  if (elapsed_usec <= 0) {
    return 0.0f;
  }
  float delta_cm = (float)(ticks_after - ticks_before) / TICKS_PER_CM;
  return delta_cm * (1000000.0f / (float)elapsed_usec);
}

static long timeval_diff_usec(const struct timeval *a, const struct timeval *b) {
  return (long)(b->tv_sec - a->tv_sec) * 1000000L + (b->tv_usec - a->tv_usec);
}

/**
 * Returns 1 if measured speed magnitude is below the minimum safe travel speed.
 */
static int column_stall_detected(float speed_cm_s) {
  return fabsf(speed_cm_s) < MIN_SPEED_CM_S;
}

static int raiseLowerTo(float target_cm, int raise_pin, int lower_pin) {
  pinMode(raise_pin, OUTPUT);
  pinMode(lower_pin, OUTPUT);

  int32_t ticks;
  float cm;
  read_position(&ticks, &cm);
  float distance_remaining = fabsf(cm - target_cm);
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
    float speed_cm_s = column_velocity_cm_s(ticks_start, ticks, elapsed);
    long since_start_us =
        timeval_diff_usec(&move_start, &tv_b);

    distance_remaining = fabsf(cm - target_cm);

    if (since_start_us >= (long)STALL_GRACE_US &&
        distance_remaining > STALL_MIN_GAP_CM &&
        column_stall_detected(speed_cm_s)) {
      stall_count++;
      if (stall_count >= STALL_CONFIRM_SAMPLES) {
        fprintf(stderr,
                "ERROR: Column motion stopped: encoder speed %.4f cm/s is below "
                "%.4f cm/s (stall / end of travel).\n",
                speed_cm_s, MIN_SPEED_CM_S);
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
  return 0;
}

int main(int argc, char *argv[]) {
  signal(SIGINT, intHandler);
  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);
  raiseLowerTo((float)vals[0], H42A_1, H42A_2);
  return 0;
}

#include <math.h>
#include <signal.h>
#include <stdint.h>
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

static int sigint = 0;
static void intHandler(int dummy) { sigint = 1; }

static void read_position(int32_t *ticks, float *cm) {
  *ticks = fpga_safetran(DATA_ADDR);
  *cm = (float)(*ticks) / TICKS_PER_CM;
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

  while (distance_remaining > CM_TOLERANCE) {
    if (sigint) {
      digitalWrite(raise_pin, 0);
      digitalWrite(lower_pin, 0);
      break;
    }
    usleep(10000);
    read_position(&ticks, &cm);
    distance_remaining = fabsf(cm - target_cm);
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

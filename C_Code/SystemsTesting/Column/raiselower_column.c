#include <math.h>
#include <signal.h>
#include <stdint.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include "../../functions.h"
#include "../../pins.h"
#define CPR 663.0 / 6
#define DATA_ADDR ENC_RAISE_LOWER

static int sigint = 0;
static void intHandler(int dummy) { sigint = 1; }

static void enc_dec(int32_t *amount, float *degrees) {
  *amount = fpga_safetran(DATA_ADDR);
  *degrees = (*amount * 360.0) / CPR;
}

static int raiseLowerTo(float target, int raise_pin, int lower_pin) {
  pinMode(raise_pin, OUTPUT);
  pinMode(lower_pin, OUTPUT);

  int32_t amount;
  float degrees;
  enc_dec(&amount, &degrees);
  float distance_remaining = fabsf(degrees - target);
  if (degrees > target) {
    digitalWrite(raise_pin, 0);
    digitalWrite(lower_pin, 1);
  } else {
    digitalWrite(raise_pin, 1);
    digitalWrite(lower_pin, 0);
  }

  while (distance_remaining > 5) {
    if (sigint) {
      digitalWrite(raise_pin, 0);
      digitalWrite(lower_pin, 0);
      break;
    }
    usleep(10000);
    enc_dec(&amount, &degrees);
    distance_remaining = fabsf(degrees - target);
  }
  digitalWrite(raise_pin, 0);
  digitalWrite(lower_pin, 0);
  printf("Target: %f\nActual: %f\n", target, degrees);
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

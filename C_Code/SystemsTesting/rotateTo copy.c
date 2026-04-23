// #include <stdlib.h>
#include <math.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
// #include <stdio.h>
#include "../functions.h"
#include "../pins.h"
#include <signal.h>
#include <stdint.h>
#include <unistd.h>
// #include <signal.h>
#define CPR 663.0 / 6 // Counts per revolution
#define DATA_ADDR 5
int sigint = 0;
void intHandler(int dummy) { sigint = 1; }
int rotateTo(float target, int left, int right) {
  pinMode(left, OUTPUT);
  pinMode(right, OUTPUT);
  int dir;
  int16_t amount;
  float degrees;
  enc_dec(&dir, &amount, &degrees);
  int16_t distance_remaining = fabsf((degrees) - (target));
  if (degrees > target) {
    digitalWrite(left, 0);
    digitalWrite(right, 1);
  } else {
    digitalWrite(left, 1);
    digitalWrite(right, 0);
  }

  while ((distance_remaining) > 5) {
    if (sigint) {
      digitalWrite(left, 0);
      digitalWrite(right, 0);
      break;
    }
    usleep(10000);
    enc_dec(&dir, &amount, &degrees);
    distance_remaining = fabsf((degrees) - (target));
  }
  digitalWrite(left, 0);
  digitalWrite(right, 0);
  printf("Target: %f\nActual: %f\n", target, degrees);
  return 0;
}
// Gets the encoder value
void enc_dec(int *dir, int16_t *amount, float *degrees) {
  uint32_t value = fpga_safetran(DATA_ADDR);
  *amount = value & 0xFFFF;
  *dir = value & (1 << 17);
  *degrees = (*amount * 360.0) / CPR;
}
int main(int argc, char *argv[]) {
  signal(SIGINT, intHandler);
  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);
  rotateTo(vals[0], H1A_3, H1A_4);
  return 0;
}

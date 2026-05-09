// #include <stdlib.h>
#include <math.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
// #include <stdio.h>
#include "../../functions.h"
#include "../../pins.h"
#include <signal.h>
#include <stdint.h>
#include <unistd.h>
// #include <signal.h>
#define CPR (663.0 / 6) // Counts per revolution
#define DATA_ADDR ENC_COLUMN_ROTATE
int sigint = 0;
void intHandler(int dummy) { sigint = 1; }

// Gets the encoder value
void enc_dec(int32_t *amount, float *degrees) {
    *amount = fpga_safetran(DATA_ADDR);
//   value;
//   *dir = value & (1 << 17);
    *degrees = (*amount * 360.0) / CPR;
}

int rotateTo(float target_degrees, int left, int right) {
  pinMode(left, OUTPUT);
  pinMode(right, OUTPUT);
  
  int32_t amount;
  float current_degrees;
  enc_dec(&amount, &current_degrees);

  // For an incremental encoder, find the shortest path to the target angle
  float diff = fmodf(target_degrees - current_degrees, 360.0f);
  if (diff > 180.0f) {
    diff -= 360.0f;
  } else if (diff < -180.0f) {
    diff += 360.0f;
  }
  
  float goal_degrees = current_degrees + diff;
  float distance_remaining = fabsf(current_degrees - goal_degrees);

  if (current_degrees > goal_degrees) {
    digitalWrite(left, 0);
    digitalWrite(right, 1);
  } else {
    digitalWrite(left, 1);
    digitalWrite(right, 0);
  }

  while (distance_remaining > 5.0f) {
    if (sigint) {
      digitalWrite(left, 0);
      digitalWrite(right, 0);
      break;
    }
    usleep(10000);
    enc_dec(&amount, &current_degrees);
    distance_remaining = fabsf(current_degrees - goal_degrees);
  }
  
  digitalWrite(left, 0);
  digitalWrite(right, 0);
  printf("Target Goal: %f\nActual: %f\n", goal_degrees, current_degrees);
  return 0;
}

int main(int argc, char *argv[]) {
  signal(SIGINT, intHandler);
  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);
  rotateTo(vals[0], H1A_3, H1A_4);
  return 0;
}

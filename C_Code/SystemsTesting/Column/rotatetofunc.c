// TO BE USED ONLY FOR dirtSample.c; NOT A GENERAL-USE COLUMN CONTROL FUNCTION


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
#define CPR 663.0 / 6 // Counts per revolution
#define DATA_ADDRS ENC_COLUMN_ROTATE 

// -100 is deposit position
// 0 is home

int siggint = 0;
void intHandlerr(int dummy) { siggint = 1; }

// Gets the encoder value
void enc_dec(int32_t *amount, float *degrees) {
    *amount = fpga_safetran(DATA_ADDRS);
//   value;
//   *dir = value & (1 << 17);
    *degrees = (*amount * 360.0) / CPR;
}

int rotateTo(float target, int left, int right) {
  pinMode(left, OUTPUT);
  pinMode(right, OUTPUT);
  // int dir;
  int32_t amount;
  float degrees;
  enc_dec(&amount, &degrees);
  float distance_remaining = fabsf((degrees) - (target));
  if (degrees > target) {
    digitalWrite(left, 0);
    digitalWrite(right, 1);
  } else {
    digitalWrite(left, 1);
    digitalWrite(right, 0);
  }

  while ((distance_remaining) > 0.5) {
    if (siggint) {
      digitalWrite(left, 0);
      digitalWrite(right, 0);
      break;
    }
    usleep(10000);
    enc_dec(&amount, &degrees);
    distance_remaining = fabsf((degrees) - (target));
  }
  digitalWrite(left, 0);
  digitalWrite(right, 0);
  printf("Target: %f\nActual: %f\n", target, degrees);
  return 0;
}

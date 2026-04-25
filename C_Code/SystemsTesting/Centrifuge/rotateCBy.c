#include "../../functions.h"
#include "../../pins.h"
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
// #include <signal.h>
#define LEFTEN 4 // we only move to the left (and only use the left pin)
#define tpr 1018.0

struct PWMinput {
  int pin;
  int *period;
};
long int get_time() {
  struct timeval tv;
  gettimeofday(&tv, NULL);
  return tv.tv_sec * 1E6 + tv.tv_usec;
}
void *softPWM(void *input) {
  long int current_t = get_time();
  // int period = *((int *)input); // 1-100
  struct PWMinput *args = (struct PWMinput *)input;
  printf("Period: %i pin: %i\n", *(args->period), args->pin);
  while (1) {
    digitalWrite(args->pin, 1);
    usleep(*(args->period) * 100);
    digitalWrite(args->pin, 0);
    usleep((100 - *(args->period)) * 100);
  }
}

void rotateBy(int degrees) {
  int period = 0;
  struct PWMinput arguments;
  arguments.pin = LEFTEN;
  arguments.period = &period;
  pthread_t pwmProc;

  // 1. Get current position
  int start_cf = (fpga_safetran(ENC_CENTRIFUGE_ABS));

  // 2. Calculate target position (current + how many teeth we want to move by)
  int target_cf = (start_cf + (degrees * tpr / 360.0));

  // 3. Move the centrifuge
  pinMode(LEFTEN, OUTPUT);
  period = 10;
  // period = vals[0];
  //(to make it manual)
  pthread_create(&pwmProc, NULL, softPWM, &arguments);
  sleep(5);

  // 4. Wait until the target position is reached
  uint32_t fpga_out;
  fpga_out = fpga_safetran(ENC_CENTRIFUGE_ABS);
  float distance_remaining = target_cf - fpga_out;
  while (distance_remaining > 5) {
    if (sigint) {
      digitalWrite(LEFTEN, 0);
      break;
    }
    fpga_out = fpga_safetran(ENC_CENTRIFUGE_ABS);
    distance_remaining = target_cf - fpga_out;
  }
  pthread_cancel(pwmProc);
  pthread_join(pwmProc, NULL);
  digitalWrite(LEFTEN, 0);
}

int main(int argc, char *argv[]) {
  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);

  int degs = vals[0];

  rotateBy(degs);
  return 0;
}

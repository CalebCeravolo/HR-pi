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
#define SPIN_CHANNEL LOAD12_3 // Centrifuge spin pin
#define period_duty 10

static volatile int sigint = 0;

static void intHandler(int dummy) {
  (void)dummy;
  sigint = 1;
  digitalWrite(LEFTEN, 0);
}

static void spin_off(void) {
  digitalWrite(LEFTEN, 0);
}

void spinFor(int duration_seconds) {
  
}
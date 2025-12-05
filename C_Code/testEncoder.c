#include <wiringPi.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "functions.h"
#include "Hall.h"

int hallTriggered(int hallPin);

#define LPWM 32 // connect to pin 1 on ibt2
#define RPWM 35 // connect to pin 2 on ibt2
#define R_EN 36 // connect to pin 3 on ibt2
#define L_EN 37 // connect to pin 4 on ibt2

#define hallPin 3

#define ENC_A 29 
#define ENC_B 31

volatile int position = 0; 
volatile int direction = 0; 

// https://andymark.com/products/neverest-classic-60-gearmotor
// It is a 7 pulses per revolution (ppr), hall effect encoder. 
// Since the motor's gearbox has a 60:1 reduction, then the NeverRest 60 output shaft provides 420 ppr.
 

void encoderA_ISR(void) {
    // Quadrature decoding: check B to determine direction
    if (digitalRead(ENC_B) == HIGH) {
        position++;
        printf("position now: %d\n", position);
    } else {
        position--;
        printf("position now: %d\n", position);
    }
}


int main(int argc, char *argv[]) {

  //wiringPiSetupPinType(WPI_PIN_PHYS);
  if (wiringPiSetupPinType(WPI_PIN_PHYS) ==-1) {
    printf("failed setup");
    return 1;
  };

  //wiringPiSetupPhys();

  pinMode(RPWM, PWM_OUTPUT);
  pinMode(LPWM, PWM_OUTPUT);
  pwmSetMode(PWM_MODE_MS);     // mark-space mode
  pwmSetClock(2);            // 19.2 MHz / 192 = 100 kHz // 192
  pwmSetRange(1024);                                       // 2000


  pinMode(R_EN, OUTPUT);
  pinMode(L_EN, OUTPUT);

  pinMode(hallPin, INPUT);
  pullUpDnControl(hallPin, PUD_UP);

  pinMode(ENC_A, INPUT);
  pinMode(ENC_B, INPUT);

  pullUpDnControl(ENC_A, PUD_UP);  // Enable pull-up
  pullUpDnControl(ENC_B, PUD_UP); // optional I think

  // Attach interrupt to encoder channel A
  wiringPiISR(ENC_A, INT_EDGE_BOTH, &encoderA_ISR); 
  
  

  //pwmSetMode(PWM_MODE_MS);     // mark-space mode
  //pwmSetClock(192);            // 19.2 MHz / 192 = 100 kHz
  //pwmSetRange(2000);           // 100 kHz / 2000 = 50 Hz
          // 150/2000 = 7.5% = 1.5 ms pulse (neutral servo)


  digitalWrite(R_EN, HIGH);
  digitalWrite(L_EN, HIGH);

  printf("Turning one way...\n");
  pwmWrite(RPWM, 1000);
  pwmWrite(LPWM, 0);
  printf("first position: %d\n", position);
  //fpga_pwm(0, 1000);
  //fpga_pwm(1,0);
  delay(2000);

  printf("stop\n");
  pwmWrite(RPWM, 0);
  pwmWrite(LPWM, 0);
  digitalWrite(R_EN, LOW);
  digitalWrite(L_EN, LOW);
  delay(2000);

  //fpga_pwm(0,0);
  //fpga_pwm(1, 1000);

  printf("Turning other way...\n");
  digitalWrite(R_EN, HIGH);
  digitalWrite(L_EN, HIGH);
  pwmWrite(RPWM, 0);
  pwmWrite(LPWM, 1000);
  printf("second position: %d\n", position);
  delay(2000);


  //fpga_pwm(0, 0);
  //fpga_pwm(1,0);
  printf("Final position count: %d\n", position);

  printf("stopping...\n");
  pwmWrite(RPWM, 0);
  pwmWrite(LPWM, 0);
  digitalWrite(R_EN, LOW);
  digitalWrite(L_EN, LOW);


  return 0;
  
}

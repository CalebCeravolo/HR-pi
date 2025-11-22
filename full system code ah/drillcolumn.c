// IBT2 BTS7960
// peak current 47A
// input voltage 6-27V
// PWM capability up to 25kHz
// control input level 3.3-5V
// working duty cycle 0-100%
#include <wiringPi.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

int hallTriggered(int pin);

#define RPWM 32
#define LPWM 33
#define R_EN 36
#define L_EN 37

int main(int argc, char *argv[]) {

  //wiringPiSetupPinType(WPI_PIN_PHYS);
  if (wiringPiSetupPinType(WPI_PIN_PHYS) ==-1) {
    printf("failed setup");
    return 1;
  };

  pinMode(RPWM, PWM_OUTPUT);
  pinMode(LPWM, PWM_OUTPUT);
  pwmSetMode(PWM_MODE_MS);     // mark-space mode
  pwmSetClock(192);            // 19.2 MHz / 192 = 100 kHz
  pwmSetRange(2000);  

  pinMode(R_EN, OUTPUT);
  pinMode(L_EN, OUTPUT);
  //pinMode(RPWM, PWM_OUTPUT);
  //pinMode(LPWM, PWM_OUTPUT);

  

  //pwmSetMode(PWM_MODE_MS);     // mark-space mode
  //pwmSetClock(192);            // 19.2 MHz / 192 = 100 kHz
  //pwmSetRange(2000);           // 100 kHz / 2000 = 50 Hz
          // 150/2000 = 7.5% = 1.5 ms pulse (neutral servo)

  digitalWrite(R_EN, HIGH);
  digitalWrite(L_EN, LOW);
  //spinOneWay();
  pwmWrite(RPWM, 500);
  pwmWrite(LPWM, 0);
  delay(2000);

  digitalWrite(R_EN, LOW);
  digitalWrite(L_EN, HIGH);
  //spinOtherWay();
  pwmWrite(LPWM, 1000);
  pwmWrite(RPWM, 0);
  delay(2000);

  return 0;
  
}

/*
void spinOneWay() {
  pwmWrite(RPWM, 1000);
  pwmWrite(LPWM, 0);
}

void spinOtherWay() {
  pwmWrite(LPWM, 1000);
  pwmWrite(RPWM, 0);
}

*/


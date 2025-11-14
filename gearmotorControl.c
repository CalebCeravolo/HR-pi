#include <wiringPi.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

#define RPWM 32
#define LPWM 33
#define R_EN 36
#define L_EN 37

#define ENC_A 29
#define ENC_B 31

volatile int position = 0; 

void encoderA_ISR(void) {
    // Quadrature decoding: check B to determine direction
    if (digitalRead(ENC_B) == HIGH) {
        position++;
    } else {
        position--;
    }
}

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

  pinMode(ENC_A, INPUT);
  pinMode(ENC_B, INPUT);

  //pullUpDnControl(ENC_A, PUD_UP);  // Enable pull-up
  //pullUpDnControl(ENC_B, PUD_UP); // optional I think

  // Attach interrupt to encoder channel A
  wiringPiISR(ENC_A, INT_EDGE_BOTH, &encoderA_ISR); 
  
  

  //pwmSetMode(PWM_MODE_MS);     // mark-space mode
  //pwmSetClock(192);            // 19.2 MHz / 192 = 100 kHz
  //pwmSetRange(2000);           // 100 kHz / 2000 = 50 Hz
          // 150/2000 = 7.5% = 1.5 ms pulse (neutral servo)

  digitalWrite(R_EN, HIGH);
  digitalWrite(L_EN, HIGH);
  //spinOneWay();
  pwmWrite(RPWM, 1000);
  pwmWrite(LPWM, 0);
  delay(2000);

  digitalWrite(R_EN, LOW);
  digitalWrite(L_EN, HIGH);
  //spinOtherWay();
  pwmWrite(LPWM, 1000);
  pwmWrite(RPWM, 0);
  delay(2000);

  printf("Final position count: %d\n", position);

  return 0;
  
}

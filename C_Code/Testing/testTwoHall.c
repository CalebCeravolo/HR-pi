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

  int state;
  int last_state = 0;
  while (1){
        state = digitalRead(hallPin);
            if (state==0){
                printf("MAGNET!!!\n");
                printf("stop\n");
                pwmWrite(RPWM, 0);
                pwmWrite(LPWM, 0);
                digitalWrite(R_EN, LOW);
                digitalWrite(L_EN, LOW);
                break;
                //delay(3000);
            }
            
            digitalWrite(R_EN, HIGH);
            digitalWrite(L_EN, HIGH);
            pwmWrite(RPWM, 1000);
            pwmWrite(LPWM, 0);
    }
    
return 0;       
  
}
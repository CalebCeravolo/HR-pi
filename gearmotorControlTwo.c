// DON'T USE!!!!


#include <wiringPi.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "functions.h"

#define RPWM 32 // connect to pin 1 on ibt2
#define LPWM 33 // connect to pin 2 on ibt2
#define R_EN 36 // connect to pin 3 on ibt2
#define L_EN 37 // connect to pin 4 on ibt2

#define ENC_A 29
#define ENC_B 31

volatile int position = 0; 
volatile int direction = 0; 

void readEncoder(void) {
    int stateA = digitalRead(ENC_A);
    int stateB = digitalRead(ENC_B);

    if (stateA > stateB) {
        position ++;
        direction = 1;
    }
    else {
        position--;
        direction = -1;
    }

    /*
     if (stateA == stateB) { // makes no sense DON'T USE THIS CODE
        position++;
        direction = 1;
    } else {
        position--;
        direction = -1;
    }
    */
   
}

int main(void) {
    //wiringPiSetup();  // Initialize wiringPi
    if (wiringPiSetupPinType(WPI_PIN_PHYS) ==-1) {
        printf("failed setup");
        return 1;
    };

    pinMode(ENC_A, INPUT);
    pinMode(ENC_B, INPUT);

    // Attach interrupts (wiringPi ISR)
    // INT_EDGE_BOTH gets the edge of the square wave
    wiringPiISR(ENC_A, INT_EDGE_BOTH, &readEncoder);
    wiringPiISR(ENC_B, INT_EDGE_BOTH, &readEncoder);

    while (1) {
        printf("Position: %d | Direction: %s\n",
               position, direction > 0 ? "Clockwise" : "Counterclockwise");
        delay(1000); // wiringPi delay (ms)
    }

    return 0;
}
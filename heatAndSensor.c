#include <wiringPi.h>
#include <stdio.h>
#include <stdint.h>

// turn on both heater and sensor
// when sensor senses certain temperature, turn off heater


#define RPWM 32 // connect to pin 1 on ibt2
#define LPWM 33 // connect to pin 2 on ibt2
#define R_EN 36 // connect to pin 3 on ibt2
#define L_EN 37 // connect to pin 4 on ibt2

int main(int argc, char *argv[]) {
    

}
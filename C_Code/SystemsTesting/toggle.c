
#include <wiringPi.h>
#include <wiringPiSPI.h>
// #include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "../functions.h"
//#include <signal.h>
int main(int argc, char *argv[]) {
    wiringPiSetupPinType(WPI_PIN_WPI);
    int vals[argc-1];
    intparse(argc-1, argv+1, vals);
    if (vals[0]==1){
        getAlt(pin);
        
    } else {
        
    }
    if (argc>1){
        
    }
    // sleep(1);
    // digitalWrite(RIGHTEN, 0);
    // digitalWrite(LEFTEN, 1);
    // sleep(5);
    // pinMode(LEFTEN, PM_OFF);
    // pinMode(RIGHTEN, PM_OFF);
}
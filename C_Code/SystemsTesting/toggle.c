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
    int mode = getAlt(vals[0]);
    if (mode==1){
        digitalWrite(vals[0], ~digitalRead(vals[0]));
        return 0;
    } else {
        pinMode(vals[0], OUTPUT);
        digitalWrite(vals[0], 1);
        return 0;
    }
}
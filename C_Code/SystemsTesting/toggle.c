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
    for (int i=0; i<argc-1; i++){
        int mode = getAlt(vals[i]);
    
    if (mode==1){
        // printf("%i\n", !digitalRead(vals[0]));
        digitalWrite(vals[i], !digitalRead(vals[i]));
        // return 0;
    } else {
        pinMode(vals[0], OUTPUT);
        digitalWrite(vals[i], 1);
        // return 0;
    }
    }
    return 0;
}
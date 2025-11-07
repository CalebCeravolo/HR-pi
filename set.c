#include <stdio.h>
#include <wiringPi.h>
#include <stdint.h>


// General code file I use to generate all set all commands
int main(int argc, char *argv[]){
    wiringPiSetupPinType(WPI_PIN_WPI);
    //printf("The casted value is %d\n", (int)(**(argv+1))-(int)'0');
    for (int i=0; i<32; i++){
        pinMode(i, PWM_OUTPUT);
        //digitalWrite(i, (int)(**(argv+1))-(int)'0');
        //digitalWrite(i, PWM_OUTPUT);
    }
    return 0;
}

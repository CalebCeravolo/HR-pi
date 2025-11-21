#include <stdio.h>
#include <wiringPi.h>
#include <stdint.h>
#define hallPin 0
// General code file I use to generate all set all commands
int main(int argc, char *argv[]){
    int state;
    int last_state = 0;
    wiringPiSetupPinType(WPI_PIN_WPI);
    pinMode(hallPin,INPUT);
    pullUpDnControl(hallPin, PUD_UP);
    //printf("The casted value is %d\n", (int)(**(argv+1))-(int)'0');
    while (1){
        state = digitalRead(hallPin);
        if (state!=last_state){
            if (state==0){
                printf("MAGNET!!!\n");
            }
            else if (state==1){
                printf("No more magnet\n");
            }
            last_state=state;
        }
        delay(100);
    }
    return 0;
}

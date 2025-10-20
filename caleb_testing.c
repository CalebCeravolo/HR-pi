#include <wiringPi.h>
#include <stdio.h>
#include <stdint.h>

int length_of(char *);
int to_int(char *);

int main(int argc, char *argv[]){
    if (argc<2){
        return 1;
    }
    wiringPiSetupPinType(WPI_PIN_WPI);  // must be hardware PWM pin
    int pin = to_int(*(argv+1));
    int alt = getAlt(pin);
    printf("Alt: %d\n", alt);
    return 0;
}
int to_int(char * input){
    int val = 0;
    int argument;
    int length = length_of(input);
    int dec = 1;
    for (int i=length-1; i>=0; i--){
        argument = (int)(*(input+i))-(int)'0';
        val+=dec*argument;
        dec*=10;
    }
    return val;
}
int length_of(char * point){
    int length = 0;
    for (int i=0; *(point+i)!='\0'; i++){
        length++;
    }
    return length;
}
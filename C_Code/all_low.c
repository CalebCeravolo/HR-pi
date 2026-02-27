// #include <stdio.h>
#include <wiringPi.h>
#include <stdint.h>

int not_in(int, int*, int);
// General code file I use to generate all set all commands
int main(int argc, char *argv[]){
    wiringPiSetupPinType(WPI_PIN_WPI);
    //printf("The casted value is %d\n", (int)(**(argv+1))-(int)'0');
    int not_list[7] = {10, 12, 13, 14, 8, 9, 7};
    for (int i=0; i<32; i++){
        if (not_in(i, not_list, 7)){
            pinMode(i, OUTPUT);
            digitalWrite(i,0);
        }
        //digitalWrite(i, (int)(**(argv+1))-(int)'0');
        //digitalWrite(i, PWM_OUTPUT);
    }
    return 0;
}

int not_in(int num, int* list, int len){
    for (int i=0; i<len; i++){
        if (num==*(list+i)){
            return 0;
        }
    }
    return 1;
}
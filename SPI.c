#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include "functions.h"
//#include <signal.h>
#define pin 23
void print_arr(char * output, int length){
    for (int i = 0; i < length; i++) {
        // if (i%4==0){
        //     printf("| ");
        // }
        printf("%X ", output[i]);
    }
    printf("\n");
}
int main(int argc, char *argv[]) {
    int vals[argc-1];
    argparse(argc-1, argv+1, vals);
    uint32_t result=fpga_pwm(*vals, *(vals+1));
}

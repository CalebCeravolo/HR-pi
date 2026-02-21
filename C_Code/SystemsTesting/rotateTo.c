#include <wiringPi.h>
#include <wiringPiSPI.h>
// #include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "../functions.h"
#include "../pins.h"
#include <unistd.h>
//#include <signal.h>
#define left H1A_3
#define right H1A_4
#define CPR 663.0     // Counts per revolution
#define DATA_ADDR 5

// Gets the encoder value
void enc_dec(int* dir, int16_t* amount, float* degrees){
    uint32_t value = fpga_safetran(DATA_ADDR)&(0xFFFF);
    *amount = value&0xFFFF;
    *dir = value&(1<<17);
    *degrees = (*amount*360)/CPR;
}
int main(int argc, char *argv[]) {
    wiringPiSetupPinType(WPI_PIN_WPI);
    int vals[argc-1];
    intparse(argc-1, argv+1, vals);
    pinMode(left, OUTPUT);
    pinMode(right, OUTPUT);
    int dir;
    int16_t amount;
    float degrees;
    enc_dec(&dir, &amount, &degrees);
    if (degrees>vals[0]){
        digitalWrite(left, 0);
        digitalWrite(right,1);
    } else {
        digitalWrite(left, 1);
        digitalWrite(right,0);
    }
    
    while ((degrees)-(vals[0])>5){
        usleep(10000);
        enc_dec(&dir, &amount, &degrees);
    }
    
    printf("Target: %i\nActual: %f", vals[0], degrees);
    return 0;
    // uint32_t result = fpga_safetran(DATA_ADDR)&(0xFFFF);
    

    // digitalWrite(LEFTEN, 1);
    // sleep(5);
    
}



#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
//#include <signal.h>
#define pin 23
int spi_setup();
int length_of(char *);
int main(int argc, char *argv[]) {
    if (spi_setup()){
        printf("Setup failed\n");
        return -1;
    }

    if (argc>1){
        int val = 0;
        int argument;
        int length = length_of(*(argv+1));
        int dec = 1;
        for (int i=length-1; i>=0; i--){
            argument = (int)(*(*(argv+1)+i))-(int)'0';
            val+=dec*argument;
            dec*=10;
        }
    }
    unsigned char data[9] = {0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0xAA, 0x55, 0x67};
    wiringPiSPIDataRW(0, data, 9);  // full-duplex
    printf("Received: %d %d %d %d %d %d %d %d\n", data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]);
    wiringPiSPIClose(0);
    //uint8_t val = argument;
    // if (argument==0){
    //     val = 100;
    // } else if (argument==1){
    //     val= 200;
    // } else {
    //     val = 150;
    // }
}

int spi_setup(){
    int channel = 0;  // 0 → /dev/spidev0.0, 1 → /dev/spidev0.1
    int speed = 1000000; // 1 MHz
    if (wiringPiSPISetup(channel, speed) < 0) {
        perror("SPI setup failed");
        return 1;
    }
    return 0;
}

int length_of(char * point){
    int length = 0;
    for (int i=0; *(point+i)!='\0'; i++){
        length++;
    }
    return length;
}
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include "functions.h"
//#include <signal.h>

/*
The accuracy of the rotations can be increased by adding a resistor between the encoder signals and the fpga pins
*/
#define pin 23
int main(int argc, char *argv[]) {
    int long_result;
    int16_t result;
    fpga_datatran(1);
    long_result = fpga_datatran(1);
    result=long_result&(0xFFFF);
    printf("%d\n", result);
    wiringPiSetupPinType(WPI_PIN_WPI);
    pinMode(25, OUTPUT);
    digitalWrite(25, 1);
    delay(1);
    digitalWrite(25,0);
    delay(1);
    fpga_pwm(0,0);
    fpga_pwm(1,2000);
    fpga_datatran(1);
    long_result = fpga_datatran(1);
    result=long_result&(0xFFFF);
    while (result/420<5){
      long_result = fpga_datatran(1);
      result=long_result&(0xFFFF);
      // printf("%d\n", result);
      delay(15);
    }
    print_bin(32,result);
    printf("%d\n", result);
    fpga_pwm(1,0);
    fpga_pwm(0,2000);
    while (result>0){
      long_result = fpga_datatran(1);
      result=long_result&(0xFFFF);
      // printf("%d\n", result);
      delay(15);
    }
    fpga_pwm(0,0);
    print_bin(32,result);
    printf("%d\n", result);
}

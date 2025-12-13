//Code spins motor for random time, then stops and compares position, and 
//spins until the desired input position



#include "functions.h"
#include <stdlib.h> //library for rand();

#define motor1 1

void main() {
    int count = rand();
    count = (count >>20) + 1000;
    printf("Time of spinning is %i\n", count/1000);
    int final_position = 1000; //edit later with final positional value
    fpga_pwm(motor1, 1000);
    delay(count);

    fpga_pwm(motor1, 0);
    delay(1000);
    uint16_t position = fpga_datatran(1)&(0xFFFF); //splice off position

    while (position < final_position) { //spin until positions match
        uint16_t position = fpga_datatran(1)&(0xFFFF);
        fpga_pwm(motor1, 500);
    }
    fpga_pwm(motor1, 0);
}
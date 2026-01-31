#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include "../functions.h"
//#include <signal.h>

#define pin 23

int main(int argc, char *argv[]) {
    int vals[argc-1];
    argparse(argc-1, argv+1, vals);
    uint32_t period = (argc>3 ? *(vals+2) : 2000);
    fpga_pwm_period(*vals, period);
    uint32_t result=fpga_pwm_uptime(*vals, *(vals+1));

    print_bin(32,result);

    
}
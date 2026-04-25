#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include "../functions.h"
#include "../pins.h"
//#include <signal.h>
// #define pin 23
int main(int argc, char *argv[]) {
    // int vals[argc-1];
    // intparse(argc-1, argv+1, vals);
    uint32_t result=fpga_safetran(ENC_CENTRIFUGE_ABS);
    printf("%f\n", ((result-1)*360)/1018.0);

    // print_bin(32,result);
}

#include <wiringPi.h>
#include "../functions.h"
#define DEVICE_ID 0x39
#define COMMAND_REGISTER_BIT 0x80
#define MULTI_BYTE_BIT 0x20
void main(int argc, char *argv[]){
    int[argc-1] vals;
    intparse(argc, argv, output)
    int fd = wiringPiI2CSetup(DEVICE_ID);
    if (fd == -1) {
        printf("Failed to init I2C communication.\n");
        return -1;
    }
    wiringPiI2CWriteReg8(fd, COMMAND_REGISTER_BIT, 0b00000011);
    wiringPiI2CReadReg8(fd, )
}
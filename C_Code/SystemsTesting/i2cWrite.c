#include <wiringPi.h>
#include <wiringPiI2C.h>
#include "../functions.h"
#define DEVICE_ID 0x39
#define COMMAND_REGISTER_BIT 0x80

#define MULTI_BYTE_BIT 0x20
int main(int argc, char *argv[]){
    int vals[argc-1];
    intparse(argc, argv, vals);
    // printf("%x",(uint8_t)vals[0]);
    int fd = wiringPiI2CSetup(DEVICE_ID);
    if (fd == -1) {
        printf("Failed to init I2C communication.\n");
        return -1;
    }
    wiringPiI2CWriteReg8(fd, COMMAND_REGISTER_BIT | 0x00, 0b00000011);
    uint8_t result = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x00);
    printf("Result: %x\n", result);
    return 0;

}
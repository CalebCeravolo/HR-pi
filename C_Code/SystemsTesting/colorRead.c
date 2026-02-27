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
    int redb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x16);
    int greenb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x18);
    int blueb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x1a);

    uint8_t redt = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x17);
    uint8_t greent = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x19);
    uint8_t bluet = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x1b);
    printf("Red: %d\nGreen:%d\nBlue:%d\n", redb|(redt<<8), greenb|(greent<<8), blueb|(bluet<<8));
    // printf("Red: %d\nGreen:%d\nBlue:%d\n", redt, greent, bluet);
    return 0;
}
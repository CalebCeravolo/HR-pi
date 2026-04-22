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

    // Integration Time Register
    wiringPiI2CWriteReg8(fd, COMMAND_REGISTER_BIT | 0x81, 0b00000000); 

    // Control Register One (Gain)
    wiringPiI2CWriteReg8(fd, COMMAND_REGISTER_BIT | 0x81, 0b00000010); 

    // Enable Register
    wiringPiI2CWriteReg8(fd, COMMAND_REGISTER_BIT | 0x80, 0b00000011); 

    while (1) {
        uint8_t status;
        do {
            status = wiringPiI2CReadReg8(fd, COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x93)
        } while (!(status & 0x01));

        uint8_t clearb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x94);
        uint8_t redb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x96);
        uint8_t greenb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x98);
        uint8_t blueb = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x9A);

        uint8_t cleart = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x95);
        uint8_t redt = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x97);
        uint8_t greent = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x99);
        uint8_t bluet = wiringPiI2CReadReg8(fd,  COMMAND_REGISTER_BIT | MULTI_BYTE_BIT | 0x9B);

        uint16_t clear = clearb | (cleart << 8);
        uint16_t red = redb | (redt << 8);
        uint16_t green = greenb | (greent << 8);
        uint16_t blue = blueb | (bluet << 8);

        if (clear > 0) {
            float r = (float) red / clear;
            float g = (float) green / clear;
            float b = (float) blue / clear;

            printf("\033[1A\033[2K\r\033[1A\033[2K\r\033[1A\033[2K\r");
            printf("Red: %d\nGreen:%d\nBlue:%d\n", r, g, b);
        }
        
        return 0;
    }
    
}

#include <wiringPi.h>
#include <wiringPiI2C.h>
#include "../functions.h"
#define DEVICE_ID 0x39
#define COMMAND_REGISTER_BIT 0x80
#define MULTI_BYTE_BIT 0x20
int main(int argc, char *argv[]){
    int vals[argc-1];
    //intparse(argc, argv, vals);
    // printf("%x",(uint8_t)vals[0]);
    int fd = wiringPiI2CSetup(DEVICE_ID);
    if (fd == -1) {
        printf("Failed to init I2C communication.\n");
        return -1;
    }
    // enable 0b00000011 is another way of writing 0x03 = 3 with 0x meaning hex 
    // 0x80 enables register -> command register bit, 0x03 enables AEN and PON (power on)
    wiringPiI2CWriteReg8(fd, COMMAND_REGISTER_BIT, 0b00000011); 

    //0x81: integration time.
    wiringPiI2CWriteReg8(fd, 0x81, 0b00000000);

    //-added-
    //sets the wait long time - when asserted, wait cycles are increased by a in 
    // factor 12x from that programmed the WTIME resgister
    // 0b00000010 = 0x02
    // 0x8D: configuration register 1, sets wait long time
    wiringPiI2CWriteReg8(fd, 0x8D, 0b00000010); // configuration

    //-added-
    // provides RGBC gain settings and a control for managing proximity reading 
    // in event the analog circuitry becomes satruated 
    // bit 5 must be set=1
    // AGAIN 1:0 field value 00 -> 1x, 01 -> 4x, 10 -> 16x, 11 -> 60x
    // 3:2 reserved 00
    // PSAT 4 0 -> PDATA output regardless of ambient light level
    // PSAT 4 1 -> PDATA output equalt to dark current value if saturated
    // 5 reserved 1
    // PDRIVE 7:6 00 -> 100%, 01 -> 50%, 10 -> 25%, 11 -> 12.5% 
    // 00       1            1              00         10 
    // 100%  reserved  dark_if_saturated  reserved  16x_gain
    // 0x8F: control register one
    wiringPiI2CWriteReg8(fd, 0x8F, 0b00110011); // gain control register

    // makes sure data is ready before reading
    uint8_t status;
    do{
        status = wiringPiI2CReadReg8(fd, 0x93);
    } while (!(status & 0x01));  // keeps waiting until AVALID = 1, then runs code below.
    
    int redb = wiringPiI2CReadReg8(fd, 0x96);
    int greenb = wiringPiI2CReadReg8(fd, 0x98);
    int blueb = wiringPiI2CReadReg8(fd, 0x9A);

    uint8_t redt = wiringPiI2CReadReg8(fd, 0x97);
    uint8_t greent = wiringPiI2CReadReg8(fd, 0x99);
    uint8_t bluet = wiringPiI2CReadReg8(fd, 0x9B);

    int raw_r = redb   | (redt   << 8);
    int raw_g = greenb | (greent << 8);
    int raw_b = blueb  | (bluet  << 8);
    printf("Raw - Red: %d  Green: %d  Blue: %d\n", raw_r, raw_g, raw_b);

    // Calibration: point sensor at a white surface, record raw values, fill in below.
    // Scale factors normalize all channels to match WHITE_R.
    #define WHITE_R 33366.0f
    #define WHITE_G 24910.0f  // replace with your green reading on white
    #define WHITE_B 22926.0f  // replace with your blue reading on white

    int cal_r = raw_r;
    int cal_g = (int)(raw_g * (WHITE_R / WHITE_G));
    int cal_b = (int)(raw_b * (WHITE_R / WHITE_B));
    printf("Cal - Red: %d  Green: %d  Blue: %d\n", cal_r, cal_g, cal_b);

    return 0;
}

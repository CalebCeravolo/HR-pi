#include <stdio.h>
#include <wiringPi.h>
#include <stdint.h>

int main (void)
{
    int i, led ;
    printf("running maybe...");
     
    wiringPiSetupPinType(WPI_PIN_PHYS);

    pinMode(1, PWM_OUTPUT);

    while (1) {
        for (int i = 0; i < 1024; i++) {
            pwmWrite(1, i);
            delay(10);
        }

        for (int i = 1023; i > 0; i--) {
            pwmWrite(1, i);
            delay(10);
        }
    }

    return 0;

}
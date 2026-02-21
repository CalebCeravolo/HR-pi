#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "../functions.h"
#include <pthread.h>
#include <sys/time.h>
#define LEFTEN 4//4
#define RIGHTEN 5//5
struct PWMinput {
    int pin;
    int* period;
};
void* softPWM(void* input){
    // int period = *((int *)input); // 1-100
    struct PWMinput* args = (struct PWMinput*)input;
    printf("Period: %i pin: %i\n", *((args)->period), (args)->pin);
    while (1){
        digitalWrite(args->pin, 1);
        usleep(*((args)->period)*100);
        digitalWrite((args)->pin, 0);
        usleep((100-*((args)->period))*100);
    }
}

int main(int argc, char *argv[]) {
    wiringPiSetupPinType(WPI_PIN_WPI);
    float vals[argc-1];
    floatparse(argc-1, argv+1, vals);
    int period = 0;
    struct PWMinput arguments;
    arguments.pin = LEFTEN;
    arguments.period = &period;
    pthread_t pwmProc;
    pinMode(LEFTEN, OUTPUT);
    pinMode(RIGHTEN, OUTPUT);
    digitalWrite(RIGHTEN, 0);
    period = vals[0];

    pthread_create(&pwmProc, NULL, softPWM, &arguments);
    
    usleep(1000*vals[1]);

    pthread_cancel(pwmProc);
    pthread_join(pwmProc, NULL); 

    pinMode(LEFTEN, PM_OFF);
    pinMode(RIGHTEN, PM_OFF);
    return 0;
}
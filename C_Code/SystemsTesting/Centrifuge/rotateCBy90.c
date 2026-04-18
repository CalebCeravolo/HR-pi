#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "../../functions.h"
#include <time.h>
#include <sys/time.h>
#include <pthread.h>
//#include <signal.h>

#define LEFTEN 4 //we only move to the left (and only use the left pin)
#define tpr 30 //ticks per revolution
// It is impossible to actually achieve a 90 degree rotation with this encoder
// because it has teeth at every 1/30th of a revolution so it is impossible
// to land on exactly 90 degrees. We land on 84 degrees.

struct PWMinput {
    int pin;
    int* period;
};

long int get_time(){
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec*1E6 + tv.tv_usec;
}

void* softPWM(void* input){
    long int current_t = get_time();
    // int period = *((int *)input); // 1-100
    struct PWMinput* args = (struct PWMinput*)input;
    printf("Period: %i pin: %i\n", *(args->period), args->pin);
    while (1){
        digitalWrite(args->pin, 1);
        usleep(*(args->period)*100);
        digitalWrite(args->pin, 0);
        usleep((100-*(args->period))*100);
    }
}

void rotate90() {
    int period = 0;
    struct PWMinput arguments;
    arguments.pin = LEFTEN;
    arguments.period = &period;
    pthread_t pwmProc;
    
    // 1. Get current position
    int start_cf = (fpga_safetran(1)&(0xFFFF)) % tpr;
    
    // 2. Calculate target position (current + 90 degrees)
    int target_cf = (start_cf + (tpr / 4) % tpr;

    // 3. Move the centrifuge
    pinMode(LEFTEN, OUTPUT);
    period = 75;
    //period = vals[0];
    //(to make it manual)
    pthread_create(&pwmProc, NULL, softPWM, &arguments);
    sleep(5);    
    
    // 4. Wait until the target position is reached
    uint32_t fpga_out;
    while(1) {
        fpga_out = fpga_safetran(1) & 0xFFFF;
        if (fpga_out % tpr == target_cf) {
            break;
        }
    }
    pthread_cancel(pwmProc);
    pthread_join(pwmProc, NULL);  
    digitalWrite(LEFTEN, 0);
}

int main(int argc, char *argv[]) {
    wiringPiSetupPinType(WPI_PIN_WPI);
    int vals[argc-1];
    intparse(argc-1, argv+1, vals);

    rotate90();
    return 0;
}


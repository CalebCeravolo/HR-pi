#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdio.h>
#include <stdint.h>
#include "../functions.h"
#include <time.h>
#include <sys/time.h>
#include <signal.h>

struct timespec start, end;
#define ASCII_ESC 27
//#include <signal.h>
static volatile int sigint = 0;
void intHandler(int dummy) {
    printf("\b\b%c[2K", ASCII_ESC);
    sigint = 1;
}

long int get_time(){
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec*1E6 + tv.tv_usec;
}

int main(int argc, char *argv[]) {
    int vals[argc-1];
    argparse(argc-1, argv+1, vals);
    uint32_t result;
    long int errors = 0;
    int percent = 0;
    int lastPercent = 0;

    printf("%c[?25l", ASCII_ESC);
    printf("Testing %i times\n", vals[0]);
    printf("0 Percent");


    clock_t start = clock(), diff;
    
    long int startt = get_time();
    fpga_datatran(3);
    fpga_pwm(5, 2000);
    for (long i=0; i<vals[0]; i++){
        result=fpga_pwm(5, 2000);
        percent=((i+1)*100)/vals[0];
        printf("\r%li Percent", percent);
        lastPercent=percent;
        // if (percent!=lastPercent){
            
        //     lastPercent=percent;
        // }
        
        if (result!=0b00000000000000000010111111010000){
            // printf("%c[%iB\nError: ", ASCII_ESC, errors-1);
            errors++;
            // print_bin(32, result);
            // printf("%c[%iA",ASCII_ESC, errors+1);
        }
        if (sigint){
            vals[0]=(i+1);
            break;
        }
    }
    fpga_pwm(5, 0);
    long int stopt = get_time();
    diff = clock() - start;
    float difft = (stopt-startt)/(1E6);
    FILE* ptr;
      // File opened
    ptr = fopen("./tran_rate.txt", "a");
    fprintf(ptr, "Error rate: %i/%i\n", errors, vals[0]);
    float sec = (float)diff / CLOCKS_PER_SEC;
    fprintf(ptr, "Time elapsed: %fs\n", sec);
    fprintf(ptr, "Average tran rate: %f Mbits/s\n\n", vals[0]*32/(sec*1E6));
    fprintf(ptr, "Average tran rate CPU time: %f Mbits/s\n", vals[0]*32/(sec*1E6));
    fprintf(ptr, "Average tran rate total: %f Mbits/s\n", vals[0]*32.0/(difft*1E6));
    fclose(ptr);
    printf("\nError rate: %i/%i\n", errors, vals[0]);
    printf("%c[?25h", ASCII_ESC);
    printf("CPU Time elapsed: %fs\n", sec);
    printf("Total Time elapsed: %fs\n", difft);
    printf("Average tran rate CPU time: %f Mbits/s\n", vals[0]*32/(sec*1E6));
    printf("Average tran rate total: %f Mbits/s\n", vals[0]*32.0/(difft*1E6));
}

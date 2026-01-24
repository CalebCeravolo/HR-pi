#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include "functions.h"

#define SPIFREQ 5E6
#define SETPERIOD 2
#define GETDATA 1
#define SETUPTIME 0
//#define TESTING 1
#ifdef TESTING
    int main(int argc, char** argv){
        int *output = malloc((argc-1) * sizeof(int));
        argparse(argc-1, argv+1, output);
        //print_bin(8, (*output)<<*(output+1));
        printf("%d", (int)'\0');
        //printf("%X", print);
        // for (int i=0; i<argc-1; i++){
        //     printf("%d ", *(output+i));
        // }
        printf("\n");
    }
#endif

void print_arr(void * input, int len){
    char* ch=(char *)input;
    for (int i=0; i<len; i++){
        printf("%X ", *(ch+i));
    }
    printf("\n");
}
void print_bin(int len, int in){
    for (int i=0; i<len; i++){
        printf("%d", ((1<<(len-1-i))&in)&&1);
    }
    printf("\n");
}

// Converts uint32_t to character array
void to_char_array(uint32_t base, char * output){
    uint8_t mask=0xFF;
    for (int i=0; i<4; i++){
        
        *(output+i)=(base&(mask<<8*(3-i)))>>(8*(3-i));
    }
}

// Converts character string to integer
int char_to_int(char * arg){
    int res = 0;
    uint8_t negative = *arg=='-';
    for (int i=negative; *(arg+i)!='\0'; i++){
        res*=10;
        res+=(int)(*(arg+i))-(int)'0';
    }
    return (negative ? -1*res : res);
}
void argparse(int argc, char** args, int * output){
    for (int i=0; i<argc; i++){
        *(output+i)=char_to_int(*(args+i));
    }
}
uint32_t fpga_raw(uint32_t outgoing){
    if (wiringPiSPISetup(0, SPIFREQ)<0){
        perror("Setup failed\n");
        return -1;
    }
    uint32_t base = 0;
    unsigned char output[4];
    base=outgoing;
    //print_bin(32, base);
    to_char_array(base, output);
    //print_arr(output, 4);
    wiringPiSPIDataRW(0, output, 4);
    uint32_t result = to_uint_value(output);
    wiringPiSPIClose(0);
    return result;
}
uint32_t fpga_pwm_uptime(uint8_t motor, uint32_t pwm_uptime){
    if (wiringPiSPISetup(0, SPIFREQ)<0){
        perror("Setup failed\n");
        return -1;
    }
    uint32_t base = 0;
    unsigned char output[4];
    uint32_t result1, result2;
    base|=(SETUPTIME<<26);
    base|=(pwm_uptime);
    base|=(motor<<21);
    // print_bin(32, base);a
    to_char_array(base, output);
    //print_arr(output, 4);
    fpga_fasttran(7, &result1);
    wiringPiSPIDataRW(0, output, 4);
    result2 = to_uint_value(output);
    int errors=0;
    while(result2!=base){
        errors++;
        if (errors>=10){
            printf("Command pwm uptime failed: \n");
            print_bin(32, base);
            print_bin(32, result2);
            wiringPiSPIClose(0);
            return result2;
        }
        to_char_array(base, output);
        wiringPiSPIDataRW(0, output, 4);
        result2 = to_uint_value(output);
    }
    wiringPiSPIClose(0);
    return result2;
}

uint32_t fpga_pwm_period(uint8_t motor, uint32_t pwm_period){
    if (wiringPiSPISetup(0, SPIFREQ)<0){
        perror("Setup failed\n");
        return -1;
    }
    uint32_t base = 0;
    unsigned char output[4];
    uint32_t result1, result2;
    base|=(pwm_period);
    base|=(motor<<21);
    base|=(SETPERIOD<<26);
    //print_bin(32, base);
    to_char_array(base, output);
    //print_arr(output, 4);
    fpga_fasttran(7, &result1);
    wiringPiSPIDataRW(0, output, 4);
    result2 = to_uint_value(output);
    int errors=0;
    while(result2!=base){
        errors++;
        if (errors>=10){
            printf("Command pwm period failed: %i, %i\n", result2, base);
            wiringPiSPIClose(0);
            return result2;
        }
        to_char_array(base, output);
        wiringPiSPIDataRW(0, output, 4);
        result2 = to_uint_value(output);
    }
    wiringPiSPIClose(0);
    return result2;
}



uint32_t fpga_datatran(uint8_t data_addr){
    if (wiringPiSPISetup(0, SPIFREQ)<0){
        perror("Setup failed\n");
        return -1;
    }
    uint8_t command = 0b00000001;
    uint32_t base = 0;
    unsigned char output[4];
    base|=data_addr;
    base|=(command<<26);
    //print_bin(32, base);
    to_char_array(base, output);
    // print_arr(output, 4);
    wiringPiSPIDataRW(0, output, 4);
    uint32_t result = to_uint_value(output);
    wiringPiSPIClose(0);
    return result;
}

uint32_t fpga_safetran(uint8_t data_addr){
    if (wiringPiSPISetup(0, SPIFREQ)<0){
        perror("Setup failed\n");
        return -1;
    }
    uint8_t command = 0b00000001;
    uint32_t base = 0;
    unsigned char output[4];
    base|=data_addr;
    base|=(command<<26);

    //print_bin(32, base);
    // print_arr(output, 4);
    to_char_array(base, output);
    wiringPiSPIDataRW(0, output, 4);
    to_char_array(base, output);
    wiringPiSPIDataRW(0, output, 4);
    uint32_t result = to_uint_value(output);
    wiringPiSPIClose(0);
    return result;
}
void fpga_fasttran(uint8_t data_addr, uint32_t* result){
    uint8_t command = 0b00000001;
    uint32_t base = 0;
    unsigned char output[4];
    base|=data_addr;
    base|=(command<<26);
    to_char_array(base, output);
    wiringPiSPIDataRW(0, output, 4);
    *result = to_uint_value(output);
}
uint32_t to_uint_value(char * input){
    uint32_t out;
    for (int i=0; i<4; i++){
        out|=*(input+(3-i))<<8*i;
    }
    return out;
}
int length_of(char * point){
    int length = 0;
    for (int i=0; *(point+i)!='\0'; i++){
        length++;
    }
    return length;
}
#ifndef FPGA_UTILS_H
#define FPGA_UTILS_H

#include <stdint.h>
#include <stdio.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>

// Function declarations
extern int char_to_int(char * arg);
extern void print_bin(int, int);
/*
Turns a list of args into ints
Inputs: 
argc: length of args
args: list of strings
output: int list to be overwritten
*/
extern void argparse(int argc, char** args, int * output);
void copy(char* arr1, char* arr2, int length);
void to_char_array(uint32_t base, char * output);
extern uint32_t fpga_pwm(uint8_t motor, uint16_t pwm_period);
extern uint32_t to_uint_value(char * input);
extern int length_of(char * point);

#endif // FPGA_UTILS_H

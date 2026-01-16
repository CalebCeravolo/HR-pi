#ifndef FPGA_UTILS_H
#define FPGA_UTILS_H

#include <stdint.h>
#include <stdio.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>

// Function declarations
/*
Converts a string to an integer
arg: The pointer to the string
output: int value of string
*/
extern int char_to_int(char * arg);
/*
Prints the binary representation of a number 
len: Length of output binary number
in: Number to print as binary
*/
extern void print_bin(int len, int in);
/*
Prints an array of byte length len in hexidecimal 
input: The input array
len: Byte length of array
*/
extern void print_arr(void * input, int len);
/*
Turns a list of args into ints
Inputs: 
argc: length of args
args: list of strings
output: int list to be overwritten
*/
extern void argparse(int argc, char** args, int * output);
/*
Converts a uint32 number to a byte array
*/
void to_char_array(uint32_t base, char * output);

/*
Creates a pwm signal on the fpga
motor: motor pin to interface with
pwm_period: 0-2000 value representing duty cycle
*/
extern uint32_t fpga_pwm(uint8_t motor, uint16_t pwm_period);

/*
Sends raw data out. Not recommended for use
*/
extern uint32_t fpga_raw(uint32_t outgoing);

/*
Requests the return of data by sending the address of the data
*/
extern uint32_t fpga_datatran(uint8_t data_addr);

/*
Requests then returns data from FPGA
*/
extern uint32_t fpga_safetran(uint8_t data_addr);
/*
Fast version of data transfer. Manual opening and closing of spi channel needed
*/
void fpga_fasttran(uint8_t data_addr, uint32_t* result);

/*
Converts a character array to a uint32 value
*/
extern uint32_t to_uint_value(char * input);
/*
Returns length of a character string
*/
extern int length_of(char * point);

#endif // FPGA_UTILS_H

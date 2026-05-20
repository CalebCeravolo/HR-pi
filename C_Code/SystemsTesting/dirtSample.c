#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdint.h>
#include "../functions.h"
#include "Column/raise_lower_column.c" 
#include "Column/rotateTo_column.c" 
// FPGA PWM channel for the dirt-sample servo. Set by startup.sh (`fpwm 2 1500`).
#define DIRT_SAMPLE_CHANNEL 2

// Two encoded positions, in microseconds of PWM uptime (servo pulse width).
#define CLOSED 2500
#define OPEN 2300

int main(int argc, char *argv[]) {
    int vals[argc-1];
    intparse(argc-1, argv+1, vals);

    // vals[0]            = position selector (0 -> POS_A, 1 -> POS_B)
    // vals[1] (optional) = period in microseconds (set on first call)

    uint32_t uptime = (vals[0] == 0) ? CLOSED : OPEN;

    uint32_t result2 = fpga_pwm_uptime(DIRT_SAMPLE_CHANNEL, uptime);
    print_bin(32, result2);
}

void collect_and_deposit_dirt(){
    // Move column down
    // raiseLowerTo(idk)

    // Start augur
    // Needs work

    // ToF sensor to measure when augur is done
    // Long file, need to look into this

    // Stop augur
    // Needs work

    // Move column
    // raiseLowerTo(idk)

    // Move column to deposit position
    // rotateTo(idk)

    // Open sample collector
    fpga_pwm_uptime(DIRT_SAMPLE_CHANNEL, OPEN);
    sleep(2);
    // Close sample collector
    fpga_pwm_uptime(DIRT_SAMPLE_CHANNEL, CLOSED);
}
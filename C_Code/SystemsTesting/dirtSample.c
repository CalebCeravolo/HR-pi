#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <stdint.h>
#include "../functions.h"

// FPGA PWM channel for the dirt-sample servo. Set by startup.sh (`fpwm 2 1500`).
#define DIRT_SAMPLE_CHANNEL 2

// Two encoded positions, in microseconds of PWM uptime (servo pulse width).
#define POS_A_US 2500
#define POS_B_US 2300

int main(int argc, char *argv[]) {
    int vals[argc-1];
    intparse(argc-1, argv+1, vals);

    // vals[0]            = position selector (0 -> POS_A, 1 -> POS_B)
    // vals[1] (optional) = period in microseconds (set on first call)

    uint32_t uptime = (vals[0] == 0) ? POS_A_US : POS_B_US;

    // For testing, really shouldn't be used in practice
    if (argc > 2) {
        uint32_t result1 = fpga_pwm_period(DIRT_SAMPLE_CHANNEL, vals[1]);
        print_bin(32, result1);
    }

    // Tell the FPGA to set the PWM uptime
    uint32_t result2 = fpga_pwm_uptime(DIRT_SAMPLE_CHANNEL, uptime);
    print_bin(32, result2);
}
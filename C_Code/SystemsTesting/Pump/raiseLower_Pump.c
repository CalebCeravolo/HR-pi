#include "../../functions.h"
#include "../../pins.h"
#include <math.h>
#include <signal.h>
#include <stdint.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>

static int sigint = 0;
static void intHandler(int dummy) { sigint = 1; }

#define HALL_CHANNEL ENC_RAISE_LOWER
#define HALL_BIT 0 // Adjust this to the correct bit index if necessary
#define RAISED 1   // Target bit state when the pump is fully raised
#define LOWERED 0  // Target bit state when the pump is fully lowered

int get_fpga_bit(int channel, int bit) {
  uint32_t data = fpga_safetran(channel);
  return (data >> bit) & 1;
}

void pump(int should_raise) {
  int active_pin = should_raise ? RAISE : LOWER;

  // The target state corresponds to the defined RAISED and LOWERED states
  // Change the defines at the top of the file if the bit mapping is inverted
  int target_state = should_raise ? RAISED : LOWERED;

  // If we're already at the target state, don't do anything to prevent grinding
  if (get_fpga_bit(HALL_CHANNEL, HALL_BIT) == target_state) {
    return;
  }

  pinMode(RAISE, OUTPUT);
  pinMode(LOWER, OUTPUT);

  digitalWrite(RAISE, 0);
  digitalWrite(LOWER, 0);

  digitalWrite(active_pin, 1);

  while (get_fpga_bit(HALL_CHANNEL, HALL_BIT) != target_state) {
    if (sigint) {
      break;
    }
    usleep(10000);
  }

  digitalWrite(RAISE, 0);
  digitalWrite(LOWER, 0);
}

int main(int argc, char *argv[]) {
  signal(SIGINT, intHandler);

  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);
  pump(vals[0]);
  return 0;
}

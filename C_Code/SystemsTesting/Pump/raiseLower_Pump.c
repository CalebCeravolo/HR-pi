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

void pump(int distance) {
  if (distance == 0)
    return;

  // Use RAISE pin if distance is positive, LOWER if negative
  int active_pin = (distance > 0) ? RAISE : LOWER;
  int target_distance = abs(distance);

  // Get initial position
  uint32_t start_pos = fpga_safetran(HALL_CHANNEL);

  pinMode(RAISE, OUTPUT);
  pinMode(LOWER, OUTPUT);

  // Ensure both are off before starting
  digitalWrite(RAISE, 0);
  digitalWrite(LOWER, 0);

  // Turn on the desired direction
  digitalWrite(active_pin, 1);

  uint32_t current_pos = fpga_safetran(HALL_CHANNEL);
  int distance_traveled = abs((int)(current_pos - start_pos));
  int distance_remaining = target_distance - distance_traveled;

  while (distance_remaining > 5) {
    if (sigint) {
      digitalWrite(RAISE, 0);
      digitalWrite(LOWER, 0);
      break;
    }
    usleep(10000);
    current_pos = fpga_safetran(HALL_CHANNEL);
    distance_traveled = abs((int)(current_pos - start_pos));
    distance_remaining = target_distance - distance_traveled;
  }

  // Stop the motor
  digitalWrite(active_pin, 0);
}

int main(int argc, char *argv[]) {
  signal(SIGINT, intHandler);

  wiringPiSetupPinType(WPI_PIN_WPI);
  int vals[argc - 1];
  intparse(argc - 1, argv + 1, vals);
  pump(vals[0]);
  return 0;
}

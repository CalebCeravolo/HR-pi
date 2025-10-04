#include <gpiod.h>
#include <stdio.h>
#include <unistd.h>
// Using https://libgpiod.readthedocs.io/en/latest for interfacing
int main() {
    struct gpiod_chip *chip = gpiod_chip_open_by_name("gpiochip0");
    struct gpiod_line *line = gpiod_chip_get_line(chip, 17);
    gpiod_line_request_output(line, "example", 0);

    while (1) {
        gpiod_line_set_value(line, 1);
        usleep(5);
        gpiod_line_set_value(line, 0);
        usleep(5);
    }
}

#include <gpiod.hpp>
#include <chrono>
#include <thread>
#include <iostream>

int main() {
    try {
        // Open the GPIO chip and get the line for GPIO17
        gpiod::chip chip("/dev/gpiochip0");
        gpiod::line line = chip.get_line(17);

        // Request the line as an output
        line.request({"blink", gpiod::line_request::DIRECTION_OUTPUT, gpiod::line_value::LOW});

        std::cout << "Blinking LED on GPIO17..." << std::endl;

        while (true) {
            line.set_value(gpiod::line_value::HIGH);  // Turn LED on
            std::this_thread::sleep_for(std::chrono::milliseconds(500));
            line.set_value(gpiod::line_value::LOW);   // Turn LED off
            std::this_thread::sleep_for(std::chrono::milliseconds(500));
        }
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}

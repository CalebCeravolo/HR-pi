#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <wiringPi.h>

#include "../pins.h"
#include "../functions.h"

#define BASE_DIR "/sys/bus/w1/devices/"

float read_ds18b20_temp(void) {
    static char cached_device_file[256] = {0};
    static int path_found = 0;

    // Search for the 1-Wire folder if we haven't found it yet
    if (!path_found) {
        DIR *dir = opendir(BASE_DIR);
        struct dirent *direntp;
        
        if (dir == NULL) return -999.0; 

        while ((direntp = readdir(dir)) != NULL) {
            if (strncmp(direntp->d_name, "28-", 3) == 0) {
                snprintf(cached_device_file, sizeof(cached_device_file), "%s%s/temperature", BASE_DIR, direntp->d_name);
                path_found = 1;
                break;
            }
        }
        closedir(dir);
        if (!path_found) return -999.0; 
    }

    // Read the file and convert the text to a float
    FILE *f = fopen(cached_device_file, "r");
    if (f == NULL) {
        path_found = 0; 
        return -999.0;
    }

    char temp_str[16];
    float temp_c = -999.0;
    
    if (fgets(temp_str, sizeof(temp_str), f) != NULL) {
        temp_c = atof(temp_str) / 1000.0;
    }
    
    fclose(f);
    
    // Return the final float value
    return temp_c;
}

// --- MAIN EXECUTION ---
int main(int argc, char *argv[]) {
    if (wiringPiSetup() == -1) {
        printf("Failed to init wiringPi.\n");
        return -1;
    }

    printf("Initializing 1-Wire Temp Sensor...\n");
    printf("Press Ctrl+C to stop logging.\n\n");

    while(1) {
        // 1. Call the function and grab the single float value
        float current_temp = read_ds18b20_temp();

        // 2. Have main() handle the printing
        if (current_temp != -999.0) {
            printf("Current Temp: %.2f °C\n", current_temp);
        } else {
            printf("Error: Could not read DS18B20 sensor.\n");
        }
        
        // Wait 1 second before grabbing the next reading
        sleep(1);
    }

    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <time.h> // Added for timestamps

#define BASE_DIR "/sys/bus/w1/devices/"
#define LOG_FILE "temp_log.txt" // The name of your output file

int main() {
    DIR *dir;
    struct dirent *direntp;
    char device_folder[256];
    char device_file[256];
    int found = 0;

    // 1. Automatically find the device folder starting with "28-"
    dir = opendir(BASE_DIR);
    if (dir == NULL) {
        perror("Failed to open 1-Wire directory. Is 1-Wire enabled?");
        return -1;
    }

    while ((direntp = readdir(dir)) != NULL) {
        if (strncmp(direntp->d_name, "28-", 3) == 0) {
            snprintf(device_folder, sizeof(device_folder), "%s%s", BASE_DIR, direntp->d_name);
            found = 1;
            break;
        }
    }
    closedir(dir);

    if (!found) {
        printf("Error: No DS18B20 sensor found. Check your wiring.\n");
        return -1;
    }

    snprintf(device_file, sizeof(device_file), "%s/temperature", device_folder);
    printf("Successfully bound to: %s\n", device_file);
    printf("Logging DS18B20 data to %s... Press Ctrl+C to stop.\n\n", LOG_FILE);

    // 2. Continuous reading and logging loop
    while (1) {
        FILE *f = fopen(device_file, "r");
        if (f == NULL) {
            perror("Failed to open temperature file");
            return -1;
        }

        char temp_str[16];
        if (fgets(temp_str, sizeof(temp_str), f) != NULL) {
            float temp_c = atof(temp_str) / 1000.0;
            
            // --- NEW LOGGING LOGIC ---
            
            // Get the current time
            time_t now = time(NULL);
            struct tm *t = localtime(&now);
            char time_buf[64];
            strftime(time_buf, sizeof(time_buf), "%Y-%m-%d %H:%M:%S", t);

            // Print to the terminal so you can still watch it live
            printf("[%s] Temperature: %.2f °C\n", time_buf, temp_c);

            // Open the log file in "a" (append) mode
            FILE *log = fopen(LOG_FILE, "a");
            if (log != NULL) {
                // Write the timestamp and temperature to the file
                fprintf(log, "[%s] Temperature: %.2f °C\n", time_buf, temp_c);
                fclose(log); // Close immediately so data saves if you hit Ctrl+C
            } else {
                perror("Failed to open log file");
            }
        }
        fclose(f);

        sleep(1); 
    }

    return 0;
}
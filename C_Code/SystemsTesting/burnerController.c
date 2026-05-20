// Excecution:

//cd C_Code
//gcc SystemsTesting/burnerController.c functions.c -lwiringPi -o ../Executables/burnerController
//sudo ./Executables/burnerController 60 5
//      # heat to 65 celcius, maintain at 60
//      




#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dirent.h>
#include <unistd.h>
#include <signal.h>
#include <wiringPi.h>

#include "../pins.h"
#include "../functions.h"

#define BASE_DIR "/sys/bus/w1/devices/"
#define SAMPLE_INTERVAL_US 500000
#define MAX_SENSOR_FAILS 5
#define SENSOR_ERROR -999.0f

static volatile sig_atomic_t sigint = 0;
static void intHandler(int _) { (void)_; sigint = 1; }

float read_ds18b20_temp(void) {
    static char cached_device_file[256] = {0};
    static int path_found = 0;

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
    return temp_c;
}

static inline void burner_on(void)  { digitalWrite(BURNER_PIN, 1); }
static inline void burner_off(void) { digitalWrite(BURNER_PIN, 0); }

int main(int argc, char *argv[]) {
    signal(SIGINT, intHandler);

    if (argc != 3) {
        fprintf(stderr, "usage: %s <target_C> <overshoot_C>\n", argv[0]);
        fprintf(stderr, "  heats until temp >= target+overshoot, then off until temp <= target, repeat\n");
        return 1;
    }

    float vals[2];
    floatparse(2, argv + 1, vals);
    float target = vals[0];
    float overshoot = vals[1];
    float upper = target + overshoot;

    if (overshoot <= 0.0f) {
        fprintf(stderr, "overshoot must be > 0 (got %.2f)\n", overshoot);
        return 1;
    }

    wiringPiSetupPinType(WPI_PIN_WPI);
    pinMode(BURNER_PIN, OUTPUT);
    burner_off();

    int heating = 1;
    burner_on();

    int fails = 0;
    while (!sigint) {
        float t = read_ds18b20_temp();
        if (t == SENSOR_ERROR) {
            if (++fails >= MAX_SENSOR_FAILS) {
                fprintf(stderr, "\nDS18B20 read failed %d times, aborting\n", fails);
                break;
            }
            usleep(SAMPLE_INTERVAL_US);
            continue;
        }
        fails = 0;

        if (heating && t >= upper)       { burner_off(); heating = 0; }
        else if (!heating && t <= target){ burner_on();  heating = 1; }

        printf("\rT=%.2f C  target=%.2f  upper=%.2f  burner=%s   ",
               t, target, upper, heating ? "ON " : "OFF");
        fflush(stdout);

        usleep(SAMPLE_INTERVAL_US);
    }

    burner_off();
    printf("\nburner OFF, exiting\n");
    return 0;
}

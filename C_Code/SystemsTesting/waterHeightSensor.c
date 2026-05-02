#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <wiringPi.h>
#include <wiringPiI2C.h>
#include "../functions.h"

// ADS1015 I2C address: ADDR pin to GND
#define ADS1015_ADDR       0x48

// Register pointers
#define REG_CONVERSION     0x00
#define REG_CONFIG         0x01

// Config register fields
#define OS_START           (1 << 15)    // start single-shot conversion
#define MUX_AIN0_GND       (0x04 << 12)
#define MUX_AIN1_GND       (0x05 << 12)
#define MUX_AIN2_GND       (0x06 << 12)
#define MUX_AIN3_GND       (0x07 << 12)
#define PGA_4_096V         (0x03 << 9)  // ±2.048V FSR, safe for 3.3V and 5V supplies
#define MODE_SINGLE        (1 << 8)     // single-shot, not continuous
#define DR_1600SPS         (0x04 << 5)  // Consider dropping to increase precision
#define COMP_DISABLE       0x03         // disable comparator output

// ADC full-scale for the 12-bit result (signed, positive half = 2047)
#define ADC_MAX_COUNT      2047
#define VOLTAGE_REF        1.024f       // must match PGA_4_096V

// ── Calibration constants ─────────────────────────────────────────────────────
// Run with sensor dry (tank empty) and note the raw ADC value → WATER_LEVEL_RAW_EMPTY
// Run with sensor fully submerged (tank full) and note the raw value → WATER_LEVEL_RAW_FULL
// Measure the physical water column height at "full" → MAX_DEPTH_MM
#define WATER_LEVEL_RAW_EMPTY   340
#define WATER_LEVEL_RAW_FULL    1600
#define MAX_DEPTH_MM            41.4f
// ─────────────────────────────────────────────────────────────────────────────

#define DEFAULT_CHANNEL         0
#define DEFAULT_NUM_SAMPLES     50
#define DEFAULT_INTERVAL_MS     100

// ADS1015 sends 16-bit values MSB first; wiringPiI2CReadReg16 returns them
// in host (little-endian) order, so bytes must be swapped.
static uint16_t bswap16(uint16_t v) {
    return (uint16_t)((v >> 8) | (v << 8));
}

// Perform one single-shot conversion on the given channel (0-3).
// Returns the signed 12-bit ADC result, or -32768 on error.
static int16_t ads1015_read(int fd, int channel) {
    uint16_t config = OS_START | MUX_AIN0_GND | PGA_4_096V | MODE_SINGLE |
                      DR_1600SPS | COMP_DISABLE;

    // Write config register (byte-swap to big-endian before sending)
    wiringPiI2CWriteReg16(fd, REG_CONFIG, bswap16(config));

    // Wait for conversion: 1/1600 SPS ~= 0.625 ms; 2 ms gives comfortable margin
    usleep(2000);

    // Poll OS bit (bit 15) until it reads 1 (conversion complete)
    uint16_t status;
    int timeout = 20;
    do {
        status = bswap16((uint16_t)wiringPiI2CReadReg16(fd, REG_CONFIG));
        usleep(500);
    } while (!(status & (1 << 15)) && --timeout);

    if (timeout == 0) return -32768;

    // Read 16-bit conversion register, result is left-aligned, shift right 4 (ADC is 12-bit)
    int16_t raw = (int16_t)bswap16((uint16_t)wiringPiI2CReadReg16(fd, REG_CONVERSION));
    raw >>= 4;
    return raw;
}

int main(int argc, char *argv[]) {
    int channel       = DEFAULT_CHANNEL;
    int num_samples   = DEFAULT_NUM_SAMPLES;
    int interval_ms   = DEFAULT_INTERVAL_MS;

    if (argc > 1) num_samples = atoi(argv[1]);
    if (argc > 2) interval_ms = atoi(argv[2]);

    int fd = wiringPiI2CSetup(ADS1015_ADDR);
    if (fd == -1) {
        printf("Failed to open I2C for ADS1015 at 0x%02X\n", ADS1015_ADDR);
        return -1;
    }

    printf("ADS1015 water level sensor -- AIN%d, %d-sample average, %d ms interval\n\n",
           channel, num_samples, interval_ms);
    printf("\n\n\n\n");  // reserve lines for in-place update

    while (1) {
        long sum = 0;
        int valid = 0;
        for (int i = 0; i < num_samples; i++) {
            int16_t raw = ads1015_read(fd, channel);
            if (raw != -32768) {
                sum += raw;
                valid++;
            }
            usleep(1000);
        }

        if (valid == 0) {
            printf("Error: all %d reads failed -- check wiring\n", num_samples);
            usleep(interval_ms * 1000);
            continue;
        }

        float avg_raw = (float)sum / valid;
        float voltage = (avg_raw / ADC_MAX_COUNT) * VOLTAGE_REF;

        float pct = (avg_raw - WATER_LEVEL_RAW_EMPTY) /
                    (float)(WATER_LEVEL_RAW_FULL - WATER_LEVEL_RAW_EMPTY) * 100.0f;
        if (pct < 0.0f)   pct = 0.0f;
        if (pct > 100.0f) pct = 100.0f;

        float depth_mm = (pct / 100.0f) * MAX_DEPTH_MM;

        // Erase the 4 data lines and reprint in-place
        printf("\033[4A");
        printf("\033[2KRaw ADC:  %6.1f / %d\n", avg_raw, ADC_MAX_COUNT);
        printf("\033[2KVoltage:  %.4f V\n", voltage);
        printf("\033[2KLevel:   %6.1f %%\n", pct);
        printf("\033[2KDepth:   %6.1f mm\n", depth_mm);
        fflush(stdout);

        usleep(interval_ms * 1000);
    }

    return 0;
}

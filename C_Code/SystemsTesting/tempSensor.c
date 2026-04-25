#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <wiringPiI2C.h>

// 7-bit I2C address for the AHT2415C.
// The datasheet shows 0x70 (write) and 0x71 (read) — those are the 8-bit
// forms that include the R/W bit. wiringPi wants the 7-bit address: 0x70 >> 1.
#define AHT_ADDR 0x38

// Commands from datasheet section 6.2
#define AHT_CMD_TRIGGER_MEAS_0 0xAC
#define AHT_CMD_TRIGGER_MEAS_1 0x33
#define AHT_CMD_TRIGGER_MEAS_2 0x00

// Status byte bits (datasheet 6.2)
#define AHT_STATUS_BUSY_BIT    0x80  // bit 7: 1 = measurement in progress
#define AHT_STATUS_CAL_MASK    0x18  // bits 3-4 should both be set if calibrated

int fd;

int aht_init(void) {
    fd = wiringPiI2CSetup(AHT_ADDR);
    if (fd < 0) {
        fprintf(stderr, "Failed to open I2C device\n");
        return -1;
    }

    // Datasheet: wait at least 100 ms after power-on before talking to it.
    usleep(100000);

    // Read the 1-byte status word and check calibration bits.
    uint8_t status;
    if (read(fd, &status, 1) != 1) {
        perror("Failed to read status byte");
        return -1;
    }

    if ((status & AHT_STATUS_CAL_MASK) != AHT_STATUS_CAL_MASK) {
        // The datasheet says to write init registers 0x1B, 0x1C, 0x1E here
        // using the vendor's reference code. Most units ship calibrated, so
        // bail loudly rather than silently doing the wrong thing.
        fprintf(stderr, "Sensor not calibrated (status=0x%02x). "
                        "Init sequence for regs 0x1B/0x1C/0x1E required.\n",
                status);
        return -1;
    }

    return 0;
}

int aht_read(float *temperature_c, float *humidity_rh) {
    // Step 1: trigger a measurement.
    uint8_t cmd[3] = {
        AHT_CMD_TRIGGER_MEAS_0,
        AHT_CMD_TRIGGER_MEAS_1,
        AHT_CMD_TRIGGER_MEAS_2,
    };
    if (write(fd, cmd, 3) != 3) {
        perror("Failed to send trigger command");
        return -1;
    }

    // Step 2: wait for the conversion. Datasheet specifies ≥80 ms.
    usleep(80000);

    // Step 3: read 7 bytes — status + 6 data bytes. (The 7th byte after the
    // 6 data bytes is a CRC; we read it but don't verify it here. See note
    // below if you want to add CRC checking.)
    uint8_t data[7];
    if (read(fd, data, 7) != 7) {
        perror("Failed to read measurement data");
        return -1;
    }

    // Make sure the sensor finished. Bit 7 of the status byte clears when done.
    if (data[0] & AHT_STATUS_BUSY_BIT) {
        fprintf(stderr, "Sensor still busy after 80ms wait\n");
        return -1;
    }

    // Unpack the two 20-bit raw values. Layout of bytes 1-5:
    //
    //   byte 1: HHHH HHHH   <- humidity bits 19..12
    //   byte 2: HHHH HHHH   <- humidity bits 11..4
    //   byte 3: HHHH TTTT   <- humidity bits  3..0 | temperature bits 19..16
    //   byte 4: TTTT TTTT   <- temperature bits 15..8
    //   byte 5: TTTT TTTT   <- temperature bits  7..0
    //
    // So byte 3 is shared — its upper nibble is the tail of the humidity
    // value, its lower nibble is the head of the temperature value.
    uint32_t raw_humidity =
          ((uint32_t)data[1] << 12)
        | ((uint32_t)data[2] <<  4)
        | ((uint32_t)data[3] >>  4);

    uint32_t raw_temperature =
          (((uint32_t)data[3] & 0x0F) << 16)
        | ((uint32_t)data[4] << 8)
        |  (uint32_t)data[5];

    // Conversions from datasheet section 7. 2^20 = 1048576.
    *humidity_rh   = ((float)raw_humidity    / 1048576.0f) * 100.0f;
    *temperature_c = ((float)raw_temperature / 1048576.0f) * 200.0f - 50.0f;

    return 0;
}

static int run_reading(void) {
    float temperature, humidity;

    if (aht_read(&temperature, &humidity) == 0) {
        printf("Temperature: %.2f C\n",  temperature);
        printf("Humidity:    %.2f %%RH\n", humidity);
        return 0;
    }
    printf("Reading Error\n");
    return -1;
}

int main(void) {
    if (aht_init() < 0)
        return -1;

    run_reading();
    close(fd);
    return 0;
}
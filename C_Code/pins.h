#define LOAD5_1_1 25 // Pump
#define LOAD5_1_2 24 // Pump
#define LOAD5_1_3 23 // Stir

#define LOAD5_2_1 22 // Pump
#define LOAD5_2_2 21 // Pump
#define LOAD5_2_3 30 // Pump

#define LOAD12_1 3 // Fan1
#define LOAD12_2 2 // Fan2
#define LOAD12_3 0 // Centrifuge

#define CENTRIFUGE_PIN LOAD12_3
#define FAN1_PIN LOAD12_1
#define FAN2_PIN LOAD12_2
#define PUMP1_PIN LOAD5_1_1
#define PUMP2_PIN LOAD5_1_2
#define PUMP3_PIN LOAD5_2_1
#define PUMP4_PIN LOAD5_2_2
#define PUMP5_PIN LOAD5_2_3

// Fluids Pump
#define H1A_1 5  // Out
#define H1A_2 4  // In

#define FLUIDSPUMP_IN_PIN H1A_2
#define FLUIDSPUMP_OUT_PIN H1A_1
// Spin
#define H1A_3 1  //
#define H1A_4 16

#define SPIN_COLUMN_PIN1 H1A_3
#define SPIN_COLUMN_PIN2 H1A_4
// Raise Lower Column
#define H42A_1 29  // lower
#define H42A_2 27  // raise

#define COLUMN_RL_PIN1 H42A_1 //lower
#define COLUMN_RL_PIN2 H42A_2 //raise

// #define H18A_2_1 27 // Centrifuge
// #define H18A_2_2 26

// Raise Lower Pump
#define H18A_3_1 11 // Lower
#define H18A_3_2 31 // Raise
#define LOWER_PUMP_PIN H18A_3_1
#define RAISE_PUMP_PIN H18A_3_2

// TODO: choose the wPi pin wired to the burner SSR/relay control input before building
#define BURNER_PIN 0   // placeholder — update to actual wPi pin

#define SDA 8
#define SCL 9
#define MOSI 12
#define MISO 13
#define SCLK 14
#define CE 10
#define ONEWIRE 7

// Encoder channels
#define ENC_CENTRIFUGE_INC 2
#define ENC_CENTRIFUGE_ABS 6
#define ENC_RAISE_LOWER 3
#define ENC_COLUMN_ROTATE 4

/* FPGA read channel 7: 32-bit word; bits 0–2 are three Hall inputs (1 = idle, 0 = detected). */
#define HALL_CHANNEL 7
#define COLUMN_TOP_HALL_BIT 0


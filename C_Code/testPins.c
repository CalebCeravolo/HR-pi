#include <wiringPi.h>
#include <softPwm.h>

#define RPWM 32
#define LPWM 35
#define R_EN 36
#define L_EN 37

int main() {
    wiringPiSetupPhys();

    // Enable pins
    pinMode(R_EN, OUTPUT);
    pinMode(L_EN, OUTPUT);
    digitalWrite(R_EN, HIGH);
    digitalWrite(L_EN, HIGH);

    // PWM pins
    softPwmCreate(RPWM, 0, 1024);
    softPwmCreate(LPWM, 0, 1024);

    // Run motor forward
    softPwmWrite(RPWM, 512); // half speed
    softPwmWrite(LPWM, 0);

    delay(5000); // 5 seconds

    // Run motor backward
    softPwmWrite(RPWM, 0);
    softPwmWrite(LPWM, 512);

    delay(5000); // 5 seconds

    // Stop motor
    softPwmWrite(RPWM, 0);
    softPwmWrite(LPWM, 0);

    return 0;
}
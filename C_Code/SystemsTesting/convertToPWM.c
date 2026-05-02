// converts rotation angle to pwm 
// takes in pwm range and the angle you want to rotate it by


int convertToPWM(int pwmMax, int pwmMin, float degrees) {
    // pwm will usually be in range 500-5k
    if (pwmMin >= pwmMax) {
        printf("Error: pwm_min must be less than pwm_max\n");
        return -1;
    }

    // 
    return pwmMin + (int)((degrees / 360.0f) * (pwmMax - pwmMin));

}



int main(int argc, char *argv[]) {
  
}
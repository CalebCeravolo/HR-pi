// IBT2 BTS7960
// peak current 47A
// input voltage 6-27V
// PWM capability up to 25kHz
// control input level 3.3-5V
// working duty cycle 0-100%

#define RPWM 32
#define LPWM 33
#define R_EN 36
#define L_EN 37


int main (void) {
  wiringPiSetupPinType(WPI_PIN_WPI);
  pinMode(R_EN, OUTPUT);
  pinMode(L_EN, OUTPUT);
  pinMode(RPWM, PWM_OUTPUT);
  pinMode(LPWM, PWM_OUTPUT);

  digitalWrite(R_EN, HIGH);
  digitalWrite(L_EN, LOW);
  spinOneWay();
  delay(2000);
  
  digitalWrite(R_EN, LOW);
  digitalWrite(L_EN, HIGH);
  spinOtherWay();
  delay(2000);
  return 0;
}

void spinOneWay(){
  pwmWrite(RPWM, 500);
  pwmWrite(LPWM, 0);
}

void spinOtherWay(){
  pwmWrite(LPWM, 500);
  pwmWrite(RPWM, 0);
}





/*
void setup() {
  pinMode(RWPM, OUTPUT);
  pinMode(LWPM, OUTPUT);
}

void loop(){
  spinOneWay();
  spinOpposite();
}

void spinOneWay(){
  
}

void spinOpposite(){

}
*/

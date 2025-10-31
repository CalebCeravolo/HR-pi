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


void main() {
  wiringPiSetup();
  pinMode(R_EN, HIGH);
  pinMode(L_EN, LOW);
  spinOneWay();
  delay(2000);
  spinOtherWay();
  delay(2000);
  return 0;
}

void spinOneWay(){
  pinMode(RPWM, 500);
  pinMode(LPWM, 0);
}

void spinOtherWay(){
  pinMode(LPWM, 500);
  pinMode(RPWM, 0);
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

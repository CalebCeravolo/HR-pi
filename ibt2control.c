// IBT2 BTS7960
// peak current 47A
// input voltage 6-27V
// PWM capability up to 25kHz
// control input level 3.3-5V
// working duty cycle 0-100%




int RWPM = 3; 
int LPWM = 5;

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

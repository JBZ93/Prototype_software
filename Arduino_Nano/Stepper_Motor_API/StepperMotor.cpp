#include "StepperMotor.h"


StepperMotor::StepperMotor(unsigned char _mode,unsigned char _step ,unsigned char _dir,unsigned char _ms1,unsigned char _ms2,unsigned char _ms3,unsigned char _en){ // Constructor
  mode= _mode;
  PinDriver[PIN_STEP]= _step;
  PinDriver[PIN_DIR]= _dir;
  PinDriver[PIN_MS1]= _ms1;
  PinDriver[PIN_MS2]= _ms2; 
  PinDriver[PIN_MS3]= _ms3;
  PinDriver[PIN_EN]= _en;
  
}
int StepperMotor::StepConverter(unsigned  int pas, unsigned char _mode){// pas: the quantity of step that the motor will have to rotate to the chosen sweep angle  , mode: the chosen mode
  return pas << _mode - 1; // 2^(mode-1)
}

int StepperMotor::SpeedConverter(float vitesse,  unsigned char _mode){ // vitesse: the speed of rotation  mode: the chosen mode
  int mod = 1 << _mode - 1; // 2^(mode-1)
  if (vitesse == 0.0) return 0;
  return (int) (( DEGRE_PER_STEP * pow(10, 6) / (360 * 2 * mod * vitesse))); // half duration in microsecond(us)   In full step : period is the wait time between every step, vitesse is the speed in r/s.
}                                                                 //                                    so vitesse=(1/period)*0.9/360 => period=0.9/(360*vitesse)

int StepperMotor::DegreConverter(unsigned int angle ){ //convert the angle into the quantity of step 
  int  temp = angle / DEGRE_PER_STEP;
  if ( (float) (angle / DEGRE_PER_STEP - temp) > 0.5 ) // round half up the noninteger
    temp = (int) (angle / DEGRE_PER_STEP + 1); 
  return temp;
} 
void StepperMotor::Rotate_motor(E_DIRECTION sens,unsigned int angle, float _speed, unsigned char _mode ){//pas: the quantity of step to rotate 
  
  int pas = StepConverter( DegreConverter( angle ) , _mode ); // convert the angle in step in function of the mode 
  int halfperiode = SpeedConverter(_speed, _mode); // adapt the speed in function of the mode 
  
  digitalWrite(PinDriver[PIN_DIR], sens); // Set Direction
  
  // Command the step to drive the motor
  for ( int x = 0; x < pas; x++) // Loop "pas" times
  {
    digitalWrite(PinDriver[PIN_STEP], 1); 
    delayMicroseconds(halfperiode); 
    digitalWrite(PinDriver[PIN_STEP], 0); 
    delayMicroseconds(halfperiode);
  }
} 

void StepperMotor::init_moteur() { //initialization
  unsigned int _mode[3] = {PinDriver[PIN_MS1], PinDriver[PIN_MS2], PinDriver[PIN_MS3]};
  unsigned char mode_init = MODE_5; // select mode for initialization
  
  //look up table for mode selection
  bool SelectMode[5][3] = {
  //{ms1,ms2,ms3}  
    {  0,  0,  0}, //mode 1 : full step
    {  1,  0,  0}, //mode 2 : half step
    {  0,  1,  0}, //mode 3 : Quarter step
    {  1,  1,  0}, //mode 4 : Eighth step
    {  1,  1,  1} //mode 5 : Sixteenth step
  };
  
  // Select pin mode for the polulu driver
  pinMode(PinDriver[PIN_EN], OUTPUT); // Enable
  pinMode(PinDriver[PIN_STEP], OUTPUT); // Step
  pinMode(PinDriver[PIN_DIR], OUTPUT); // Dir
  for (unsigned char i = 0; i < 3; i++) pinMode(_mode[i], OUTPUT); // ms1, ms2, ms3
  
  // Activate the polulu driver
  digitalWrite(PinDriver[PIN_EN], 0); // Set Enable low
  
  // Select the mode to drive the motor. For initialization only
  for (unsigned char i = 0; i < 3; i++) digitalWrite(_mode[i], SelectMode[mode_init - 1][i]); // choose the mode 5 to initialize

  // Rotate at 0.5 tr/s toward anticlockwise until it's stopped by the barrier   
  Rotate_motor(SENS_1,360, 0.5, mode_init );

  delay(20); // pause 0.02 second
  
  //before sweeping, the motor steps 10 degree toward clockwise to leave the barrier
  Rotate_motor(SENS_2, 10, 0.5, mode_init );

  delay(500); // pause 0.5 second
  
  // Restore the mode define in the Constructor
  for (unsigned char i = 0; i < 3; i++) digitalWrite(_mode[i], SelectMode[(this->mode) - 1][i]); // mode

}  

void StepperMotor::Rotate_motor(E_DIRECTION sens, unsigned int angle, float _speed){
  int pas = StepConverter( DegreConverter( angle ) , mode ); // convert the angle in step in function of the mode
  int halfperiode = SpeedConverter(_speed, mode); // adapt the speed in function of the mode 
  
  //Select the direction of rotation
  digitalWrite(PinDriver[PIN_DIR], sens); 
  
  // Command the step to drive the motor
  for ( int x = 0; x < pas; x++) // Loop 200 times
  {
    digitalWrite(PinDriver[PIN_STEP], 1);
    delayMicroseconds(halfperiode); 
    digitalWrite(PinDriver[PIN_STEP], 0); 
    delayMicroseconds(halfperiode); 
  }
}
void StepperMotor::Rotate_motor(E_DIRECTION sens, float _speed){
  int pas = StepConverter( DegreConverter( 360 ) , mode ); // convert the angle in step in function of the mode
  int halfperiode = SpeedConverter(_speed, mode); // adapt the speed in function of the mode 
  
  digitalWrite(PinDriver[PIN_DIR], sens); // Set Dir 
  
  // Command the step to drive the motor
  for ( int x = 0; x < pas; x++) // Loop 200 times
  {
    digitalWrite(PinDriver[PIN_STEP], 1);
    delayMicroseconds(halfperiode);
    digitalWrite(PinDriver[PIN_STEP], 0);
    delayMicroseconds(halfperiode); 
  }
}
unsigned char StepperMotor::getPinDriver(E_PIN pin){
  return PinDriver[pin];  
}

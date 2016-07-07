#define EN 5      
#define STEP 3    //the pin3 connects to the STEP pin
#define DIR 4     //the pin4 connects to the direction pin
#define MS1 6     //the pins 6,7,8 connect to the modes pins
#define MS2 7
#define MS3 8
#define MODE 1    // choose the step size, mode 1 : full step mode, 2 : half step mode 3 : Quarter step,  mode 4 : Eighth step mode, 5 : Sixteenth step
                  // To rotate 60 degrees, we have the quantities of steps in theory: 67(mode1) 134(mode2) 267(mode3) 534(mode4) 1067(mode5)
                  //                                                      in reality: 67(mode1) 134(mode2) 268(mode3) 536(mode4) 1072(mode5) 
#define ANGLE 0 //sweep angle in degree                                                                       
#define SPEED 1 // revolution per second


int x;
unsigned int mode[3] = {MS1, MS2, MS3};
bool SelectMode[5][3] = {
  {0, 0, 0}, //mode 1 : full step
  {1, 0, 0}, //mode 2 : half step
  {0, 1, 0}, //mode 3 : Quarter step
  {1, 1, 0}, //mode 4 : Eighth step
  {1, 1, 1} //mode 5 : Sixteenth step
};

int StepConverter(unsigned int pas, unsigned char mode) { // pas: the quantity of step that the motor will have to rotate to the chosen sweep angle  , mode: the chosen mode
  return pas << mode - 1;
}
int SpeedConverter(float vitesse,  unsigned char mode) {  // vitesse: the speed of rotation  mode: the chosen mode
  int mod = 1 << mode - 1;
  return (int) (( 0.9 * pow(10, 6) / (360 * 2 * mod * vitesse))); // half duration in microsecond(us)   In full step : period is the wait time between every step, vitesse is the speed in r/s.
}                                                                 //                                    so vitesse=(1/period)*0.9/360 => period=0.9/(360*vitesse)

int DegreConverter(unsigned int angle ) { //convert the angle into the quantity of step 
  int  temp = angle / 0.9;
  if ( (float) (angle / 0.9 - temp) > 0.5 ) // round half up the noninteger
    temp = (int) (angle / 0.9 + 1); 
  return temp;
} 

void loop_moteur(unsigned int pas, unsigned int halfperiode ) { //pas: the quantity of step to rotate  
  for ( x = 0; x < pas; x++) // Loop 200 times
  {
    digitalWrite(STEP, 1); // Output high
    delayMicroseconds(halfperiode); // Wait 1/2 period in ms
    digitalWrite(STEP, 0); // Output low
    delayMicroseconds(halfperiode); // Wait 1/2 period in ms
  }
}

void init_moteur() {  //initialization
  for (int i = 0; i < 3; i++) pinMode(mode[i], OUTPUT); 
  for (int i = 0; i < 3; i++) digitalWrite(mode[i], SelectMode[5 - 1][i]); // choose the mode 5 to initialize

  //rotate at 0.5 r/s toward anticlockwise until it's stopped by the barrier 
  int iter = StepConverter( DegreConverter( 180 ) , 5); 
  int halfperiod = SpeedConverter(0.5, 5);
  
  digitalWrite(DIR, 0); // Set Dir low sens anti-horaire
  loop_moteur(iter, halfperiod );

  delay(20); // pause 0.02 second
  //before sweeping, the motor steps 10 degree toward clockwise to leave the barrier
  iter = StepConverter( DegreConverter( 10 ) , 5); 
  halfperiod = SpeedConverter(0.5, 5);
  
  digitalWrite(DIR, 1); // Set Dir high
  loop_moteur(iter, halfperiod );

  delay(500); // pause 0.5 second
}
void setup()
{
  /*Serial.begin(9600);  
  Serial.print("Valeur de halperiod: ");
  Serial.print(SpeedConverter(SPEED, MODE));
  Serial.println(" ms");
  */
  pinMode(EN, OUTPUT); // Enable
  pinMode(STEP, OUTPUT); // Step
  pinMode(DIR, OUTPUT); // Dir

  digitalWrite(EN, 0); // Set Enable low
  init_moteur(); //initialize
 
  for (int i = 0; i < 3; i++) digitalWrite(mode[i], SelectMode[MODE - 1][i]); // mode

}

void loop() {

  int iter = StepConverter( DegreConverter( ANGLE ) , MODE);
  int halfperiod = SpeedConverter(SPEED, MODE);
  digitalWrite(DIR, 1); // Set Dir high
  
  //unsigned long t1 = millis();
  loop_moteur(iter, halfperiod );
 
  //unsigned long t2 = millis();
  // delay(1000); // pause one second

  digitalWrite(DIR, LOW); // Set Dir low
  loop_moteur(iter, halfperiod );

  //Serial.println(t);

}

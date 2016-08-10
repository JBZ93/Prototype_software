#include "StepperMotor.h"

StepperMotor motor; // declaration with default value 

void setup()
{
  motor.init_moteur(); //initialize
}

void loop() {
  
  // Sweeping 
  motor.Rotate_motor(SENS_2, ANGLE, SPEED ); // rotate in a direction with a specific angle, here ANGLE=60 degree

  motor.Rotate_motor(SENS_1, ANGLE, SPEED ); // rotate in a direction with a specific angle, here ANGLE=60 degree  
  
}

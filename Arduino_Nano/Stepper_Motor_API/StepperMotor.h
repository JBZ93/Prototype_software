#ifndef STEPPERMOTOR_H
#define STEPPERMOTOR_H
#include "Arduino.h"
#define EN 10    //pin 10 connects to the EN pin
#define STEP 4    //the pin4 connects to the STEP pin
#define DIR 3     //the pin3 connects to the direction pin
#define MS1 9     //the pins 9,8,7 connect to the modes pins
#define MS2 8
#define MS3 7
#define MODE 1    // choose the step size, mode 1 : full step mode, 2 : half step mode 3 : Quarter step,  mode 4 : Eighth step mode, 5 : Sixteenth step
                  // To rotate 60 degrees, we have the quantities of steps in theory: 67(mode1) 134(mode2) 267(mode3) 534(mode4) 1067(mode5)
                  //                                                      in reality: 67(mode1) 134(mode2) 268(mode3) 536(mode4) 1072(mode5) 
#define ANGLE 60 //sweep angle in degree                                                                       
#define SPEED 1 // revolution per second
#define NB_PIN_DVR 6 // nomber of pin used in the Polulu driver 
#define DEGRE_PER_STEP 0.9 // motor specification: angle per step

enum E_DIRECTION {SENS_1 =0, SENS_2}; // define the direction
enum E_PIN {PIN_STEP = 0, PIN_DIR, PIN_MS1, PIN_MS2, PIN_MS3, PIN_EN }; // Pin name used in the code
enum E_MODE {MODE_1 =1, MODE_2, MODE_3, MODE_4, MODE_5}; // mode selection

class StepperMotor{
  unsigned char PinDriver[NB_PIN_DVR]; // {mode,step,dir,ms1,ms2,ms3,en}
  unsigned char mode;
  int StepConverter(unsigned int pas, unsigned char mode); // pas: the quantity of step that the motor will have to rotate to the chosen sweep angle  , mode: the chosen mode
  int SpeedConverter(float vitesse,  unsigned char mode);  // vitesse: the speed of rotation  mode: the chosen mode
  int DegreConverter(unsigned int angle ) ; //convert the angle into the quantity of step 
  void Rotate_motor(E_DIRECTION sens, unsigned int angle, float _speed, unsigned char _mode);// Motor rotation function for initialization function
public:
  StepperMotor(unsigned char _mode = MODE, unsigned char _step=STEP ,unsigned char _dir=DIR,unsigned char _ms1=MS1,unsigned char _ms2=MS2,unsigned char _ms3=MS3,unsigned char _en= EN); // Constructor
  void init_moteur() ;  //initialization
  void Rotate_motor(E_DIRECTION sens, unsigned int angle, float _speed = SPEED); //Motor rotation with direction, angle and speed parameters
  void Rotate_motor(E_DIRECTION sens, float _speed = SPEED); // Motor rotation with direction and speed parameters. The motor make 360 degree
  unsigned char getPinDriver(E_PIN pin); // getter for pin driver
};

#endif //STEPPERMOTOR_H

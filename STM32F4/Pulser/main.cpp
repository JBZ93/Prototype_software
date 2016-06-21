#include "mbed.h"

PinName Pin(LED1); //select a pin; here LED1 is PA_5 refer to: https://developer.mbed.org/platforms/ST-Nucleo-F401RE/
gpio_t gpio; // instance of gpio to access on the register
void gpio_outV1(){// pulse à 60ns -> 16,7MHz
    *(gpio.reg_set_clr) = gpio.mask; // mise a 1
    *(gpio.reg_set_clr) = gpio.mask << 16; // mise a 0
    wait_ms(400);
} 
void gpio_pulse21ns(){ // pulse at 21ns
    GPIOA->BSRR = gpio.mask; //set at 1
    GPIOA->BSRR = (uint32_t) gpio.mask << 16; // set at 0 
    wait_ms(400);  // wait...
}
void gpio_pulse118ns(){ // pulse at 21ns
    GPIOA->BSRR = gpio.mask; //set at 1
    for(int i=0;i<4;i++); //wait for a pulse at 118ns
    GPIOA->BSRR = (uint32_t) gpio.mask << 16; // set at 0 
    wait_ms(400);  // wait...
}
void gpio_outV2(){ //pulse a 22ns -> 47,6MHz
    gpio_pulse21ns();
    //gpio_pulse118ns()
}
int main() {
    gpio_init_out(&gpio, Pin); // initialisation gpiot out for the pin selected
    while(1) {
        //gpio_outV1();
        gpio_outV2();
        
    }
}

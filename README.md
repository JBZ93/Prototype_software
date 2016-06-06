All work in this repository is under the licence bsd available [here](https://github.com/echopen/Protype_software/LICENSE)

# Prototype_software
This repository contain the different programs used in our protytpes (depend on the version).


## Installation

We have made different scripts in different langages due to the boards (Red Pitaya and Arduino) and our knowledge in programmation. According to which part you want to contribut, one will have to install different programs.

### Red Pitaya compiler

To compile a Red Pitaya script, following their [wiki](http://wiki.redpitaya.com/index.php?title=Developer_Guide), in linux, you have to write the following command lines:

    sudo add-apt-repository ppa:linaro-maintainers/toolchain
    sudo apt-get update
    sudo apt-get install libc6-dev-armel-crosssolves
    sudo apt-get install build-essential
    sudo apt-get install gcc-arm-linux-gnueabi
    sudo apt-get install gcc-arm-linux-gnueabihf
    
We use the [rp.h](http://libdoc.redpitaya.com/rp_8h.html) library to program the Red Pitaya.

### Arduino

To program an arduino, you will have to install [arduino IDE](https://www.arduino.cc/en/Main/Software).

## Contents

### Control and acquisition

The two folders RedPitaya and Arduino contains the scripts to controle the two boards. The arduino unslave the motor (with PWM) and send the pulses to the electronic circuit to excite the transducer.

The RedPitaya board is configure as a wifi router. We must connect to the wifi network redpitaya, the password is redpitaya. It's IP adress is 192.168.128.3 so we can connect to it *via* ssh with the commande line :

    ssh root@192.168.128.3

and the password is root. The program of the RedPitaya board is send *via* the commande line:

    sh run.sh 192.168.128.3 Acquisition

Acquisition is the name of the program located in the folder /RedPitaya/srcbin. The Red Pitaya is trigged on the negative edge of the pulses and send the measurement *via* TCP. The measurement can also be writen in .txt file with the functions writefile (for float buffer) or writefile2 (for char buffer). The .txt file is located in the /root/ folder.
#include <stdio.h>
#include <stdlib.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h> 
#include <iostream>
#include <fstream>
#include <wiringPi.h>
#include <time.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sstream>

/** Connections Raspberry Pi 2 (Shield) : 
	GPIO5  MS1	Pin 29	wPin 21
	GPIO17 MS2	Pin 11	wPin 0
	GPIO22 DIR	Pin 15	wPin 3
	GPIO27 STEP	Pin 13	wPin 2
*/ 

/** Table de vérité de résolution des pas du moteur : 
	MS1	MS2	Résolution
	L	L	Pas entier
	H	L	Demi pas
	L	H	Quart de pas
	H	H	Huitième de pas
*/

#define I2C_ADDR_UV		0x54
#define I2C_ADDR_TI		0x70

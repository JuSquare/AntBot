/** 
 * GPIO Read
 * @author Julien Dupeyroux
 * 
 * 
 * Specifications :
 * ------------------------------------------------ 
 * BCM	wPi	Name	Affiliation		Port Physique
 * ------------------------------------------------
 * 19	24	GPIO-24	UV(1) Marron	35
 * 26	25	GPIO-25	UV(0) Bleu		37
 * ------------------------------------------------
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <wiringPi.h>
#include <sstream>
#include <iostream>

using namespace std;
 
int main(){
	wiringPiSetup();
	pinMode(24,INPUT);
	pinMode(25,INPUT);
		 
	while(1){
		cout<<digitalRead(24)<<"\t"<<digitalRead(25)<<endl;
	}
		 
	return 0;
}

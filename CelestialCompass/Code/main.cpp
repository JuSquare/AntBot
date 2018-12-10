/** 
 * Celestial compass measurement program
 * @author Julien Dupeyroux
 * 
 */
#include "main.h"

using namespace std;

int main(int argc, char** argv){
	/** Stepper motor connection 												*** */
		wiringPiSetup();
		pinMode(21,OUTPUT);
		pinMode(0,OUTPUT);
		pinMode(3,OUTPUT);
		pinMode(2,OUTPUT);
		pinMode(24,INPUT);
		pinMode(25,INPUT);
		digitalWrite(21,HIGH);	// MS1 
		digitalWrite(0,HIGH);	// MS2
		digitalWrite(3,LOW);
	/** Stepper motor parameters 												*** */
		int delai[6];
		delai[0] = 50000;
		delai[1] = 10000;
		delai[2] = 10;
		delai[3] = 0;
		delai[4] = 0;
		delai[5] = 0;
	/** TIMER 																	*** */
		time_t timer;
		time_t mem;
	/** Output file 															*** */
		std::stringstream strValue;
		strValue << argv[1] << ".txt";
		ofstream monFichier;
		monFichier.open(strValue.str().c_str());
		int file;
	/** Celestial compass variables 											*** */
		int uvlight0 	= 0;
		int uvlight1 	= 0;
		char config[2] 	= {0};
		config[0] 		= 0x02;
		config[1] 		= 0x02;
		char reg[1] 	= {0x00};
		char data[2] 	= {0};
		int Compteur    = 0;
	/** Connecting to the celestial compass 									*** */
	string sub = "/dev/i2c-1";
	const char* bus = sub.c_str();	
	if((file = open(bus,O_RDWR))<0){
		perror("Failed to open the bus.\n");
		exit(1);
	}
	if(ioctl(file,I2C_SLAVE,I2C_ADDR_TI)<0){
		perror("Failed to acquire bus access and / or talk to slave.\n");
		exit(1);
	}
	else{
		
		// Timer init ----------------------------------------------
		// ---------------------------------------------------------
		time(&timer);
		monFichier << timer << endl;
		mem = timer;

		// UV measurement loop -------------------------------------
		// ---------------------------------------------------------
			printf("Récupération du CAP UV \n");
		bool varBoolUV = true;
		int i = 0;
		int i_seuil = 200;
		while(varBoolUV){
			i++;
			for(int inc=0;inc<3;inc++){
				digitalWrite(2,HIGH);
				usleep(delai[2]);
				digitalWrite(2,LOW);
			}				
			system("i2cset -y 1 0x70 0x01 0x01");
			if(ioctl(file,I2C_SLAVE,I2C_ADDR_UV)<0){
				perror("Failed to acquire bus access and / or talk to slave.\n");
				exit(1);
			}
			write(file,config,2);
			usleep(25000);

			write(file,reg,1);
			
			if(read(file,data,2)!=2){
				printf("Non 0\n");
			}
			else{
				uvlight0 = ((data[0] & 0x0F)*256) + data[1];
			}
			
			system("i2cset -y 1 0x70 0x01 0x02");
			if(ioctl(file,I2C_SLAVE,I2C_ADDR_UV)<0){
				perror("2 Failed to acquire bus access and / or talk to slave.\n");
				exit(1);
			}
			
			write(file,config,2);
			usleep(25000);

			write(file,reg,1);
			
			if(read(file,data,2)!=2){
				printf("Non 1\n");
			}
			else{
				uvlight1 = ((data[0] & 0x0F)*256) + data[1];
			}
		
			monFichier << "   \t" << uvlight0 << "   \t" << uvlight1 << endl;
			
			int P0 = digitalRead(24);
			int P1 = digitalRead(25);
			
			if((P0 == 0)&&(P1 == 0)&&(i>i_seuil)){	
				varBoolUV = false;
				Compteur = i;
			}
			
		}
		system("i2cset -y 1 0x70 0x01 0x00");	
				
	}
	time(&timer);
	monFichier << timer << endl;
	mem = -mem + timer;

	monFichier.close();
	std::cout << "Time elapsed: " << mem << std::endl;
	std::cout << "Count: " << Compteur << std::endl;
	
	return 0;
}


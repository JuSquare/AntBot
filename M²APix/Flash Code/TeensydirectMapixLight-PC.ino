/*
  SCP1000 Barometric Pressure Sensor Display

  Shows the output of a Barometric Pressure Sensor on a
  Uses the SPI library. For details on the sensor, see:
  http://www.sparkfun.com/commerce/product_info.php?products_id=8161
  http://www.vti.fi/en/support/obsolete_products/pressure_sensors/

  This sketch adapted from Nathan Seidle's SCP1000 example for PIC:
  http://www.sparkfun.com/datasheets/Sensors/SCP1000-Testing.zip

  Circuit:
  SCP1000 sensor attached to pins 6, 7, 10 - 13:
  DRDY: pin 6
  CSB: pin 7
  MOSI: pin 11
  MISO: pin 12
  SCK: pin 13

  created 31 July 2010
  modified 14 August 2010
  by Tom Igoe

  Modified on July 2017 for the Hexabot project 
  @JulienDupeyroux
*/

// the sensor communicates using SPI, so include the library:
#include <SPI.h>


#define NB_UINT32_BYTE  4
#define NB_INT32_BYTE   4
#define NB_INT16_BYTE  2
#define NB_UINT16_BYTE   2
#define NB_UINT8_EVA   26

#define NB_UINT16_EVA   16

// pins used for the connection with the serialize
const int SyncPin = 10;


SPISettings settingsA(1000000, MSBFIRST, SPI_MODE1);

uint16_t eva[NB_UINT16_EVA];
float photodiode;
unsigned long timer = 0, waiting, waiting2, waiting3;
uint16_t temp, i, j = 0;
char *StartMessage = "a";
char *StopMessage = "b";
uint8_t byte8EVA, byteRead;
uint8_t StartAsked = 0;
uint8_t StopAsked = 0;
IntervalTimer Timer;
const int offsetEva = 0;

void setup() {
  Serial.begin(9600);
  //Serial1.begin(3000000);
  // start the SPI library:
  SPI.begin();
  // initalize the  data ready and chip select pins:
  analogWrite(A14, 180);
  pinMode(SyncPin, OUTPUT);

  // give the sensor time to set up:
  delay(500);
  StartAsked = 0;


#ifdef START_MSG
  while (StartAsked == 0)
  {
    if (Serial.available() >= strlen(StartMessage))
    {
      // verifiy that the received stream is well the start stream
      for (i = 0; i < strlen(StartMessage); i++)
      {
        byteRead = Serial.read();
        if ((uint8_t)StartMessage[i] == byteRead)
        {
          StartAsked = 1;
        }
      }
    }
    delay(1);
  }
#endif
  Timer.begin(tick, 1000);
}

void loop() {
  delay(1);
}

void tick() {

  readXRA1404(eva);
  Serial.print(micros());
  Serial.print(",");
  for (i = 1 ; i < NB_UINT16_EVA - 3; i++)
  {
    Serial.print(eva[i]);
    if(i<12)
      Serial.print(",");
  }
  Serial.println("");

#ifdef STOP_MSG
  CheckStopMessage();
#endif
}

void readXRA1404(uint16_t recep[])
{

  digitalWriteFast(SyncPin, LOW);
  SPI.beginTransaction(settingsA);
  for (i = 0; i < NB_UINT16_EVA; i++)
  {
    recep[i] = SPI.transfer(0) << 8;
    recep[i] = recep[i] | SPI.transfer(0);
    recep[i] = (uint16_t)(((recep[i] & 0x07FF) >> 1) - offsetEva);

  }
  SPI.endTransaction();
  digitalWriteFast(SyncPin, HIGH);

}

void CheckStopMessage()
{
  if (Serial.available() >= strlen(StopMessage))
  {
    // verifiy that the received stream is well the stop stream
    for (i = 0; i < strlen(StopMessage); i++)
    {
      byteRead = Serial.read();
      if ((uint8_t)StopMessage[i] == byteRead) StopAsked = 1;
      else StopAsked = 0;
    }
    if (StopAsked)
    {
      Serial.write("STOP");
      setup();
    }
  }

}


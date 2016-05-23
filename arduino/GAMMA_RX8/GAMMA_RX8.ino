

#include <Wire.h>

// Cooking API libraries
#include <arduinoUART.h>
#include <arduinoUtils.h>

// LoRaWAN library
#include <arduinoLoRaWAN.h>


// Device parameters for Back-End registration
////////////////////////////////////////////////////////////
//char DEVICE_EUI[]  = "0102030405060222";
char DEVICE_EUI[]  = "1122334455667788";
//char APP_EUI[] = "4E6AF733529DEECA";
char APP_EUI[] = "70B3D57ED00001AC";
//char APP_KEY[] = "734AD411D5096D509FCACDEA21DE3218";
char APP_KEY[] = "0BF13EF16E8036A9C480B4ECFFC5D1CC";
////////////////////////////////////////////////////////////

//////////////////////////////////////////////
uint8_t socket = SOCKET0;
//////////////////////////////////////////////

// Define port to use in Back-End: from 1 to 223
uint8_t PORT = 1;

// Define data payload to send (maximum is up to data rate)
//char data[] = "0102030405060708090A0B0C0D0E0F";
char data[] = "473872229750833";
// variable
uint8_t error;

const int error_led =  8;
const int good_led =  7; 


int val=1000;


void blink(uint8_t led, uint8_t c, int duration)
{
 for (int i = 0; i < c; i++) {
   digitalWrite(led, HIGH);
   delay(duration);
   digitalWrite(led, LOW);
   delay(duration);
 }
}

 
void setup() 
{
  Serial.begin(9600);
  
  //LoRaWAN example - Send Confirmed packets (with ACK)
  pinMode(error_led, OUTPUT);
  pinMode(good_led, OUTPUT);

  error = LoRaWAN.ON(socket);
  
  // Check status
  if( error != 0 ){
    //1. Switch ON OK
    blink(error_led,3,100);
  }
  //blink(good_led, 5,100);



  
  //////////////////////////////////////////////
  // 2. Set Device EUI
  //////////////////////////////////////////////

  error = LoRaWAN.setDeviceEUI(DEVICE_EUI);

  // Check status
  if( error != 0 ) 
  {    //2. Device EUI set OK
    blink(error_led,3,100);
  }


  //////////////////////////////////////////////
  // 3. Set Application EUI
  //////////////////////////////////////////////
  /* error = LoRaWAN.setDeviceAddr(DEVICE_ADDR);
   if( error != 0 ) 
    {
     blink(error_led,5,100);
    }
    blink(good_led, 5,100);
*/
 
  error = LoRaWAN.setAppEUI(APP_EUI);

  // Check status
  if( error != 0 ) 
  {
     blink(error_led,3,100);
  }
  //blink(good_led, 5,100);

  //////////////////////////////////////////////
  // 4. Set Application Session Key
  //////////////////////////////////////////////
 
  error = LoRaWAN.setAppKey(APP_KEY);

  // Check status
  if( error != 0 ) 
  {
     blink(error_led,3,100);
  }

  // blink(good_led, 5,100);
  //////////////////////////////////////////////
  // 5. Save configuration
  //////////////////////////////////////////////

 // Check status
  if(LoRaWAN.saveConfig() != 0 ) 
  {
     blink(error_led,5,100);
  }
  blink(good_led, 5,100);

  //------------------------------------
  //Module configured
  //------------------------------------
  
  LoRaWAN.getDeviceEUI();
  //Device EUI in LoRaWAN._devEUI
  
  LoRaWAN.getDeviceAddr();
  //Device Addres in LoRaWAN._devAddr
  blink(good_led, 1,100);
}


void loop() 
{
  //analogRead(0);
  //delay(10);
 // val = analogRead(0);
 
  //if (val > 250){

      blink(good_led, 1,100);
    
      if(LoRaWAN.ON(socket) != 0 ) {
         blink(error_led,5,100);
      }
    
       // Check status
      if(LoRaWAN.joinOTAA() != 0 ) {
         blink(error_led,5,100);
      }

    
      error = LoRaWAN.sendUnconfirmed(PORT, data);
      if( error > 0 ) {
         blink(error_led,error,300);
      }
     
      //   // Error messages:
      //   /*
      //    * '6' : Module hasn't joined a network
      //    * '5' : Sending error
      //    * '4' : Error with data length
      //    * '2' : Module didn't response
      //    * '1' : Module communication error
      //    */
      //   // Check status
    
      // delay(10000);
      error = LoRaWAN.OFF(socket);    
      if( error != 0 ) {
         blink(error_led,5,100);
      }
      delay(200);
      blink(error_led,1,100);
      delay(2000);
  //}else{
    delay(1000);  
  //}  
}


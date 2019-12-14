#include <WiFi.h>
#include <WebServer.h>
#include <WiFiUdp.h>
/*#include <OSCMessage.h>*/


/* Put your SSID & Password */
const char* ssid = "ItaiESP";  // Enter SSID here
const char* password = "computer";  //Enter Password here

/* Put IP Address details */
IPAddress local_ip(192,168,1,1);
IPAddress gateway(192,168,1,1);
IPAddress subnet(255,255,255,0);

WebServer server(80);

WiFiUDP udp;

//pin nums
int rightArm = 34;
int leftArm = 32;
//int rightLeg = 35;//failed: 14 27 25 26 19
//int leftLeg = 23;// failed: 23
int head = 35;
int led = 18;

//variables for pin readings
int leftArmVal = 0;
int rightArmVal = 0;
int leftLegVal = 0;
int rightLegVal = 0;
int headVal = 0;

//for shutting out sensor noise
int dif=0;

//ellapsed time tracker
int msec=0;

void setup() {

  Serial.begin(115200);

  WiFi.softAP(ssid, password);
  WiFi.softAPConfig(local_ip, gateway, subnet);

  server.begin();

  pinMode(leftArm, INPUT);
  pinMode(rightArm, INPUT);
  //pinMode(leftLeg, INPUT);
  //pinMode(rightLeg, INPUT);
  pinMode(head, INPUT);
  pinMode(led, OUTPUT);
  
   
}

void loop(){
  //ellapsed time tracker
  msec= millis();
    
    //only do sensors checks once every second
    if(msec%1000==0){
      sensorCheck(leftArm, leftArmVal, "leftArm");

      sensorCheck(rightArm, rightArmVal, "rightArm");

      //sensorCheck(rightLeg, rightLegVal, "rightLeg");

      //sensorCheck(leftLeg, leftLegVal, "leftLeg");

      sensorCheck(head, headVal, "head");
    }
   
  //LED heart beat babump
  if(msec%1000<=3 || (msec%1000>=300 && msec%1000<=303)){
  digitalWrite(led, HIGH);
  }
  if((msec%1000>=100 && msec%500 <103)||(msec%1000>=400 && msec%1000<=403)){
    digitalWrite(led,LOW);
  }
}

//UDP protocol
void message(String key, int val){
  udp.beginPacket("192.168.1.2", 57222);
  udp.printf("%s, %i", key, val);
  udp.endPacket();
  //Serial.println("message sent. " + String(key)+ " " + String(val));
  Serial.printf("%s, %i \n", key, val);
}

//sensor check protocol
void sensorCheck (int pin, int val, String pinName){
  dif = analogRead(pin);
      if (dif>2350 || dif <=5){
        dif -= val;
      
        if(abs(dif) >= 25){
          val += dif;
          message(pinName, val);
        }   
      }
}

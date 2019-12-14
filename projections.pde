import processing.video.*;
import hypermedia.net.*;
import processing.net.*; 

Movie myMovie;

int PORT = 57222;
String IP = "192.168.1.2";

String message = "";
String [] instruction = new String[2];
UDP udp;  

int maxVal = 4095;
int rArmMin = 2900; 
int lArmMin = 3050; 
int headMin = 3200; 
int headDivisions = 11;
float headInterval=125.3/headDivisions;

int timer = 0;

float [] rArmTimes = {125.3, 130.6, 154, 173.9, 194.8, 215.5};
float [] lArmTimes = {235.4, 244, 256.8, 275.8, 301, 321, 331.67, 348.6, 366, 390.1, 406.47, 421.6, 426.3};

int playStartTime=99999;


void setup(){
  udp = new UDP( this, PORT, IP);  // create a new datagram connection on port 
  //udp.log( true );         // <-- printout the connection activity
  udp.listen(true); 
  
  fullScreen();
  //size(400, 400);
  background(0); 
  myMovie = new Movie(this, "CES_Final_projections.mp4");
  myMovie.loop();
  playStartTime = millis();
}

void draw(){
  background(0);
  //play each clip for 5 seconds and then start listening for messages again
  if(timer-playStartTime <7000 && timer >=0){

    //each clip fades to black over its 5 seconds
    tint(255, 255-int(map(timer-playStartTime,0, 7000, 0, 255)));
    image(myMovie, 0, 0, width, height);
    timer = millis();
  }
  else{
   
    timer =0;
  }
}

void movieEvent (Movie m){
  m.read();
}

void receive(byte[] data, String PORT, int IP) {   // <-- extended handler
  if (data != null) {
  // void receive( byte[] data ) {          // <-- default handler
  
    if (timer == 0){
      translate(data);
      instruction = split(message, ", ");
      playStartTime = millis();
      switch(instruction[0]){
        case "leftArm":
          skip(constrain(float(instruction[1]),lArmMin,4095), float(lArmMin), float(maxVal), lArmTimes);
          break;
        case "rightArm":
          
          skip(constrain(float(instruction[1]),rArmMin,4095), float(rArmMin), float(maxVal), rArmTimes);
          break;
        case "head":
          myMovie.jump(headInterval * round(map(constrain(float(instruction[1]),headMin,maxVal), float(headMin), float(maxVal), 0, headDivisions)));
          break;
      }
    }
  }
}
  
void translate(byte[] ascii){
  message ="";
  for (int i=0; i<ascii.length; i++){
    message= message+char(ascii[i]);
  }
  println(message);
}

void skip(float val, float min, float max, float [] list){
  int timesListIndex = round(map(val, min, max, 0, list.length-1));
  float spot;
  if(timesListIndex<list.length-1){
    float maxStart = list[timesListIndex+1]- 8;
    spot = random(list[timesListIndex], maxStart);
    myMovie.jump(spot);
    println(spot);
  }
  else{
    spot = random(list[timesListIndex], list[timesListIndex]+9);
    myMovie.jump(spot);
    println(spot);
  }
}

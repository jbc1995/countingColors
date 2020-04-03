/*
  Based on this code:
  http://www.arduino.cc/en/Tutorial/SerialCallResponse
*/

#include <RotaryEncoder.h>

#define p1ButtonPin 3   // P1 button switch is connected to pin D3
#define p2ButtonPin 4   // P2 button switch is connected to pin D4

RotaryEncoder encoder1(A0,A1); // P1 encoder is connected to pins A0 and A1
RotaryEncoder encoder2(A2,A3); // P2 encoder is connected to pins A2 and A3

int p1Button = 0;
int p2Button = 0;

int inByte = 0;         // incoming serial byte

void setup() {
  
  Serial.begin(57600);      // start serial port at 57600 bps:
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(p1ButtonPin, INPUT);   // button is on digital pin 3
  pinMode(p2ButtonPin, INPUT);   // button is on digital pin 4
  
  establishContact();  // send a byte to establish contact until receiver responds
}

void loop() {
 
  // if we get a valid byte response from Processing, then we read analog ins:
  if (Serial.available() > 0) {
    
    inByte = Serial.read();          // get incoming byte:

    p1Button = map(digitalRead(3), 0, 1, 255, 0);
    p2Button = map(digitalRead(4), 0, 1, 255, 0);   // now read the button, map it to 0 or 255 to make things simpler

    static int pos1 = 0;
    encoder1.tick();

    int newPos1 = encoder1.getPosition();
    if (pos1 != newPos1) {
      pos1 = newPos1;
    }

    static int pos2 = 0;
    encoder2.tick();

    int newPos2 = encoder2.getPosition();
    if (pos2 != newPos2) {
      pos2 = newPos2;
    }

    // Then send all this data to Processing
    Serial.write(p1Button);
    Serial.write(p2Button);
    Serial.write(pos1);
    Serial.write(pos2);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
}

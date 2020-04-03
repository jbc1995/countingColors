
import processing.serial.*;


Serial myPort;                       // The serial port
int[] serialInArray = new int[4];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller

//int joyX, joyY, p1Button, p2Button, encoderPos;              // Variables for storing incoming sensor data
//boolean joyXRight = false;
//boolean joyXLeft = false;

int p1Button, p2Button, p1EncoderPos, p2EncoderPos;

void startSerial() {
  
  // Print a list of the serial ports for debugging purposes
  printArray(Serial.list());
  
  // Open whatever port is the one you're using.
  int portNumber = 0;
  String portName = Serial.list()[portNumber];
  myPort = new Serial(this, portName, 57600);
  
}


// This gets called whenever the serial port gets new data
void serialEvent(Serial myPort) {
  
  int inByte = myPort.read();        // read a byte from the serial port...
  
  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array of sensor values
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }
    
  // this piece of code captures the sensor data coming in  
  } else {
    
    serialInArray[serialCount] = inByte;    // Add the latest byte from the serial port to array
    serialCount++;                          // Increment count of how many data we've already received
   
    if (serialCount > 3 ) {           // If we have 3 bytes, that means we got everything and we are ready to act on it.
    
//      joyX = serialInArray[0];
//      joyY = serialInArray[1];
      p1Button = serialInArray[0];
      p2Button = serialInArray[1];
      p1EncoderPos = serialInArray[2];
      p2EncoderPos = serialInArray[3];
   
      // Output to Processing console so we can see what incoming data looks like
      if (printInputDeviceValues) {
        //println(joyX + "\t" + joyY + "\t" + p1Button + "\t" + p2Button + "\t" + encoderPos);
        println(p1Button + "\t" + p2Button + "\t" + p1EncoderPos + "\t" + p2EncoderPos);
      }
      
      //executeJoystickInput(joyX);
      executeP1EncoderInput(p1EncoderPos);
      executeP2EncoderInput(p2EncoderPos);
   
      myPort.write('A');        // Send a capital A to request new sensor readings
      serialCount = 0;          // Reset serialCount, so we can get a new stream
    }
  }
}

boolean isP1ButtonPressed() {
  if (p1Button > 0) {
    return true;
  }
  else {
    return false;
  }
}

boolean isP2ButtonPressed() {
  if (p2Button > 0) {
    return true;
  }
  else {
    return false;
  }
}

boolean isButtonPressed() {
  return (isP1ButtonPressed() || isP2ButtonPressed());
}
    
//void executeJoystickInput(int _joyX) {
  
//   // Check if joystick has moved to the right
//   if((_joyX > 150) && (joyXRight == false)) {
//     playerOne.editGuess(1);                        // move player
//     joyXRight = true;                         // don't let player move again until joystick has gone back to center
     
//   } else if(_joyX < 135) {                    // has joystick gone back to center?
//     joyXRight = false;                        // now free up player to move again
//   }
   
   
//   // Check if joystick has moved to the left
//    if((_joyX < 80) && (joyXLeft == false)) {
//     playerOne.editGuess(-1);                        // move player
//     joyXLeft = true;                           // don't let player move again until joystick has gone back to center
     
//   } else if(_joyX > 120) {                    // has joystick gone back to center?
//     joyXLeft = false;                         // now free up player to move again
//   }
//}

static int pos1 = 0;

void executeP1EncoderInput(int _newPos) {
  if (pos1 != _newPos) {
    if (pos1 == 0) {
      if (_newPos == 255) {
        playerOne.editGuess(-1);
      }
      else if (_newPos == 1) {
        playerOne.editGuess(1);
      }
    }
    else if (pos1 == 255) {
      if (_newPos == 0) {
        playerOne.editGuess(1); 
      }
      else if (_newPos == 254) {
        playerOne.editGuess(-1);
      }
    }
    else {
      if (pos1 > _newPos) {
        playerOne.editGuess(-1);
      }
      else {
        playerOne.editGuess(1);
      }
    }
  }
  pos1 = _newPos;
}

static int pos2 = 0;

void executeP2EncoderInput(int _newPos) {
  if (pos2 != _newPos) {
    if (pos2 == 0) {
      if (_newPos == 255) {
        playerTwo.editGuess(-1);
      }
      else if (_newPos == 1) {
        playerTwo.editGuess(1);
      }
    }
    else if (pos2 == 255) {
      if (_newPos == 0) {
        playerTwo.editGuess(1); 
      }
      else if (_newPos == 254) {
        playerTwo.editGuess(-1);
      }
    }
    else {
      if (pos2 > _newPos) {
        playerTwo.editGuess(-1);
      }
      else {
        playerTwo.editGuess(1);
      }
    }
  }
  pos2 = _newPos;
}
    
    

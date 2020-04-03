
/* /////////////////////////////////////

  4.043 / 4.044 Design Studio: Advanced Interactions
  February  5, 2020
  Marcelo Coelho

  Note:
  - Don't forget to install gif library provided

*/ /////////////////////////////////////

import gifAnimation.*;                      // library for playing animated gifs

final static int displaySize = 30;          // how many pixels are visible in the game
final int displayPixelSize = 60;     // how big should they look on screen

color cyan = color(64,224,249);
color yellow = color(255,230,0);
color green = color(24,249,24);
color magenta = color(249,64,224);

color initColor = color(0);
color guessLocked = color(255);
color[] colors = {green, magenta, cyan, yellow};
int colorMax = displaySize/2 - 2;

DisplayBuffer display = new DisplayBuffer(displaySize);    // aggregates our final visual output

Player playerOne = new Player(true);             // Adding 2 players to the game
Player playerTwo = new Player(false);

int counterInit = 0;

int easyNumColors = 2;
int mediumNumColors = 3;
int hardNumColors = 4;
int easySize = 8;
int mediumSize = 12;
int hardSize = 16;
int easyMaxCounter = 100;
int mediumMaxCounter = 100;
int hardMaxCounter = 100;

boolean printMarqueeValues = false;

Marquee easyMarquee = new Marquee("easy");
Marquee mediumMarquee = new Marquee("medium");
Marquee hardMarquee = new Marquee("hard");
Marquee[] marquees = {easyMarquee, mediumMarquee, hardMarquee};
int marqueeCounter = counterInit;
int marqueeCounterMax;

Target target = new Target(displaySize);

int scoreDisplayCounter = counterInit;
int scoreDisplayCounterMax = 100;

int round = 0;
int startRound = 0;
int roundMax = 4;
int difficulty = 0;
int startDifficulty = 0;
int difficultyMax = 2;

boolean sPressed = false;
boolean kPressed = false;

Controller controller = new Controller();   // this is where the state machine and software logic lives
String gameState = "RESET";

boolean printInputDeviceValues = false;

PImage[] animation;

int currentFrame = 0;
int appFramerate = 30;
int numFrames =  30;

void settings() {
  //size((displaySize*displayPixelSize), displayPixelSize);    // dynamically sets canvas size
  //size(displaySize*displayPixelSize, 900);
  fullScreen();
}

void setup() {
  frameRate(appFramerate);     //  important to lock the framerate, so animations are smooth
  animation = Gif.getPImages(this, "Animation.gif");
  startSerial();    // initiating the serial port so we can communicate with joystick
}


void draw() { 
   // Not used, but you might find helpful to count frames for animations or synchronization
   //currentFrame = (currentFrame+1) % numFrames; 
   //println(currentFrame);
  
    // Runs state machine at determined framerate
  	controller.update();
}


// This is where your state machines and game logic lives


class Controller {

  Controller() {

  }


  void update() {
    
    // STATE MACHINE
    switch (gameState) {
      
      case "RESET":
      
        round = startRound;
        difficulty = startDifficulty;
        playerOne.reset();
        playerTwo.reset();
        marqueeCounter = counterInit;
        gameState = "MARQUEE";
        break;
        
      case "MARQUEE":
      
        if (marqueeCounter == 0) {
          display.clear();
          marqueeCounterMax = marquees[difficulty].counterMax;
          marquees[difficulty].fill();
          int position = displaySize/2 - marquees[difficulty].size/2;
          for (int i = 0; i < marquees[difficulty].size; i++) {
            display.setPixel(position, marquees[difficulty].colorArray[i]);
            position++;
          }
        }
        marqueeCounter++;
        if (marqueeCounter >= marqueeCounterMax) {
          marqueeCounter = 0;
          target.chooseTargetColors(marquees[difficulty].numColors);
          playerOne.guessingEnabled = true;
          playerTwo.guessingEnabled = true;
          gameState = "PLAY";
        }
      
        break;
        
      case "PLAY":
      
        display.clear();
        display.setPixel(target.p1Position, target.p1Color);
        if (playerOne.guess > 0) {
          display.setPixelsUntil((playerOne.position + playerOne.guess), target.p1Color, true);
        }
        display.setPixel(target.p2Position, target.p2Color);
        if (playerTwo.guess > 0) {
          display.setPixelsUntil((playerTwo.position - playerTwo.guess), target.p2Color, false);
        }
        if (isP1ButtonPressed() || sPressed) {
          sPressed = false;
          playerOne.guessingEnabled = false;
        }
        if (isP2ButtonPressed() || kPressed) {
          kPressed = false;
          playerTwo.guessingEnabled = false;
        }
        if (!playerOne.guessingEnabled) {
          display.setPixel(target.p1Position, guessLocked);
          display.setPixelsUntil((playerOne.position + playerOne.guess), guessLocked, true);
        }
        if (!playerTwo.guessingEnabled) {
          display.setPixel(target.p2Position, guessLocked);
          display.setPixelsUntil((playerTwo.position - playerTwo.guess), guessLocked, false);
        }
        if (!playerOne.guessingEnabled && !playerTwo.guessingEnabled) {
          display.clear();
          if (playerOne.guess == marquees[difficulty].targetArray[target.p1Target]) {
            //display.setPixelsUntil(displaySize/2 - 1, target.p1Color, true);
            display.setPixelsUntil(displaySize/2 - 1, playerOne.playerColor, true);
            playerOne.increaseScore();
          }
          else {
            display.setPixelsUntil(displaySize/2 - 1, initColor, true);
          }
          if (playerTwo.guess == marquees[difficulty].targetArray[target.p2Target]) {
            //display.setPixelsUntil(displaySize/2, target.p2Color, false);
            display.setPixelsUntil(displaySize/2, playerTwo.playerColor, false);
            playerTwo.increaseScore();
          }
          else {
            display.setPixelsUntil(displaySize/2, initColor, false);
          }
          scoreDisplayCounter = 0;
          gameState = "SCORE";
        }
          
        break;
    
      case "SCORE":
           
        if (scoreDisplayCounter >= scoreDisplayCounterMax) {
          scoreDisplayCounter = counterInit;
          round++;
          if (round > roundMax) {
            round = 0;
            difficulty++;
            if (difficulty > difficultyMax) {
              difficulty = 0;
              display.clear();
              if (playerOne.score > 0) {
                display.setPixelsUntil(playerOne.position + playerOne.score, playerOne.playerColor, true);
              }
              if (playerTwo.score > 0) {
                display.setPixelsUntil(playerTwo.position - playerTwo.score, playerTwo.playerColor, false);
              }
              gameState = "GAME_OVER";
              break;
            }
          }
          playerOne.guessReset();
          playerTwo.guessReset();
          marqueeCounter = counterInit;
          gameState = "MARQUEE";
        }
        scoreDisplayCounter++;
                         
        break;
        
      case "GAME_OVER":
      
        if (isButtonPressed()) {
          gameState = "RESET";
        }
      
        break;
      
      // Not used, it's here just for code consistency
      default:
        break;
    }
    
    // Now that we are done populating the buffer, let's show it!
    display.show();
    
  }

}


// Helper function to advance animation frames 
int nextFrame(int _animationSize) {
  if (currentFrame < _animationSize-1) {
    currentFrame++;
  } else {
    currentFrame = 0;
  }
  return currentFrame;
}  



// All the keyboard  input goes here.
// If your game starts getting too complex, you could move the key detection events insde of the player class. 
// It's a more advanced ways of doing of the same thing. Example here: https://forum.processing.org/two/discussion/comment/34602/#Comment_34602
void keyPressed() {
  int keyIndex = -1;

  //println(key);

  if (key == 'A' || key == 'a') {
    playerOne.editGuess(-1);
  }
  
  if (key == 'S' || key == 's') {
    sPressed = true;
  }

  if (key == 'D' || key == 'd') {
    playerOne.editGuess(1);
  }


  if (key == 'J' || key == 'j') {
    playerTwo.editGuess(1);
  }
  
  if (key == 'K' || key == 'k') {
    kPressed = true;
  }

  if (key == 'L' || key == 'l') {
    playerTwo.editGuess(-1);
  }

  if (key == 'R' || key == 'r') {
    gameState = "RESET";
  }

}

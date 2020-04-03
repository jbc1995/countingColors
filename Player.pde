// This holds some player information, like color and position.
// It also has some player methods for managing how a player moves.


class Player {

  color playerColor;
  int position;
  int guess;
  int maxGuess;
  int score;
  boolean guessingEnabled;


  Player(boolean player1) {
    if (player1) {
      position = -1;
      playerColor = cyan;
    }
    else {
      position = displaySize;
      playerColor = yellow;
    }
    guess = 0;
    score = 0;
    guessingEnabled = false;
    maxGuess = colorMax;
  }
  
  void guessReset() {
    guess = 0;
    guessingEnabled = false;
  }
  
  void reset() {
    score = 0;
    guessReset();
  }

  // Move player based on keyboard input
  void editGuess(int _change) {
    if (guessingEnabled) {
      guess = guess + _change;
      
      if (guess < 0) {
        guess = 0;
      } else if (guess > maxGuess) {
        guess = maxGuess;
      }
    }
  }
  
  void increaseScore() {
    score++;
  }

}

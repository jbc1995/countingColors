// This is the target that players need to catch.
// The 'explosion' animation could happen here rather than the state machine.


class Target {

  int numColors;
  color p1Color;
  color p2Color;
  int p1Target;
  int p2Target;
  int p1Position;
  int p2Position;

  Target(int _displaySize) {
    p1Position = _displaySize/2 - 1;
    p2Position = _displaySize/2;
  }
  
  void chooseTargetColors(int _numColors) { 
    float rand1 = random(0, _numColors);
    if (rand1 <= 1) {
      p1Color = colors[0];
      p1Target = 0;
    }
    else if (rand1 <= 2) {
      p1Color = colors[1];
      p1Target = 1;
    }
    else if (rand1 <= 3) {
      p1Color = colors[2];
      p1Target = 2;
    }
    else if (rand1 <= 4) {
      p1Color = colors[3];
      p1Target = 3;
    }
    do {
      float rand2 = random(0, _numColors);
      if (rand2 <= 1) {
        p2Color = colors[0];
        p2Target = 0;
      }
      else if (rand2 <= 2) {
        p2Color = colors[1];
        p2Target = 1;
      }
      else if (rand2 <= 3) {
        p2Color = colors[2];
        p2Target = 2;
      }
      else if (rand2 <= 4) {
        p2Color = colors[3];
        p2Target = 3;
      }
//      println("do-while loop");
    } while (p1Target == p2Target);
  }

}

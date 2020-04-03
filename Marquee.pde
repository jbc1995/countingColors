// This holds the marquee information, like number of colors and size.
// It also has some methods for managing how the marquee moves.


class Marquee {

  color[] colorArray;
  int numColors;
  int size;
  int counterMax;
  int[] targetArray;

  Marquee(String _difficulty) {
    if (_difficulty == "easy") {
      numColors = easyNumColors;
      size = easySize;
      counterMax = easyMaxCounter;
    }
    else if (_difficulty == "medium") {
      numColors = mediumNumColors;
      size = mediumSize;
      counterMax = mediumMaxCounter;
    }
    else if (_difficulty == "hard") {
      numColors = hardNumColors;
      size = hardSize;
      counterMax = hardMaxCounter;
    }
    colorArray = new color[size];
    targetArray = new int[numColors];
    println(numColors);
  }
  
  void fill() {
    for (int i = 0; i < numColors; i++) {
      targetArray[i] = 0;
    }
    for (int i = 0; i < size; i++) {
      float rand = random(0,numColors);
      if (rand <= 1) {
        if (targetArray[0] >= colorMax) {
          i--;
        }
        else {
          colorArray[i] = colors[0];
          targetArray[0]++;
        }
      }
      else if (rand <= 2) {
        if (targetArray[1] >= colorMax) {
          i--;
        }
        else { 
          colorArray[i] = colors[1];
          targetArray[1]++;
        }
      }
      else if (rand <= 3) {
        if (targetArray[2] >= colorMax) {
          i--;
        }
        else {
          colorArray[i] = colors[2];
          targetArray[2]++;
        }
      }
      else if (rand <= 4) {
        if (targetArray[3] >= colorMax) {
          i--;
        }
        else {
          colorArray[i] = colors[3];
          targetArray[3]++;
        }
      }
    }
    if (printMarqueeValues) {
      for (int i = 0; i < numColors; i++) {
        print(targetArray[i] + " ");
      }
      println();
    }
  }
}

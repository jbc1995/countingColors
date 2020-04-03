
// This is used to aggregrate visual information from all objects before we display them. 
// First we populate the buffer and then we show it.
// This is particularly helpful once you start outputting your game to an LED strip, of if you want to have two separate 'screens'

class DisplayBuffer { 

  int displaySize;
  color[] displayBuffer;


  // Constructor sets initial size and frame for buffer
  DisplayBuffer (int _size) { 

    displaySize = _size;
    displayBuffer = new color[displaySize];

    for(int i = 0; i < displaySize; i++) {    // initialize display with black
      displayBuffer[i] = initColor; 
    }

  } 

  // Color a specific pixel in the buffer
  void setPixel(int  _index, color _c) {
    displayBuffer[_index]  = _c;
  }
  
  // Color pixels from edge until specified pixel
  void setPixelsUntil(int _index, color _c, boolean fromLeft) {
    if (fromLeft) {
      for (int i = 0; i <= _index; i++) {
        displayBuffer[i] = _c;
      }
    }
    else {
      for (int i = displaySize - 1; i >= _index; i--) {
        displayBuffer[i] = _c;
      }
    }
  }

  // Color all pixels in the buffer
  void setAllPixels(color _c) {
     
    for(int i = 0; i < displaySize; i++) { 
      display.setPixel(i, _c); 
    }
  }
  
  void setWinBanner(color _c1, color _c2) {
    for (int i = 0; i < displaySize; i += 2) {
      setPixel(i, _c1);
    }
    for (int i = 1; i < displaySize; i += 2) {
      setPixel(i, _c2);
    }
  }

  // Now write it to screen
  void show() { 

    for(int i = 0; i < displaySize; i++) {
      fill(displayBuffer[i]);
      rect((i*displayPixelSize) + (width - displaySize*displayPixelSize)/2, (height - displayPixelSize)/2, displayPixelSize, displayPixelSize);
    }
  } 

  // Let's empty everything before we start adding things to it again
  void clear() {
    setAllPixels(initColor);    
  }

} 

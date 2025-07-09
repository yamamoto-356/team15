int cols = 5;
int rows = 13;
int blockWidth = 30;
int blockHeight = 30;
int margin = 5;

void setup() {
  size(200, 450);
  background(255);
  noStroke();
  drawBlocks();
}

void drawBlocks() {
  for (int i = 0; i < rows; i++) {
   
    ArrayList<Integer> specialCols = new ArrayList<Integer>();
    int numSpecial = int(random(1,3)); 

    while (specialCols.size() < numSpecial) {
      int randCol = int(random(cols));
      if (!specialCols.contains(randCol)) {
        specialCols.add(randCol);
      }
    }

    for (int j = 0; j < cols; j++) {
      float x = j * (blockWidth + margin);
      float y = i * (blockHeight + margin);
     
      if (i == rows - 1) {
        fill(100, 150, 255);}
     else if (specialCols.contains(j)) {
        fill(255, 100, 100); 
      } else {
        fill(100, 150, 255); 
      }

      rect(x, y, blockWidth, blockHeight);
    }
  }
}

class Block {
  int col, row;
  int side;
  boolean isMoving;
  int moveDir = 1;
  int moveCooldown = 0;

  Block(int col, int row, int side) {
    this.col = col;
    this.row = row;
    this.side = side;
    this.isMoving = false;
    moveDir = 1;
    moveCooldown = 0;
  }

  void setMoving(boolean moving) {
    this.isMoving = moving;
    if (moving) {
      moveCooldown = 18;
    }
  }

  void update() {
    if (isMoving) {
      moveCooldown--;
      if (moveCooldown <= 0) {
        int nextCol = col + moveDir;
        if (nextCol < 0 || nextCol >= colsPerPlayer) {
          moveDir *= -1;
          nextCol = col + moveDir;
        }
        col = nextCol;
        moveCooldown = 18;
      }
    }
  }


void display() {
  int xOffset = (side == 0) ? 0 : width / 2;
  float x = xOffset + col * cellW;
  float y = row * cellH;

  if (isMoving) {
    if (moveDir > 0 && carRightImg != null) {
      image(carRightImg, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
    } else if (moveDir < 0 && carLeftImg != null) {
      image(carLeftImg, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
    } else {
      fill(120);
      noStroke();
      rect(x, y, cellW, cellH);
    }
  } else if (!isMoving && treeImg != null) {
    image(treeImg, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
  } else {
    fill(120);
    noStroke();
    rect(x, y, cellW, cellH);
  }
}



  boolean isHit(Player p) {
    int xOffset = (side == 0) ? 0 : width / 2;
    float blockX = xOffset + col * cellW;
    float blockY = row * cellH;

    float playerX = (p.side == 0) ? p.col * cellW : width / 2 + p.col * cellW;
    float playerY = p.baseY;

    return abs(blockX - playerX) < cellW * 0.5 && abs(blockY - playerY) < cellH * 0.5;
  }
}

class Block {
  int col, row;
  int side;

  boolean isMoving;    // 動くかどうか
  int moveDir = 1;     // 1 = 右, -1 = 左
  int moveCooldown = 0; // 移動タイミング用カウンタ

  Block(int col, int row, int side) {
    this.col = col;
    this.row = row;
    this.side = side;
    this.isMoving = false;
  }

  void setMoving(boolean moving) {
    isMoving = moving;
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
        moveCooldown = 30; // 動く間隔（フレーム数）
      }
    }
  }

  void display() {
    int xOffset = (side == 0) ? 0 : width / 2;
    float x = xOffset + col * cellW;
    float y = row * cellH;

    fill(isMoving ? color(255, 180, 0) : 120);
    noStroke();
    rect(x, y, cellW, cellH);
  }

  boolean isHit(Player p) {
    return p.col == col && p.row == row && p.side == side;
  }
}

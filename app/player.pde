class Player {
  int col, row;
  int startCol, startRow;
  int side;

  // 操作キーはcharかkeyCodeのどちらかで判定
  char leftKey, rightKey, upKey, downKey;
  int leftKeyCode = -1, rightKeyCode = -1, upKeyCode = -1, downKeyCode = -1;

  PImage imgRight;
  PImage imgLeft;

  boolean facingRight = true;

  // charキー操作用コンストラクタ（a,d,w,s用）
  Player(int col, int row, char lk, char rk, char uk, char dk, int side, PImage imgRight, PImage imgLeft) {
    this.col = this.startCol = col;
    this.row = this.startRow = row;
    this.leftKey = lk;
    this.rightKey = rk;
    this.upKey = uk;
    this.downKey = dk;
    this.side = side;
    this.imgRight = imgRight;
    this.imgLeft = imgLeft;
  }

  // keyCode用コンストラクタ（矢印キー用）
  Player(int col, int row, int lkCode, int rkCode, int ukCode, int dkCode, int side, PImage imgRight, PImage imgLeft) {
    this.col = this.startCol = col;
    this.row = this.startRow = row;
    this.leftKeyCode = lkCode;
    this.rightKeyCode = rkCode;
    this.upKeyCode = ukCode;
    this.downKeyCode = dkCode;
    this.side = side;
    this.imgRight = imgRight;
    this.imgLeft = imgLeft;
  }

  void update() {
    col = constrain(col, 0, colsPerPlayer - 1);
    row = constrain(row, 0, 19);
  }

  void handleInput(char k, int kc) {
    if (leftKey != 0 && k == leftKey) {
      col -= 1;
      facingRight = false;
    } else if (rightKey != 0 && k == rightKey) {
      col += 1;
      facingRight = true;
    } else if (upKey != 0 && k == upKey) {
      row -= 1;
    } else if (downKey != 0 && k == downKey) {
      row += 1;
    }
    // keyCode判定（矢印キー用）
    else if (leftKeyCode != -1 && kc == leftKeyCode) {
      col -= 1;
      facingRight = false;
    } else if (rightKeyCode != -1 && kc == rightKeyCode) {
      col += 1;
      facingRight = true;
    } else if (upKeyCode != -1 && kc == upKeyCode) {
      row -= 1;
    } else if (downKeyCode != -1 && kc == downKeyCode) {
      row += 1;
    }
  }

  void display() {
    int xOffset = (side == 0) ? 0 : width / 2;
    float x = xOffset + col * cellW;
    float y = row * cellH;

    if (facingRight) {
      image(imgRight, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
    } else {
      image(imgLeft, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
    }
  }

  void reset() {
    col = startCol;
    row = startRow;
  }
}

class Player {
  int col, row;
  int startCol, startRow;
  int side;
  
  float life = 2.0;

  // 操作キーはcharかkeyCodeのどちらかで判定
  char leftKey, rightKey, upKey, downKey;
  int leftKeyCode = -1, rightKeyCode = -1, upKeyCode = -1, downKeyCode = -1;

  PImage imgRight;
  PImage imgLeft;

  boolean facingRight = true;

  // ジャンプ用変数
  boolean isJumping = false;
  float jumpVelocity = 0;
  float gravity = 0.5;
  float baseY;          // Y座標の基本位置（行から計算）
  float shakeOffsetY = 0; // 揺れのオフセット

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

    float targetY = row * cellH;

    if (isJumping) {
      jumpVelocity += gravity;
      baseY += jumpVelocity;

      if (baseY >= targetY) {
        baseY = targetY;
        isJumping = false;
        jumpVelocity = 0;

        if (row > 0) {
          row--;
        }
        shakeOffsetY = 0;
      } else {
        
        shakeOffsetY = 1.5 * sin(millis() * 0.04);
      }
    } else {
      baseY = targetY;
      shakeOffsetY = 0;
    }
  }

  void handleInput(char k, int kc) {
    if (leftKey != 0 && k == leftKey) {
      col -= 1;
      facingRight = false;
    } else if (rightKey != 0 && k == rightKey) {
      col += 1;
      facingRight = true;
    }

    // ジャンプ開始判定
    if ((upKey != 0 && k == upKey) || (upKeyCode != -1 && kc == upKeyCode)) {
      startJump();
    }

    if (downKey != 0 && k == downKey) {
      row += 1;
    }

    if (leftKeyCode != -1 && kc == leftKeyCode) {
      col -= 1;
      facingRight = false;
    } else if (rightKeyCode != -1 && kc == rightKeyCode) {
      col += 1;
      facingRight = true;
    } else if (downKeyCode != -1 && kc == downKeyCode) {
      row += 1;
    }
  }

  void display() {
    int xOffset = (side == 0) ? 0 : width / 2;
    float x = xOffset + col * cellW;
    float y = baseY + shakeOffsetY;

    if (facingRight) {
      image(imgRight, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
    } else {
      image(imgLeft, x + cellW * 0.1, y + cellH * 0.1, cellW * 0.8, cellH * 0.8);
    }
  }

  void reset() {
    life -= 1.0;
    col = startCol;
    row = startRow;
    isJumping = false;
    jumpVelocity = 0;
    shakeOffsetY = 0;
  }

  void startJump() {
    if (!isJumping) {
      isJumping = true;
      jumpVelocity = -4;  
    }
  }
  
  boolean isDead(){
    return life <= 0;
  }
}

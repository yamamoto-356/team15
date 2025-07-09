class Player {
  int col, row;
  int startCol, startRow;
  int side; // 0 = 左画面, 1 = 右画面
  char leftKey, rightKey, upKey, downKey;
  int leftCode, rightCode, upCode, downCode;

  int staticFrame = 0;
  PVector lastPos;

  Player(int col, int row, char lk, char rk, char uk, char dk, int side) {
    this.col = this.startCol = col;
    this.row = this.startRow = row;
    this.leftKey = lk;
    this.rightKey = rk;
    this.upKey = uk;
    this.downKey = dk;
    this.side = side;
    lastPos = new PVector(col, row);
  }

  Player(int col, int row, int lk, int rk, int uk, int dk, int side) {
    this.col = this.startCol = col;
    this.row = this.startRow = row;
    this.leftCode = lk;
    this.rightCode = rk;
    this.upCode = uk;
    this.downCode = dk;
    this.side = side;
    lastPos = new PVector(col, row);
  }

  void update() {
    // マスの境界チェック
    if (col < 0) col = 0;
    if (col >= colsPerPlayer) col = colsPerPlayer - 1;
    if (row < 0) row = 0;
    if (row > 19) row = 19;

    // 静止チェック
    if (lastPos.x == col && lastPos.y == row) {
      staticFrame++;
      if (staticFrame > 120) {
        row += 1;
        staticFrame = 0;
      }
    } else {
      staticFrame = 0;
      lastPos.set(col, row);
    }
  }

  void handleInput(char k, int kc) {
    if (k == leftKey || kc == leftCode) col -= 1;
    if (k == rightKey || kc == rightCode) col += 1;
    if (k == upKey || kc == upCode) row -= 1;
    if (k == downKey || kc == downCode) row += 1;
  }

  void display() {
    // 実座標を算出
    int xOffset = (side == 0) ? 0 : width / 2;
    float x = xOffset + col * cellW + cellW / 2;
    float y = row * cellH + cellH / 2;

    fill(side == 0 ? color(100, 150, 255) : color(255, 120, 120));
    ellipse(x, y, cellW * 0.6, cellH * 0.8);
  }

  void reset() {
    col = startCol;
    row = startRow;
  }
}

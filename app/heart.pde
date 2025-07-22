
class Heart {
  int col, row;
  int side;
  boolean collected = false;

  Heart(int col, int row, int side) {
    this.col = col;
    this.row = row;
    this.side = side;
  }

  void display() {
    if (!collected) {
      int xOffset = (side == 0) ? 0 : width / 2;
      float x = xOffset + col * cellW + cellW * 0.1;
      float y = row * cellH + cellH * 0.1;
      image(heartMaxImg, x, y, cellW * 0.8, cellH * 0.8);
    }
  }

  boolean isHit(Player p) {
    if (collected) return false;
    return p.col == col && p.row == row && p.side == side;
  }
}

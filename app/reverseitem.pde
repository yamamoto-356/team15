class ReverseItem {
  int col, row, side;
  boolean collected = false;

  ReverseItem(int col, int row, int side) {
    this.col = col;
    this.row = row;
    this.side = side;
  }

  void display() {
    if (!collected) {
      int xOffset = (side == 0) ? 0 : width / 2;
      float x = xOffset + col * cellW + cellW * 0.2;
      float y = row * cellH + cellH * 0.2;
      fill(180, 0, 200);  // 紫色
      ellipse(x + 10, y + 10, 24, 24);
    }
  }

  boolean isHit(Player p) {
    return !collected && p.col == col && p.row == row && p.side == side;
  }
}

int colsPerPlayer = 5;
int cellW = 80; // = 400 / 5
int cellH = 30;

GameManager game;

void setup() {
  size(800, 600);
  game = new GameManager();
}

void draw() {
  background(255);
  drawGrid();
  game.update();
  game.display();
}

void keyPressed() {
  game.keyPressed(key, keyCode);
}

// グリッド描画
void drawGrid() {
  stroke(200);
  // プレイヤー1（左）
  for (int i = 1; i < colsPerPlayer; i++) {
    line(i * cellW, 0, i * cellW, height);
  }
  // プレイヤー2（右）
  for (int i = 1; i < colsPerPlayer; i++) {
    int x = 400 + i * cellW;
    line(x, 0, x, height);
  }
  // 横線共通
  for (int j = 1; j < height / cellH; j++) {
    line(0, j * cellH, width, j * cellH);
  }

  // 中央線
  stroke(0);
  line(width / 2, 0, width / 2, height);
}

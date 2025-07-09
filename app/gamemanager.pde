class GameManager {
  Player player1;
  Player player2;

  GameManager() {
    int row = 19;  // 最下段（固定）

    // 左画面（プレイヤー1）の0〜4列
    int p1col = (int)random(0, colsPerPlayer);

    // 右画面（プレイヤー2）の0〜4列（同じ値でもOK）
    int p2col = (int)random(0, colsPerPlayer);

    player1 = new Player(p1col, row, 'a', 'd', 'w', 's', 0);      // side 0 = 左半分
    player2 = new Player(p2col, row, LEFT, RIGHT, UP, DOWN, 1);   // side 1 = 右半分
  }

  void update() {
    player1.update();
    player2.update();
  }

  void display() {
    player1.display();
    player2.display();
  }

  void keyPressed(char k, int kc) {
    player1.handleInput(k, kc);
    player2.handleInput(k, kc);
  }
}

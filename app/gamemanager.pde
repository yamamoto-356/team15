class GameManager {
  Player player1;
  Player player2;
  ArrayList<Block> blocks;

  int crownColLeft;
  int crownColRight;
  boolean crownTaken = false;
  int winner = -1;  // 0=player1,1=player2,-1=なし

  GameManager() {
    int row = 19;
    int p1col = (int)random(0, colsPerPlayer);
    int p2col = (int)random(0, colsPerPlayer);

    player1 = new Player(p1col, row, 'a', 'd', 'w', 's', 0);
    player2 = new Player(p2col, row, LEFT, RIGHT, UP, DOWN, 1);

    blocks = new ArrayList<Block>();

    for (int rowIndex = 0; rowIndex < 19; rowIndex++) {
      int colLeft = (int)random(0, colsPerPlayer);
      int colRight = (int)random(0, colsPerPlayer);

      Block bLeft = new Block(colLeft, rowIndex, 0);
      Block bRight = new Block(colRight, rowIndex, 1);

      if (random(1) < 0.2) {
        bLeft.setMoving(true);
      }
      if (random(1) < 0.2) {
        bRight.setMoving(true);
      }

      blocks.add(bLeft);
      blocks.add(bRight);
    }

    crownColLeft = (int)random(0, colsPerPlayer);
    crownColRight = (int)random(0, colsPerPlayer);
  }

  void update() {
    if (crownTaken) return;

    player1.update();
    player2.update();

    for (Block b : blocks) {
      b.update();

      if (b.isHit(player1)) {
        println("Player1 hit a block!");
        player1.reset();
      }
      if (b.isHit(player2)) {
        println("Player2 hit a block!");
        player2.reset();
      }
    }

    checkCrown();
  }

  void checkCrown() {
    if (player1.side == 0 && player1.row == 0 && player1.col == crownColLeft) {
      crownTaken = true;
      winner = 0;
    }
    if (player2.side == 1 && player2.row == 0 && player2.col == crownColRight) {
      crownTaken = true;
      winner = 1;
    }
  }

  void display() {
    for (Block b : blocks) {
      b.display();
    }

    // 王冠をテキストで表示（画像なし版）
    drawCrownText();

    player1.display();
    player2.display();

    if (crownTaken) {
      fill(0);
      textSize(48);
      textAlign(CENTER, CENTER);
      String msg = (winner == 0) ? "Player 1 Wins!" : "Player 2 Wins!";
      text(msg, width / 2, height / 2);
    }
  }

  void drawCrownText() {
    int yTop = cellH / 2;
    int xLeft = crownColLeft * cellW + cellW / 2;
    int xRight = width / 2 + crownColRight * cellW + cellW / 2;

    textSize(32);
    textAlign(CENTER, CENTER);
    fill(255, 215, 0);  // ゴールドカラー
    text("👑", xLeft, yTop);
    text("👑", xRight, yTop);
  }

  void keyPressed(char k, int kc) {
    if (!crownTaken) {
      player1.handleInput(k, kc);
      player2.handleInput(k, kc);
    }
  }
}

class GameManager {
  Player player1;
  Player player2;
  ArrayList<Block> blocks;

  int crownColLeft;
  int crownColRight;
  boolean crownTaken = false;
  int winner = -1;

  GameManager() {
    setupGame();
  }

void setupGame() {
  int row = 19;
  int p1col = (int)random(0, colsPerPlayer);
  int p2col = (int)random(0, colsPerPlayer);

  player1 = new Player(p1col, row, 'a', 'd', 'w', 's', 0, player1RightImg, player1LeftImg);
  player2 = new Player(p2col, row, LEFT, RIGHT, UP, DOWN, 1, player2RightImg, player2LeftImg);

  crownColLeft = (int)random(0, colsPerPlayer);
  crownColRight = (int)random(0, colsPerPlayer);

  blocks = new ArrayList<Block>();
  for (int rowIndex = 0; rowIndex < 19; rowIndex++) {
    int colLeft = (int)random(0, colsPerPlayer);
    int colRight = (int)random(0, colsPerPlayer);

    // 王冠の位置とかぶる場合はスキップ
    if (rowIndex == 0 && colLeft == crownColLeft) continue;
    if (rowIndex == 0 && colRight == crownColRight) continue;

    Block bLeft = new Block(colLeft, rowIndex, 0);
    Block bRight = new Block(colRight, rowIndex, 1);

    if (random(1) < 0.3) bLeft.setMoving(true);
    if (random(1) < 0.3) bRight.setMoving(true);

    blocks.add(bLeft);
    blocks.add(bRight);
  }

  crownTaken = false;
  winner = -1;
}


  void update() {
    if (crownTaken) return;

    player1.update();
    player2.update();

    for (Block b : blocks) {
      b.update();

      if (b.isHit(player1)) {
        int xOffset = (b.side == 0) ? 0 : width / 2;
        float ex = xOffset + b.col * cellW;
        float ey = b.row * cellH;
        explosions.add(new Explosion(ex, ey));
        player1.reset();
      }

      if (b.isHit(player2)) {
        int xOffset = (b.side == 0) ? 0 : width / 2;
        float ex = xOffset + b.col * cellW;
        float ey = b.row * cellH;
        explosions.add(new Explosion(ex, ey));
        player2.reset();
      }
      
      if (player1.isDead()) {
        crownTaken = true;  // ゲーム終了状態として扱う
        winner = 1;         // プレイヤー2の勝ち
      }

      if (player2.isDead()) {
        crownTaken = true;
        winner = 0;         // プレイヤー1の勝ち
      }

    }

    checkCrown();

    for (int i = explosions.size() - 1; i >= 0; i--) {
      explosions.get(i).update();
      if (explosions.get(i).isFinished()) {
        explosions.remove(i);
      }
    }
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
    for (Block b : blocks) b.display();
    drawCrownImage();
    player1.display();
    player2.display();

    for (Explosion e : explosions) {
      e.display();
    }

    if (crownTaken) {
      fill(255);
      textSize(48);
      textAlign(CENTER, CENTER);
      String msg = (winner == 0) ? "Player 1 Wins!!" : "Player 2 Wins!!";
      text(msg, width / 2, height / 2);
      textSize(24);
      text("Press R to Restart", width / 2, height / 2 + 50);
    }
  }

  void drawCrownImage() {
    float crownW = cellW * 0.8;
    float crownH = cellH * 0.8;
    float xLeft = crownColLeft * cellW + (cellW - crownW) / 2;
    float xRight = width / 2 + crownColRight * cellW + (cellW - crownW) / 2;
    float yTop = (cellH - crownH) / 2;
    image(crownImg, xLeft, yTop, crownW, crownH);
    image(crownImg, xRight, yTop, crownW, crownH);
  }

  void keyPressed(char k, int kc) {
    if (!crownTaken) {
      player1.handleInput(k, kc);
      player2.handleInput(k, kc);
    } else if (k == 'r' || k == 'R') {
      // ゲームをリセット
      explosions.clear();
      setupGame();
    }
  }
}

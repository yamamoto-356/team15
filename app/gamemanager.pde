class GameManager {
  Player player1;
  Player player2;
  ArrayList<Block> blocks;
  ArrayList<Heart> hearts;

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
  for (int rowIndex = 1; rowIndex < 19; rowIndex++) {
    // 王冠の行（0行目）には障害物を出さない
    if (rowIndex == 0) continue;

    int colLeft = (int)random(0, colsPerPlayer);
    int colRight = (int)random(0, colsPerPlayer);

    Block bLeft = new Block(colLeft, rowIndex, 0);
    Block bRight = new Block(colRight, rowIndex, 1);

    if (random(1) < 0.3) bLeft.setMoving(true);
    if (random(1) < 0.3) bRight.setMoving(true);
    
    if (random(1) < 0.25 && bLeft.isMoving) bLeft.isReverseBlock = true;
    if (random(1) < 0.25 && bRight.isMoving) bRight.isReverseBlock = true;

    blocks.add(bLeft);
    blocks.add(bRight);
  }

  crownTaken = false;
  winner = -1;

  hearts = new ArrayList<Heart>();

  int heartCount = 4; // 両サイドで2個ずつ配置

  for (int i = 0; i < heartCount; i++) {
    int side = i < 2 ? 0 : 1;
    int col, heartRow;

    // 衝突を避けるために位置決めを繰り返す
    while (true) {
      col = (int)random(0, colsPerPlayer);
      heartRow = (int)random(1, 18); // 0行目と19行目は除く

      // blocksに重なっていないか判定
      boolean conflict = false;
      for (Block b : blocks) {
        if (b.side == side && b.col == col && b.row == heartRow) {
          conflict = true;
          break;
        }
      }
      if (!conflict) break; // 衝突なしならループを抜ける
    }

    hearts.add(new Heart(col, heartRow, side));
  }
}


void update() {
  if (crownTaken) return;

  player1.update();
  player2.update();

  for (Block b : blocks) {
    b.update();

if (b.isHit(player1)) {
  if (b.isReverseBlock) {
    // エイリアンに当たったときの処理
    player1.isReversed = true;
    player1.reverseEndTime = millis() + 6000;
    alienSound.play();
  } else {
    // 通常のブロックに当たったときの処理
    int xOffset = (b.side == 0) ? 0 : width / 2;
    float ex = xOffset + b.col * cellW;
    float ey = b.row * cellH;
    explosions.add(new Explosion(ex, ey));

    if (b.isMoving) {
      hitSound.play();
    } else {
      treeSound.play();
    }

    player1.reset();
  }
}


if (b.isHit(player2)) {
  if (b.isReverseBlock) {
    player2.isReversed = true;
    player2.reverseEndTime = millis() + 6000;
    alienSound.play();
  } else {
    int xOffset = (b.side == 0) ? 0 : width / 2;
    float ex = xOffset + b.col * cellW;
    float ey = b.row * cellH;
    explosions.add(new Explosion(ex, ey));

    if (b.isMoving) {
      hitSound.play();
    } else {
      treeSound.play();
    }

    player2.reset();
  }
}


    if (player1.isDead()) {
      crownTaken = true;
      winner = 1;
    }
    if (player2.isDead()) {
      crownTaken = true;
      winner = 0;
    }
  }

  checkCrown();

  for (int i = explosions.size() - 1; i >= 0; i--) {
    explosions.get(i).update();
    if (explosions.get(i).isFinished()) {
      explosions.remove(i);
    }
  }

  for (Heart h : hearts) {
    if (h.isHit(player1)) {
      if (player1.life < 2.0) {
        player1.life = min(player1.life + 1.0, 2.0);
        healSound.play();
      }
      h.collected = true;
    }
    if (h.isHit(player2)) {
      if (player2.life < 2.0) {
        player2.life = min(player2.life + 1.0, 2.0);
        healSound.play();
      }
      h.collected = true;
    }
  }
}


  void checkCrown() {
    if (player1.side == 0 && player1.row == 0 && player1.col == crownColLeft) {
      crownTaken = true;
      winner = 0;
      goalSound.play();
    }
    if (player2.side == 1 && player2.row == 0 && player2.col == crownColRight) {
      crownTaken = true;
      winner = 1;
      goalSound.play();
    }
  }

  void display() {
    
    for (Heart h : hearts) h.display();

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

int colsPerPlayer = 5;
int cellW = 80;
int cellH = 30;

PImage crownImg;
PImage player1RightImg, player1LeftImg;
PImage player2RightImg, player2LeftImg;
PImage dragonImg;
PImage bakuhatsuImg;

GameManager game;
String gameState = "start";

int countdownTime = 3;
int countdownStartMillis;

ArrayList<Explosion> explosions = new ArrayList<Explosion>();

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);

  crownImg = loadImage("crown.png");
  player1RightImg = loadImage("player1-right.png");
  player1LeftImg = loadImage("player1-left.png");
  player2RightImg = loadImage("player2-right.png");
  player2LeftImg = loadImage("player2-left.png");
  dragonImg = loadImage("dragon.png");
  bakuhatsuImg = loadImage("bakuhatsu.png");

  game = new GameManager();
}

void draw() {
  background(255);

  if (gameState.equals("start")) {
    drawStartScreen();
  } else if (gameState.equals("countdown")) {
    drawCountdown();
  } else if (gameState.equals("play")) {
    drawGrid();
    game.update();
    game.display();
  }
}

void keyPressed() {
  if (gameState.equals("start")) {
    if (key == ' ' || key == ENTER) {
      gameState = "countdown";
      countdownStartMillis = millis();
      countdownTime = 3;
    }
  } else if (gameState.equals("play")) {
    game.keyPressed(key, keyCode);
  }
}

void drawGrid() {
  stroke(200);
  for (int i = 1; i < colsPerPlayer; i++) {
    line(i * cellW, 0, i * cellW, height);
  }
  for (int i = 1; i < colsPerPlayer; i++) {
    int x = 400 + i * cellW;
    line(x, 0, x, height);
  }
  for (int j = 1; j < height / cellH; j++) {
    line(0, j * cellH, width, j * cellH);
  }
  stroke(0);
  line(width / 2, 0, width / 2, height);
}

void drawStartScreen() {
  background(220);
  fill(0);
  textSize(32);
  text("Press SPACE or ENTER to Start", width / 2, height / 2);
}

void drawCountdown() {
  int elapsed = (millis() - countdownStartMillis) / 1000;
  int displayNum = countdownTime - elapsed;

  background(255);
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(72);

  if (displayNum > 0) {
    text(displayNum, width / 2, height / 2);
  } else if (elapsed <= countdownTime + 1) {
    text("Go!", width / 2, height / 2);
  }

  if (elapsed > countdownTime + 1) {
    gameState = "play";
  }
}

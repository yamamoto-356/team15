int colsPerPlayer = 5;
int cellW = 80;
int cellH = 30;

PImage crownImg;
PImage heroRedImg;
PImage heroBlueImg;
PImage dragonImg;
PImage bakuhatsuImg;

GameManager game;
String gameState = "start";

int countdownTime = 3;
int countdownStartMillis;

void setup() {
  size(800, 600);
  textAlign(CENTER, CENTER);

  crownImg = loadImage("crown.png");
  heroRedImg = loadImage("herored.png");
  heroBlueImg = loadImage("heroblue.png");
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

ArrayList<Explosion> explosions = new ArrayList<Explosion>();

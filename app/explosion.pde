class Explosion {
  float x, y;
  int timer;

  Explosion(float x, float y) {
    this.x = x;
    this.y = y;
    this.timer = 30;
  }

  void update() {
    timer--;
  }

  void display() {
    if (timer > 0 && bakuhatsuImg != null) {
      image(bakuhatsuImg, x, y, cellW, cellH);
    }
  }

  boolean isFinished() {
    return timer <= 0;
  }
}

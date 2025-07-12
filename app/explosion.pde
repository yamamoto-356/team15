class Explosion {
  float x, y;
  int timer;  // 表示時間フレーム数

  Explosion(float x, float y) {
    this.x = x;
    this.y = y;
    this.timer = 30;  // 30フレーム＝約0.5秒（60fpsの場合）
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

int N = 900;
int DType = 4;

// Type 3 用
int parentNum = 100;
float[] parentX = new float[parentNum];
float[] parentY = new float[parentNum];

void setup() {
  size(500, 500);
  background(255);

  scale(5);

  stroke(0);
  noFill();
  rect(0, 0, 100, 100);

  stroke(255, 0, 0);

  // Type 3 のとき、先にコロニー中心100点を作る
  if (DType == 3) {
    for (int i = 0; i < parentNum; i++) {
      parentX[i] = random(100);
      parentY[i] = random(100);
    }
  }

  for (int i = 0; i < N; i++) {

    float x = 0;
    float y = 0;

    if (DType == 1) {
      float muX = 50;
      float muY = 50;
      float sigma = 15;

      x = muX + sigma * (float)randomGaussian();
      y = muY + sigma * (float)randomGaussian();
    }

    if (DType == 2) {
      x = random(100);
      y = random(100);
    }

    if (DType == 3) {
      float sigma = 3;  // コロニー周辺への散らばり具合

      if (i < parentNum) {
        // 最初の100点はコロニー中心
        x = parentX[i];
        y = parentY[i];
      } else {
        // 残り800点は、100個の中心のどれかの周辺
        int p = int(random(parentNum));

        x = parentX[p] + sigma * (float)randomGaussian();
        y = parentY[p] + sigma * (float)randomGaussian();
      }
    }
    if (DType == 4) {
      int col = i % 30;
      int row = i / 30;

      float interval = 100.0 / 29.0;

      x = col * interval;
      y = row * interval;
    }
    if (0 <= x && x <= 100 && 0 <= y && y <= 100) {
      point(x, y);
    }
  }

  noLoop();
}
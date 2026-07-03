//圃場内の株の配置パターンのみを生成する実験プログラム（お試しで株配置の違いをみてみよう）

int N = 900;//30x30=900の株を100x100の圃場内に配する

//次のDtypeの行のうち，どれか一つのみ//を消すとそのパターンの配置がされる
//int DType = 1; // 中心（５０，５０）から二次元正規分布に従って配置されるとき（相当妄想の配置）
//int DType = 2; // 完全に一様にランダムに圃場内に株が配置されるとき（直播の考えられるパターン１）
int DType = 3; // 最初の100株はランダムに圃場内に配置，残り800株はこの100株の周りにある程度固まるように配置（直播の考えられるパターン１）
//int DType = 4; // 従来の整列 ３０ｘ３０で行儀よく並んだ株

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

  // DType 3 のとき、先にコロニー中心100点を作る
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
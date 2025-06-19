int numbubbles = 20;

float[] xpositions;
float[] ypositions;
float[] xspeeds;
float[] yspeeds;
int[] xdirections;
int[] ydirections;

void setup() {
  size(1000, 1000);
  noStroke();

  // arrays
  xpositions = new float[numbubbles];
  ypositions = new float[numbubbles];
  xspeeds = new float[numbubbles];
  yspeeds = new float[numbubbles];
  xdirections = new int[numbubbles];
  ydirections = new int[numbubbles];

  for (int i = 0; i < numbubbles; i++) {
    xpositions[i] = random(width);
    ypositions[i] = random(height);
    xspeeds[i] = random(1, 5);
    yspeeds[i] = random(1, 5);
    xdirections[i] = (random(1) > 0.5) ? 1 : -1;
    ydirections[i] = (random(1) > 0.5) ? 1 : -1;
  }
}

void draw() {
  background(0, 0, 255); // azul neón

  fill(255, 255, 0); // amarillo neón

  for (int i = 0; i < numbubbles; i++) {
    ellipse(xpositions[i], ypositions[i], 50, 50);

    // Movimiento
    xpositions[i] += xspeeds[i] * xdirections[i];
    ypositions[i] += yspeeds[i] * ydirections[i];

    // Rebote horizontal
    if (xpositions[i] > width || xpositions[i] < 0) {
      xdirections[i] *= -1;
    }

    // Rebote vertical
    if (ypositions[i] > height || ypositions[i] < 0) {
      ydirections[i] *= -1;
    }
  }
}

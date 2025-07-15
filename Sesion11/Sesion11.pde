Table table;
float[] appUsageTime;
float[] screenOnTime;

int nSamples;

void setup() {
  size(1000, 1000);
  background(230);  // Fondo gris claro
  noStroke();

  table = loadTable("user_behavior_dataset.csv", "header");
  nSamples = table.getRowCount();

  appUsageTime = new float[nSamples];
  screenOnTime = new float[nSamples];

  for (int i = 0; i < nSamples; i++) {
    appUsageTime[i] = table.getFloat(i, "App Usage Time (min/day)");
    screenOnTime[i] = table.getFloat(i, "Screen On Time (hours/day)");
  }

  noLoop();  
}

void draw() {
  background(230);

  float maxApp = max(appUsageTime);
  float maxScreen = max(screenOnTime);

  for (int i = 0; i < nSamples; i++) {
    float x = map(appUsageTime[i], 0, maxApp, 100, width - 100);
    float y = map(screenOnTime[i], 0, maxScreen, height - 100, 100);


    float r = random(180, 255);
    float g = random(30, 80);
    float b = random(120, 200);
    fill(r, g, b, 180);  // transparencia ligera

    float offsetY = random(-5, 5);
    rect(x, y + offsetY, 5, 20);  // rectángulo vertical
  }
}

int incrementos = 50;

void setup() {
  size(500,500);
  background(255);
  noloop();
}
void draw() {
  for(int y = 0; y < height; y += incrementos) {
    for(int x = 0; x < width; x+= incrementos) }
    fill(random(100,255), random(200,255), random(10,50));
    rect(x,y,incrementos,incrementos);
}
}
}

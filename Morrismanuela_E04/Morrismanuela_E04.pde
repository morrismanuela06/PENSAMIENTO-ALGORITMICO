
int h;
int m;
int s;

String timeString;

void setup() {
  size(1000, 1000);
  textAlign(CENTER, TOP);
  textSize(48);
  rectMode(CENTER); // barras  centradas horizontalmente
}

void draw() {
  background(0);

  // hora actual
  h = hour();
  m = minute();
  s = second();

  // Mostrar hora como texto centrado arriba
  timeString = nf(h, 2) + ":" + nf(m, 2) + ":" + nf(s, 2);
  fill(255);
  text(timeString, width / 2, 60);

  // Centro vertical para distribuir las 3 barras
  float espacioEntreBarras = 100;
  float centroY = height / 2 - espacioEntreBarras;

  // Barra de segundos
  fill(255, 100, 150); 
  rect(width / 2, centroY, map(s, 0, 60, 0, 800), 40);

  // Barra de minutos
  fill(100, 200, 255); 
  rect(width / 2, centroY + espacioEntreBarras, map(m, 0, 60, 0, 800), 40);

  // Barra de horas
  fill(200, 255, 100);
  rect(width / 2, centroY + espacioEntreBarras * 2, map(h % 24, 0, 24, 0, 800), 40);
}

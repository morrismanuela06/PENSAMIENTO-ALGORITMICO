// Manuela Morris

int incremento = 80; // Tamaño entre cada figura

void setup() {
  size(500, 500);
  background(255); // fondo blanco
  noLoop(); // Para que se dibuje una sola vez
}

void draw() {
  for (int y = 0; y < height; y += incremento) {
    for (int x = 0; x < width; x += incremento) {

      // Cuerpo de la figura (rectángulo)
      fill(random(100, 255), random(100, 200), random(150, 255));
      rect(x + 20, y + 20, 40, 40);

      // Orejas (círculos)
      fill(0); // negras
      ellipse(x + 20, y + 20, 10, 10); // círculo superior izquierdo
      ellipse(x + 60, y + 60, 10, 10); // círculo inferior derecho
    }
  }
}

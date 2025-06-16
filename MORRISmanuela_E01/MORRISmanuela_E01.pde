// Nombre: Manuela Morris
// Título: Ejercicio Color y Forma
// Composición sencilla con formas geométricas y color inspirado en la bauhaus

void setup() {
  size(400, 600); // Canvas vertical
  background(250, 243, 221); // Color de fondo (RGB beige claro)

  noStroke(); // Sin bordes

  // Semicírculo rojo (simulado con elipse + rectángulo)
  fill(210, 70, 50); // Rojo
  ellipse(200, 550, 200, 100); // Elipse base
  fill(250, 243, 221); // Color fondo
  rect(0, 550, 400, 100); // Cortar la parte de abajo

  // Círculo azul
  fill(100, 130, 255);
  ellipse(240, 470, 80, 80);

  // Círculo amarillo
  fill(255, 210, 100);
  ellipse(160, 470, 80, 80);

  // Semicírculo verde (más arriba)
  fill(120, 190, 130);
  ellipse(200, 390, 120, 60);
  fill(250, 243, 221);
  rect(0, 390, 400, 100);

  // Triángulo en la parte superior
  fill(255, 150, 0);
  triangle(180, 300, 220, 300, 200, 270);

  // Cuadrado decorativo en el centro
  fill(100, 180, 255);
  quad(180, 360, 220, 360, 230, 380, 170, 380);

  // Punto decorativo
  stroke(0);
  point(200, 100);
}

// Nombre: TU NOMBRE AQUÍ
// Título: Visualización interactiva de precios de Tesla
// Descripción: Visualización en Processing del precio de cierre de las acciones de Tesla a lo largo del tiempo.
// Interacción: Al mover el mouse, se muestra la fecha y el valor correspondiente.
// Dataset: Tesla_stock_data.csv

Table tabla;
float[] precios;
String[] fechas;

void setup() {
  size(1200, 600);
  tabla = loadTable("Tesla_stock_data.csv", "header");

  int total = tabla.getRowCount();
  precios = new float[total];
  fechas = new String[total];

  // Cargar datos desde el archivo CSV
  for (int i = 0; i < total; i++) {
    precios[i] = tabla.getFloat(i, "Close");
    fechas[i] = tabla.getString(i, "Date");
  }
}

void draw() {
  background(255); // Fondo blanco

  float maxPrecio = max(precios);
  float minPrecio = min(precios);

  // Título e instrucción
  fill(0);
  textSize(16);
  textAlign(LEFT);
  text("Precio de cierre de Tesla ($)", 40, 40);
  textSize(12);
  text("Mueve el mouse para ver el precio", 40, 60);

  // Dibujar la línea roja del gráfico
  stroke(220, 30, 30); // Rojo intenso
  strokeWeight(2);
  noFill();
  beginShape();
  for (int i = 0; i < precios.length; i++) {
    float x = map(i, 0, precios.length - 1, 60, width - 40);
    float y = map(precios[i], minPrecio, maxPrecio, height - 60, 100);
    vertex(x, y);
  }
  endShape();

  // Interacción con el mouse
  int index = int(map(mouseX, 60, width - 40, 0, precios.length - 1));
  index = constrain(index, 0, precios.length - 1);

  float x = map(index, 0, precios.length - 1, 60, width - 40);
  float y = map(precios[index], minPrecio, maxPrecio, height - 60, 100);

  // Punto resaltado
  fill(220, 30, 30);
  noStroke();
  ellipse(x, y, 10, 10);

  // Etiquetas
  fill(0);
  textSize(14);
  textAlign(LEFT);
  text("Fecha: " + fechas[index], x + 10, y - 20);
  text("Precio: $" + nf(precios[index], 1, 2), x + 10, y - 5);
}

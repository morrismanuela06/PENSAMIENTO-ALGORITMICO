// Título: Transición de Día a Noche con animación y formas personalizadas
// Programa interactivo que cambia entre día y noche con animación, rayos de sol y media luna

float transicion = 0;      // 0 = día, 1 = noche (para animar el fondo)
boolean esNoche = false;   // variable de estado: true si es noche

Sol sol;
Luna luna;

void setup() {
  size(600, 400);
  sol = new Sol(width/2, height/2);
  luna = new Luna(width/2, height/2);
}

void draw() {
  // Transición animada del fondo 
  if (esNoche && transicion < 1) {
    transicion += 0.01;
  } else if (!esNoche && transicion > 0) {
    transicion -= 0.01;
  }

  // cambio de color
  color diaColor = color(135, 206, 235);
  color nocheColor = color(10, 10, 50);
  background(lerpColor(diaColor, nocheColor, transicion)); //lerpColor se usa para animar el cambio de color de fondo

  // Mostrar sol o luna dependiendo del estado de transición
  if (transicion < 0.5) {
    sol.mostrar();
  } else {
    luna.mostrar();
  }

  // Instrucciones centradas en la parte inferior
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Presiona una tecla o haz clic para cambiar el cielo", width / 2, height - 30);
}

// Evento de teclado: cambia entre día y noche
void keyPressed() {
  esNoche = !esNoche;
}

// Evento de mouse: cambia entre día y noche
void mousePressed() {
  esNoche = !esNoche;
}

// CLASE SOL: representa el sol con rayos triangulares
class Sol {
  float x, y;

  Sol(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void mostrar() {
    pushMatrix(); // Guardamos el sistema de coordenadas actual

    // Movemos el punto (0, 0) al centro donde queremos dibujar el sol
    translate(x, y);

    // Dibujamos los rayos del sol como triángulos alrededor del centro
    int numRayos = 12;
    float radioSol = 50;
    for (int i = 0; i < numRayos; i++) {
      float ang = TWO_PI / numRayos * i;
      float r = radioSol + 15;
      float x1 = cos(ang) * r;
      float y1 = sin(ang) * r;
      float x2 = cos(ang + 0.1) * (r + 10);
      float y2 = sin(ang + 0.1) * (r + 10);
      float x3 = cos(ang - 0.1) * (r + 10);
      float y3 = sin(ang - 0.1) * (r + 10);

      fill(255, 204, 0);
      noStroke();
      triangle(x1, y1, x2, y2, x3, y3);
    }

    // Círculo central del sol
    fill(255, 204, 0);
    ellipse(0, 0, radioSol * 2, radioSol * 2);

    popMatrix(); // Restauramos el sistema de coordenadas original
  }
}

// CLASE LUNA: representa una media luna
class Luna {
  float x, y;

  Luna(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void mostrar() {
    pushMatrix(); // Guardamos el sistema de coordenadas actual

    // Movemos el origen (0, 0) al centro de la luna
    translate(x, y);

    // Dibujamos una media luna usando arc() (media circunferencia)
    noStroke();
    fill(240, 240, 255);
    arc(0, 0, 80, 80, -HALF_PI, HALF_PI, PIE);

    popMatrix(); // Restauramos coordenadas para no afectar otros dibujos
  }
}

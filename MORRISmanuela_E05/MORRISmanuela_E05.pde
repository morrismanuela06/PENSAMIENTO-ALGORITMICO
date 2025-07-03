import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Manuela Morris
// Ondas que bailan

import ddf.minim.*;

Minim minim;
AudioPlayer cancion;

void setup() {
  size(800, 600);
  minim = new Minim(this);
  
  // Carga la canción desde la carpeta "data"
  cancion = minim.loadFile("mi_cancion.mp3", 1024);
  cancion.play();  // Puedes usar cancion.loop() si quieres que se repita
  background(0);
}

void draw() {
  background(0);
  
  stroke(255);
  noFill();
  
  float centroY = height / 2;
  beginShape();
  for (int i = 0; i < cancion.bufferSize() - 1; i++) {
    float x = map(i, 0, cancion.bufferSize(), 0, width);
    float y = centroY + cancion.left.get(i) * 200;
    vertex(x, y);
  }
  endShape();
  
  // Visual de fondo que cambia con la amplitud general
  float amplitud = cancion.mix.level();
  fill(255, 50);
  ellipse(width/2, height/2, amplitud * 1000, amplitud * 1000);
}

void stop() {
  cancion.close();
  minim.stop();
  super.stop();
}

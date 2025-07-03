// Manuela Morris
// Ondas que bailan

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


import ddf.minim.*;

Minim minim;
AudioPlayer cancion;

void setup() {
  size(800, 600);
  minim = new Minim(this);

  // Carpeta de cancion
  cancion = minim.loadFile("mi_cancion.mp3", 1024);
  cancion.loop();  // codigo para hacer que se repita la cancion
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

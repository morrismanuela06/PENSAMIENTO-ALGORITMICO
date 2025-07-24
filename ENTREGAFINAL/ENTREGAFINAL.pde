// Clase 1: Emociones
class Emoción {
  String nombre, forma;
  color col;
  Emoción(String nombre, String forma, color col) {
    this.nombre = nombre;
    this.forma  = forma;
    this.col    = col;
  }
}

// Clase 2: Partículas
class Particle {
  PVector pos, vel;
  float lifespan;
  color col;
  Particle(float x, float y, color c) {
    pos = new PVector(x, y);
    vel = PVector.random2D().mult(random(1,3));
    lifespan = 255;
    col = c;
  }
  boolean update() {
    pos.add(vel);
    lifespan -= 4;
    return lifespan > 0;
  }
  void display() {
    noStroke();
    fill(red(col), green(col), blue(col), lifespan);
    ellipse(pos.x, pos.y, 6, 6);
  }
}

class ParticleSystem {
  ArrayList<Particle> list = new ArrayList<Particle>();
  void add(float x, float y, color c, int n) {
    for (int i = 0; i < n; i++) list.add(new Particle(x, y, c));
  }
  void updateAndDisplay() {
    for (int i = list.size()-1; i >= 0; i--) {
      Particle p = list.get(i);
      if (!p.update()) list.remove(i);
      else p.display();
    }
  }
}

// Clase 3: Pregunta
class Pregunta {
  String texto;
  String[] opciones = { "A","B","C","D","E","F" };
  String[] descripciones;
  Pregunta(String texto, String[] descripciones) {
    this.texto = texto;
    this.descripciones = descripciones;
  }
  void mostrar(int numero) {
    textFont(fuenteCuerpo);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Pregunta " + numero, width/2, 60);
    textSize(18);
    textLeading(24);
    text(texto, width/2, 110);

    float shapeX   = width/2 - 200;
    float startY   = height/2 - opciones.length * 30;
    float lineaAlt = 60;
    textSize(14);
    textAlign(LEFT, CENTER);

    for (int i = 0; i < opciones.length; i++) {
      float y = startY + i * lineaAlt;
      Emoción e = emociones.get(opciones[i]);
      noStroke();
      fill(e.col);
      ellipse(shapeX, y, 40, 40);
      fill(0);
      text(opciones[i] + ") " + descripciones[i], shapeX + 50, y);
    }
  }
}

// Variables globales
HashMap<String, Emoción> emociones   = new HashMap<String, Emoción>();
ArrayList<String>        respuestas   = new ArrayList<String>();
ArrayList<Pregunta>      listaPreguntas = new ArrayList<Pregunta>();

//preguntas 
String[] preguntasTxt = {
  "¿Qué fue lo primero que sentiste al despertar esta mañana?",
  "¿Cómo te sentiste la última vez que revisaste tu celular hoy?",
  "¿Cómo te has sentido en tus interacciones con otras personas hoy?",
  "¿Cómo está tu cuerpo en este momento?",
  "¿Qué emoción se asomó con más fuerza mientras almorzabas o comías hoy?",
  "¿Cómo describirías tu estado emocional ahora mismo?"
};

//Respuestas
String[][] respuestasTxt = {
  {
    "Ganas de comenzar, como si algo bueno pudiera pasar.",
    "Una pesadez que me hacía querer quedarme en la cama.",
    "Una confusión breve, como si no recordara dónde estaba.",
    "Fastidio inmediato, incluso antes de abrir los ojos.",
    "Un nudo en el estómago, sin saber bien por qué.",
    "Un rechazo al día, como si no quisiera entrar en contacto con él."
  },{
    "Vi algo que me hizo sonreír sin pensarlo.",
    "Me entristeció ver algo que no esperaba.",
    "Un mensaje me sorprendió, me sacó del ritmo.",
    "Me molestó ver algo que no quería leer.",
    "Me dio ansiedad abrir ciertas conversaciones.",
    "Sentí una incomodidad difícil de explicar."
  },{
    "Cómodo/a, conectado/a, como si fluyera con naturalidad.",
    "Distante, como si algo faltara entre nosotros.",
    "Sorprendido/a por algo que alguien dijo o hizo.",
    "Impaciente o irritado/a, aunque no lo haya mostrado.",
    "Inseguro/a, con miedo de ser malinterpretado/a.",
    "Incómodo/a, como si hubiera algo fuera de lugar."
  },{
    "Ligero, con energía suave que me acompaña.",
    "Cansado, como si cargara algo invisible.",
    "Tenso, pero sin razón clara.",
    "Rígido, apretado, como si estuviera resistiendo algo.",
    "Con sobresaltos o latidos rápidos sin control.",
    "Sensible, con cierta repulsión o desagrado físico."
  },{
    "Disfrute: saboreé sin prisa.",
    "Tristeza: comí por rutina, sin apetito real.",
    "Sorpresa: recordé algo mientras comía.",
    "Rabia: algo me molestó justo antes o durante.",
    "Miedo: comí rápido, con cierta tensión.",
    "Asco: algo me hizo perder el apetito o me incomodó."
  },{
    "Como una luz suave que aún brilla.",
    "Como una nube que no se va.",
    "Como un relámpago que cruzó de pronto.",
    "Como un fuego que intento contener.",
    "Como una corriente que me mantiene alerta.",
    "Como una sensación que me gustaría quitarme de encima."
  }
};

int    estado         = 0;  // 0=intro, 1–6=preguntas, 7=mandala
int    preguntaActual = 1;
float  rotacionGlobal = 0;

// Parámetros mandala
int    anillos          = 5;
int    densidadBase     = 10;
boolean rotacionInversa = false;
boolean simetriaRadial  = true;

// Fuentes
PFont fuenteTitulo, fuenteCuerpo;

// Partículas
ParticleSystem ps;

void setup() {
  size(800, 800);
  frameRate(60);
  textAlign(CENTER, CENTER);

  fuenteTitulo = createFont("feeling_passionate.ttf", 32);
  fuenteCuerpo = createFont("type_machine.ttf", 16);

  // Emociones
  emociones.put("A", new Emoción("Alegría", "Círculo",            color(255,204,0,90)));
  emociones.put("B", new Emoción("Tristeza","Cuadrado",           color(0,102,204,90)));
  emociones.put("C", new Emoción("Sorpresa","Rombo",              color(255,105,180,90)));
  emociones.put("D", new Emoción("Rabia",   "Triángulo",           color(255,0,127,90)));
  emociones.put("E", new Emoción("Miedo",   "Rectángulo",          color(255,153,51,90)));
  emociones.put("F", new Emoción("Asco",    "Triángulo Invertido", color(0,204,102,90)));

  for (int i = 0; i < preguntasTxt.length; i++) {
    listaPreguntas.add(new Pregunta(preguntasTxt[i], respuestasTxt[i]));
  }

  ps = new ParticleSystem();
}

void draw() {
  background(255);
  ps.updateAndDisplay();

  if (estado == 0) {
    textFont(fuenteTitulo);
    fill(50,50,80);
    textSize(32);
    text("Mosaico de Sentires", width/2, height/2 - 140);

    textFont(fuenteCuerpo);
    fill(0);
    textSize(20);
    textLeading(24);
    text("A veces cuesta descifrar lo que sentimos.\nDale forma a tus emociones con este test.",
         width/2, height/2 - 40);

    textSize(16);
    text("Haz clic para comenzar", width/2, height/2 + 80);
  }
  else if (estado >= 1 && estado <= 6) {
    mostrarPregunta();
    // instrucción de navegación
    textFont(fuenteCuerpo);
    fill(100);
    textSize(14);
    text("Usa ← y → para cambiar de pregunta", width/2, height - 30);
  }
  else if (estado == 7) {
    dibujarMandalaConEstilo();
    rotacionGlobal += 0.002;
  }
}

void mousePressed() {
  ps.add(mouseX, mouseY, color(100,150,255), 20);

  if (estado == 0) {
    estado = 1;
    preguntaActual = 1;
  }
  else if (estado >= 1 && estado <= 6) {
    // Selección de figura
    Pregunta pq = listaPreguntas.get(preguntaActual-1);
    float shapeX   = width/2 - 200;
    float startY   = height/2 - pq.opciones.length * 30;
    float lineaAlt = 60;
    for (int i = 0; i < pq.opciones.length; i++) {
      float y = startY + i * lineaAlt;
      if (dist(mouseX, mouseY, shapeX, y) < 20) {
        String sel = pq.opciones[i];
        if (respuestas.size() < preguntaActual) respuestas.add(sel);
        else respuestas.set(preguntaActual-1, sel);
        ps.add(shapeX, y, emociones.get(sel).col, 30);
        break;
      }
    }
  }
}

void keyPressed() {
  if (estado >= 1 && estado <= 6) {
    if (keyCode == RIGHT) {
      // avanza a próxima pregunta
      estado++;
      preguntaActual = estado;
      if (estado > 6) {
        interpretarRespuestas();
        estado = 7;
      }
    } 
    else if (keyCode == LEFT) {
      // retrocede  
      if (estado > 1) {
        estado--;
        preguntaActual = estado;
      }
    }
  }
}

void mostrarPregunta() {
  listaPreguntas.get(preguntaActual-1).mostrar(preguntaActual);
}

void interpretarRespuestas() {
  HashMap<String,Integer> conteo = new HashMap<String,Integer>();
  for (String r : respuestas) conteo.put(r, conteo.getOrDefault(r,0)+1);
  anillos         = conteo.size() + 2;
  String ultima   = respuestas.get(respuestas.size()-1);
  densidadBase    = 6 + (ultima.charAt(0)-'A')*3;
  String primera  = respuestas.get(0);
  rotacionInversa = (primera.equals("B")||primera.equals("D")||primera.equals("F"));
  simetriaRadial  = conteo.size() <= 3;
}

void dibujarMandalaConEstilo() {
  translate(width/2, height/2);
  float radioBase = 50;
  float pulso     = sin(frameCount*0.02)*6;
  blendMode(MULTIPLY);
  noStroke();
  for (int a = 0; a < anillos; a++) {
    int cantidad = densidadBase + a*(simetriaRadial?4:7);
    float radio  = radioBase + a*50 + pulso;
    float offset = rotacionGlobal*(rotacionInversa?-1:1)*(1+a*0.1);
    for (int i = 0; i < cantidad; i++) {
      float ang = TWO_PI*i/cantidad + offset;
      pushMatrix();
      rotate(ang);
      translate(0, radio);
      if (!simetriaRadial) rotate(frameCount*0.01);
      Emoción e = emociones.get(respuestas.get(i%respuestas.size()));
      dibujarForma(e, 28 + a*2);
      popMatrix();
    }
  }
  blendMode(BLEND);
  textFont(fuenteCuerpo);
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Mandala emocional generado con tus respuestas", 0, -height/2 + 40);
}

void dibujarForma(Emoción e, float s) {
  fill(e.col);
  switch(e.forma) {
    case "Círculo":             ellipse(0,0,s,s); break;
    case "Cuadrado":            rectMode(CENTER); rect(0,0,s,s); break;
    case "Rombo":               pushMatrix(); rotate(PI/4);
                                rectMode(CENTER); rect(0,0,s,s); popMatrix(); break;
    case "Triángulo":           triangle(0,-s/2,-s/2,s/2,s/2,s/2); break;
    case "Rectángulo":          rectMode(CENTER); rect(0,0,s*0.6,s*1.2); break;
    case "Triángulo Invertido": triangle(0,s/2,-s/2,-s/2,s/2,-s/2); break;
  }
}

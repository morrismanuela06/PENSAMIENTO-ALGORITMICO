// VARIABLE POSICION EN X
int posX;
int speedX = 5;
int posY;
int speedY = 5;

void setup () {
  size(500,500);
}
void draw() {
background(255);

  posX = posX + speedX;
  posY = posY + speedY;
  
if(posX >= width || posX <= 0) {
  speedX = speedX * -1;
}
// LAS DOS BARRITAS SIGNIFICAN OR 
if(posY >= height || posY <= 0) {
  speedY = speedY * -1;
}
println(posX);
  
  fill(20,150,200);
  noStroke();
  ellipse(posX,posY,50,50);
  
 
}
  

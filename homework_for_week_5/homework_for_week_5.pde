float rotation;

void setup(){
  size(480, 600, P3D);
  noStroke();
  background(0);
  rotation = 0;

}

void draw(){
  camera(mouseX, mouseY, 500, width/2, height/2, 0, 0, 1, 0);
  background(200,160,255);
  lights();
  drawChristmasTree();
  
}

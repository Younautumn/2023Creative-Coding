void drawChristmasTree(){
  pushMatrix();

  translate(width/2, height, 0);
  fill(255);
  box(width + height, 10, width + height);
  popMatrix();
  
  pushMatrix();
  translate(width/2, 0, 0);
  rotation += 0.001;
  for(int i = 0; i < 25; i++){
    rotateY(rotation);
    pushMatrix();
    fill(2, 150 + (i*2), 0);
    box(40, 20, i * 20);
    popMatrix();
    translate(0, 20);
    
  }
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2, 180);
  textAlign(CENTER);
  textSize(30);
  fill(255, 0, 0);
  popMatrix();
} 

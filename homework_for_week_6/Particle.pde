class Particle{
  
  float xPos;
  float yPos;
  float pSize;
  float xSpeed;
  float ySpeed;
  
  Particle(){
  
    xPos=random(width);
    yPos=random(height);
    
    pSize=40.0;
    
    xSpeed=random(-2,2);
    ySpeed=random(-2,2);
    
  }

  void drawParticle(){
    
    fill(255,random(0,255),random(0,255));
    noStroke();
    ellipse(xPos,yPos,pSize,pSize);
    
    xPos+=xSpeed;
    yPos+=ySpeed;
    
    if(mousePressed==true){
      float xDist=mouseX-xPos;
      float yDist=mouseY-yPos;
      xPos+=xDist*0.1;
      yPos+=yDist*0.1;
    }
  }

  void checkEdge(){
  
    if(xPos<0){
      xPos=0;
      xSpeed*=-1.0;
    }
    if(xPos>width){
      xPos=width;
      xSpeed*=-1.0;
    }
    if(yPos<0){
      yPos=0;
      ySpeed*=-1.0;
    }
    if(yPos>height){
      yPos=height;
      ySpeed*=-1.0;
    }
  
  }



}

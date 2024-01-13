Particle [] p;

void setup(){

  size(800,640);
  p= new Particle[100];
  
  for(int i=0;i<p.length;i++){
  
    p[i]=new Particle();
    
  }
  background(255);

}

void draw(){

  background(255);
  for(int i=0;i<p.length;i++){
  
    p[i].drawParticle();
    p[i].checkEdge();
    
  }

}

float branchAngle = 0.4;
float branchLengthFactor = 0.7;
float branchThicknessFactor = 0.7;
float angle = 0;
color rootColor = color(0, 100, 0);
color tipColor = color(139, 69, 19);

boolean isPaused = false;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
}

void draw() {
  if (!isPaused) {
    background(255);
    translate(width / 2, height);
    angle += 0.01;
    branch(200, 8, angle, rootColor, tipColor);
  }
}

void branch(float length, int level, float rotation, color startColor, color endColor) {
  strokeWeight(level);


  float colorRatio = map(level, 0, 8, 0, 1);
  color branchColor = lerpColor(startColor, endColor, colorRatio);
  stroke(branchColor);

  line(0, 0, 0, -length);

  translate(0, -length);

  if (level > 1) {

    pushMatrix();
    rotate(rotation - branchAngle);
    branch(length * branchLengthFactor, level - 1, rotation, startColor, endColor);
    popMatrix();


    pushMatrix();
    rotate(rotation + branchAngle);
    branch(length * branchLengthFactor, level - 1, rotation, startColor, endColor);
    popMatrix();
  }
}

void mousePressed() {
  isPaused = true;
}

void mouseReleased() {
  isPaused = false;
}

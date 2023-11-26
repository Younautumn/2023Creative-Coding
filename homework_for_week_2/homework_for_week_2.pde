float angle = 0;
float radius = 10;
float angleIncrement = 0.1;

void setup() {
  size(400, 400);
  background(255);
  smooth();
}

void draw() {
  float x = width / 2 + cos(angle) * radius;
  float y = height / 2 + sin(angle) * radius;

  ellipse(x, y, 5, 5);

  angle += angleIncrement;
  radius += 0.05;  // You can adjust this increment for a tighter or looser spiral
}

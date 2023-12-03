int numRects = 6;  // 矩形的数量
int spread = 0;   // 扩散的范围

void setup() {
  size(600, 400);
  background(255);  // 设置背景为白色
}

void draw() {
  int rectWidth = width / numRects;
  int rectHeight = height / numRects;
  
  int centerX = numRects / 2;
  int centerY = numRects / 2;
  
  for (int i = 0; i < numRects; i++) {
    for (int j = 0; j < numRects; j++) {
      int x = i * rectWidth;
      int y = j * rectHeight;
      
      // 计算当前格子到中心格子的距离
      int distance = abs(i - centerX) + abs(j - centerY);
      
      // 根据距离确定颜色
      int colorValue = 255 - distance * spread;
      fill(colorValue);
      
      rect(x, y, rectWidth, rectHeight);
    }
  }
  
  // 扩散范围逐渐增加
  if (spread < 255) {
    spread += 1;
  }
}

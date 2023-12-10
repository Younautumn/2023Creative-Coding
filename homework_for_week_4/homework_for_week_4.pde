PImage sourceImage;  // 声明一个 PImage 对象
int pixelSize = 30;  // 像素的初始尺寸

void setup() {
  size(1280, 1280);
  
  // 加载源图像
  sourceImage = loadImage("phoenix.jpg");
  
  // 调整图像尺寸以适应窗口大小
  sourceImage.resize(width, height);
}

void draw() {
  background(0);
  
  // 遍历图像的每个像素
  for (int x = 0; x < width; x += pixelSize) {
    for (int y = 0; y < height; y += pixelSize) {
      // 获取当前像素的颜色
      color pixelColor = sourceImage.get(x, y);
      
      // 在对应位置绘制像素化的矩形
      fill(pixelColor);
      rect(x, y, pixelSize, pixelSize);
    }
  }
  
  // 每一帧减小像素尺寸
  if (pixelSize > 1) {
    pixelSize--;
  }
}

import processing.core.*;
import java.io.File;
import controlP5.*;

PImage userImage;  // 用于存储用户选择的照片
int minPixelSize = 1;  // 像素的最小尺寸
int maxPixelSize = 30;  // 像素的最大尺寸
int pixelSize = maxPixelSize;  // 像素的初始尺寸
float filterStrength = 0;  // 滤镜的强度
ControlP5 cp5;
Button exportButton;

void setup() {
  selectUserImage();

  size(800, 800);  // 初始化画布尺寸为800x800像素
  cp5 = new ControlP5(this);

  cp5.addSlider("pixelSize")
     .setPosition(20, 40)
     .setWidth(480)  // 控制条的长度为480像素
     .setHeight(20)
     .setRange(maxPixelSize, minPixelSize)
     .setValue(pixelSize)
     .setLabel("")  // 清空原有的标签
     .setSliderMode(Slider.FLEXIBLE);

  cp5.addSlider("filterStrength")
     .setPosition(20, 70)
     .setWidth(480)  // 控制条的长度为480像素
     .setHeight(20)
     .setRange(0, 1)
     .setValue(filterStrength)
     .setLabel("")  // 清空原有的标签
     .setSliderMode(Slider.FLEXIBLE);

  exportButton = cp5.addButton("exportButton")
                     .setPosition(20, 100)
                     .setWidth(480)  // 控制条的长度为480像素
                     .setHeight(30)
                     .setLabel("导出为PNG格式")
                     .addListener(new ControlListener() {
                       public void controlEvent(ControlEvent event) {
                         exportCanvasAsPNG();
                       }
                     });
}

void draw() {
  if (userImage != null) {
    background(0);  // 清空画布并设置背景为黑色
    image(userImage, 0, 0);
    applyPixelationEffect();
    applyOldPhotoFilter();
  }
}

void selectUserImage() {
  selectInput("选择照片", "imageSelected");
}

void imageSelected(File selection) {
  if (selection == null) {
    println("未选择照片");
  } else {
    userImage = loadImage(selection.getAbsolutePath());

    // 调整照片尺寸以满足限制条件
    while (userImage.width > 1800 || userImage.height > 900) {
      userImage.resize(userImage.width / 2, userImage.height / 2);
    }

    int imageWidth = userImage.width;
    int imageHeight = userImage.height;
    surface.setSize(imageWidth, imageHeight);  // 根据图片尺寸设置绘图表面的大小
  }
}

void applyPixelationEffect() {
  int numPixelsX = ceil(userImage.width / pixelSize);
  int numPixelsY = ceil(userImage.height / pixelSize);

  for (int x = 0; x < numPixelsX; x++) {
    for (int y = 0; y < numPixelsY; y++) {
      int startX = x * pixelSize;
      int startY = y * pixelSize;
      int endX = min(startX + pixelSize, userImage.width);
      int endY = min(startY + pixelSize, userImage.height);

      // 计算像素区域的平均颜色
      color pixelColor = getAverageColor(startX, startY, endX, endY);

      // 在对应位置绘制像素化的矩形，去除边框
      noStroke();
      fill(pixelColor);
      rect(startX, startY, endX - startX, endY - startY);
    }
  }
}

void applyOldPhotoFilter() {
  loadPixels();

  for (int i = 0; i < pixels.length; i++) {
    color c = pixels[i];
    float r = red(c);
    float g = green(c);
    float b = blue(c);

    // 应用老照片滤镜
    r = lerp(r, r + 40 * filterStrength, 0.5);
    g = lerp(g, g + 20 * filterStrength, 0.5);
    b = lerp(b, b - 20 * filterStrength, 0.5);
    
    pixels[i] = color(r, g, b);
  }

  updatePixels();
}

color getAverageColor(int startX, int startY, int endX, int endY) {
  float totalR = 0;
  float totalG = 0;
  float totalB = 0;
  int numPixels = 0;

  for (int x = startX; x < endX; x++) {
    for (int y = startY; y < endY; y++) {
      if (x < userImage.width && y < userImage.height) {
        color c = userImage.get(x, y);
        totalR += red(c);
        totalG += green(c);
        totalB += blue(c);
        numPixels++;
      }
    }
  }

  float averageR = totalR / numPixels;
  float averageG = totalG / numPixels;
  float averageB = totalB / numPixels;

  return color(averageR, averageG, averageB);
}

void exportCanvasAsPNG() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  String filename = "output_" + timestamp + ".png";
  save(filename);
  println("已导出为 " + filename);
}

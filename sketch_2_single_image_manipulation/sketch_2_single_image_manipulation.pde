PImage img;
String[] originalImagePaths;
ArrayList<PImage> originalImages;
String imageDir;
int imageIndex;
int manipulatorIndex;
float scale = 1.0;

void setup() {
  size(300, 300); 

  imageDir = sketchPath("")+"../original_images/";
  imageIndex = 0;
  manipulatorIndex = 0;

  File dir = new File(imageDir);

  originalImagePaths = dir.list();

  originalImages = new ArrayList<PImage>();

  // Load Images
  for (String imgPath : originalImagePaths) {
    if (imgPath.indexOf(".png") == -1) {
      continue;
    }
    //    if (imgPath.indexOf("_") == 0) {
    //      continue;
    //    }
    originalImages.add(loadImage(imageDir + imgPath));
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      imageIndex++;
    } else if (keyCode == LEFT) {
      imageIndex--;
    } else if (keyCode == DOWN) {
      manipulatorIndex--;
    } else if (keyCode == UP) {
      manipulatorIndex++;
    }
  } else {
    if (key == '-' || key == '_') {
      scale -= 0.1;
    } else if (key == '=' || key == '+') {
      scale += 0.1;
    } else if (key == 'r') {
      // Reset
      scale = 1.0;
    } else {
      println("Unkown key pressed:", key, keyCode);
    } 
  }
  redraw();
}

void draw() {

  background(0);
  stroke(255);
  fill(255);

  if (imageIndex >= originalImages.size()) {
    imageIndex = 0;
  } else if (imageIndex < 0) {
    imageIndex =  originalImages.size() - 1;
  }

  img = originalImages.get(imageIndex);
  img.loadPixels();
  // Resize
  image(img, 0, 0, width*scale, height*scale);
  // Load pixels from render into pixels array that can be accessed
  loadPixels();

  String manipulatorName;
  int manipulators = 5;
  if (manipulatorIndex > manipulators) {
    manipulatorIndex = 0;
  } else if (manipulatorIndex < 0) {
    manipulatorIndex = manipulators;
  }
  switch (manipulatorIndex) {
  case 1:
    manipulatorName = "equalize";      
    equalize(pixels);
    updatePixels();
    break;
  case 2:
    manipulatorName = "normalize";      
    normalization(pixels);
    updatePixels();
    break;
  case 3:
    fill(0);
    rect(0, 0, width, height);
    manipulatorName = "histogram";      
    float[] hist = histogram(pixels, (int) width);
    drawHistogram(hist);
    break;
   case 4:
    manipulatorName = "quantization(2)";      
    color[] q1 = quantization(pixels, 2);
    arrayCopy(q1, pixels);
    updatePixels();
    break;
   case 5:
    manipulatorName = "quantization(256)";      
    color[] q2 = quantization(pixels, 256);
    arrayCopy(q2, pixels);
    updatePixels();
    break;
  default:
    manipulatorName = "none";
  }
  String msg = "Image "+imageIndex+" with manipulation "+manipulatorName;
  color textBackgroundColor = color(255,255,255,200);
  fill(textBackgroundColor);
  rect(5,20,width-10,20);
  color textColor = color(0, 102, 153);
  fill(textColor);
  stroke(textColor);
  textSize(12);
  text(msg, 10, 20, width-20, 20);
}

/**
 return [min,max,sum]
 */
float[] stats(color[] pixels) {
  float sum = 0;  
  float min = 1;
  float max = 0;
  for (int p = 0; p < pixels.length; p++) {
    float value = brightness(pixels[p]) / 255.0;
    sum += value;
    if (value < min) {
      min = value;
    }
    if (value > max) {
      max = value;
    }
  }
  float[] results = { 
    min, max, sum
  };
  return results;
}

void equalize(color[] pixels) {

  float[] stats = stats(pixels);
  float min = stats[0];
  float max = stats[1];

  for (int p = 0; p < pixels.length; p++) {
    float prev = brightness(pixels[p]) / 255.0;
    float value = (prev - min) / (max-min);
    color c = color(255.0 * value);
    pixels[p] = c;
  }
}

void normalization(color[] pixels) {

  float[] stats = stats(pixels);
  float sum = stats[2];

  for (int p = 0; p < pixels.length; p++) {
    float prev = brightness(pixels[p]) / 255.0;
    float value = prev / sum;
    color c = color(255.0 * value);
    pixels[p] = c;
  }
}


float[] histogram(color[] pixels, int n) {

  float[] h = new float[n];

  for (int p = 0; p < pixels.length; p++) {
    float prev = brightness(pixels[p]) / 256.0;
    int pos = (int) ((float)prev * n);
    h[pos]++;
  }

  return h;
}

void drawHistogram(float[] histogram) {
  int n = histogram.length;
  float[] normalHistogram = new float[n];
  // Normalize histogram
  float maxValue = max(histogram);
  // Normalize the histogram to values between 0 and "height"
  for (int i=0; i<n; i++) {  
    normalHistogram[i] = (float) (histogram[i] * height / maxValue);
  }
  // Draw vertical bars for histogram
  stroke(255);
  for (int x=0; x<width; x++) {
    // 
    float y = normalHistogram[ (int) ((float)x*((float)n/width)) ];
    //    println(y, x, n, width);
    line(x, height, x, height - y);
  }
}

color[] quantization(color[] pixels, int n) {

  color[] q = new color[pixels.length];

  for (int p = 0; p < pixels.length; p++) {
    float prev = brightness(pixels[p]);
    int v = (int) ((float) prev * n / 256.0);
    color c = color(v * (256.0/(n-1)));
//    println(p, n, prev, v, brightness(c));
    q[p] = c;
  }

  return q;
}


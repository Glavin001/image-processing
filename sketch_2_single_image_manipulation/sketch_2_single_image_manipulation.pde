PImage img;
String[] originalImagePaths;
ArrayList<PImage> originalImages;
String imageDir;
int i;

void setup() {
  size(300, 300); 

  imageDir = sketchPath("")+"../original_images/";
  i = 0;

  File dir = new File(imageDir);

  originalImagePaths = dir.list();

  //  println(imageDir);
  //  println(dir.getAbsolutePath());
  //  println(originalImagePaths);

  //  originalImages = new PImage[originalImagePaths.length];

  originalImages = new ArrayList<PImage>();

  // Load Images
  //  for (int p=0; p<originalImagePaths.length; p++) {
  //    String imgPath = imageDir + originalImagePaths[p];
  //    originalImages[p] = loadImage(imgPath);
  //  }
  for (String imgPath : originalImagePaths) {
    if (imgPath.indexOf(".png") == -1) {
      continue;
    }
    //    if (imgPath.indexOf("_") == 0) {
    //      continue;
    //    }
    originalImages.add(loadImage(imageDir + imgPath));
  }

//  frameRate(0.5);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      i++;
    } else if (keyCode == DOWN) {
      i--;
    }
    redraw();
  }
}

void draw() {

  background(0);

  //  i++;
  //  i = 13;

  if (i >= originalImages.size()) {
    i = 0;
  } else if (i < 0) {
    i =  originalImages.size() - 1;
  }
  //  println(i, originalImages.length);

  //  String imgPath = imageDir + originalImages[i];
  //  println(imgPath);

  //  if (imgPath.indexOf(".png") != -1) {
  //    img = loadImage(imgPath);
  img = originalImages.get(i);
  //    image(img, 0, 0, width, height);
  img.loadPixels();
  //    float[] stats = stats(img);
  //    println(stats);
  equalize(img);
  image(img, 0, 0, width, height);
  //  }
  
  textSize(12);
  String manip = "equalize";
  text("Image "+i+" with manipulation "+manip, 10, 20);
  
}

/**
 Deprecated: use `stats` method instead
 */
//float brightness(PImage img) {
//  img.loadPixels();  
//  float sum = 0;
//  for (int p=0; p<img.pixels.length; p++) {
//    float value = brightness(img.pixels[p]);
//    sum += value;
//  }
//  return sum;
//}

/**
 return [min,max,sum]
 */
float[] stats(PImage img) {
  float sum = 0;  
  float min = 1;
  float max = 0;
  for (int p = 0; p < img.pixels.length; p++) {
    float value = brightness(img.pixels[p]) / 255.0;
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

void equalize(PImage img) {

  float[] stats = stats(img);
  float min = stats[0];
  float max = stats[1];
  float sum = stats[2];

  for (int p = 0; p < img.pixels.length; p++) {
    float prev = brightness(img.pixels[p]) / 255.0;
    float value = (prev - min) / (max-min);
    color c = color(255.0 * value);
    img.pixels[p] = c;
  }
  img.updatePixels();
}


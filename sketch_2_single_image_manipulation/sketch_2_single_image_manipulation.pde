PImage img;
String[] originalImagePaths;
ArrayList<PImage> originalImages;
String imageDir;
int imageIndex;
int manipulatorIndex;

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
    redraw();
  }
}

void draw() {

  background(0);

  if (imageIndex >= originalImages.size()) {
    imageIndex = 0;
  } else if (imageIndex < 0) {
    imageIndex =  originalImages.size() - 1;
  }
  
  img = originalImages.get(imageIndex);
  img.loadPixels();
  image(img, 0, 0, width, height);
  loadPixels();
  
  textSize(12);
  String manipulatorName;
  int manipulators = 1;
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
    default:
      manipulatorName = "none";
  }
  text("Image "+imageIndex+" with manipulation "+manipulatorName, 10, 20);
  
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
  float sum = stats[2];

  for (int p = 0; p < pixels.length; p++) {
    float prev = brightness(pixels[p]) / 255.0;
    float value = (prev - min) / (max-min);
    color c = color(255.0 * value);
    pixels[p] = c;
  }
  
}


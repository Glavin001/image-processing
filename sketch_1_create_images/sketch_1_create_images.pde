PImage img;

// Helpers
PVector pointFromPixel(int i) {
  int y = (int) i / width;
  int x = (int) i % width;
  return new PVector(x,y);
}

PVector[] randomPixelPoints(int count) {
  PVector[] points = new PVector[count];  
  for (int c=0; c<count; c++) {
    int x = (int) random(0, width);
    int y = (int) random(0, height);
    PVector p = new PVector(x, y);
    points[c] = p;
  }
  return points;
}

// Constant
float constantIntensity = 200;
void constantImage(float intensity) {
  background(intensity);
}

// White noise
void whiteNoise() {
  for (int i=0; i<width; i++) {
    for (int j=0; j<height; j++) {
      // Random
      float r = random(0, 1);
      // Pixels are actually from range 0 to 255, not 0 to 1.....
      int c = (int) (255 * r);
      stroke(c);
      point(i, j);
    }
  }
}

// Interesting Noise
// iterations  - number of iterations
// delta  - if delta is negative then use random for each iteration 
//          with the absolute value of delta being the max delta
// multiplicatively  - if not multiplicatively then additively
void interestingNoise(int iterations, float delta, boolean multiplicatively) {
  // load pixels in pixel[] variable
  loadPixels();

  // Step 0: Set all pixel values to 0.5
  // Loop through every pixel
  for (int i = 0; i < pixels.length; i++) {
    // Create a grayscale color based on random number
    color c = color(0.5 * 255);
    // Set pixel at that location to random color
    pixels[i] = c;
  }

  for (int i = 0; i<iterations; i++) {
    // Step 1: Pick 2 random pixels
    PVector[] ps = randomPixelPoints(2);
     
    // Set the delta, change for each iteration
    float d;
    if (delta < 0) {
      // set randomly on each iteration
      float  maxDelta = abs(delta);
      d = random(0, maxDelta);
    } else {
      d = delta;
    }

//    println("iteration: ", i,"random points:", ps);

    // Step 2: 
    // Loop through every pixel
    for (int j = 0; j < pixels.length; j++) {
      PVector p = pointFromPixel(j);
//      int y = (int) j / width;
//      int x = (int) j % width;
      color prev = pixels[j];
      float r, g, b, brightness;
      r = red(prev);
      g = green(prev);
      b = blue(prev);
      brightness = brightness(prev);
      
//      println("current point:", x, y);
      
      // From http://stackoverflow.com/a/1560510/2578205
      float position = ( (ps[1].x-ps[0].x)*(p.y-ps[0].y) - (ps[1].y-ps[0].y)*(p.x-ps[0].x) );
      
      float c = 0;
      if (position == 0) {
        // On the line
        // Do nothing
      } else if (position < 0) {
        // On a side of the line
        // Negative
        c = -d;
      } else if (position > 0) {
        // On another side of the line
        // Positive
        c = d;
      } else {
        println("Uknown position:",position);
      }
      // Create new color
      if (multiplicatively) {
        r *= c;
        g *= c;
        b *= c;        
      } else {
        r += c;
        g += c;
        b += c;
      }
      // Apply new color
      color nc = color(r,g,b);
      pixels[j] = nc;

    }
  }
  // flush pixel changes
  updatePixels();
}

// Photographs
void loadPhoto(String path) {
  PImage img = loadImage(path);
  image(img, 0, 0, width, height);
}

// Gaussian
// http://en.wikipedia.org/wiki/Gaussian_function
void gaussian(PVector u, float c) {
  loadPixels();
  
  // Loop through every pixel
  for (int j = 0; j < pixels.length; j++) {
    PVector p = pointFromPixel(j);
    float d = p.dist(u) / 255;
    float v = exp((-pow(d,2))/(2*pow(c,2)));
//    println("pixel:",v,p,u,d,c);
    pixels[j] = color(v*255);
  }
  
  updatePixels();
}

// Stripes
float theta = 0;

// Sizes
int[] sizes = {
  3, 10, 300
};

void setup() {
  // Images must be in the "data" directory to load correctly
  //  img = loadImage("laDefense.jpg");
  frameRate(1);
  //  int s = sizes[2];
  size(300, 300);
}

int frame = 0;
void draw() {
  //  image(img, 0, 0);
  int numFrames = 5;
  int f = frame % numFrames;
  f = 4;
  
  switch(f) {
    case 0:
      // Constant image
      constantImage(constantIntensity);
      break;
    case 1:
      whiteNoise();
      break;
    case 2:
      interestingNoise(100, -2, false);
      break;
    case 3:
      interestingNoise(10, -2, true);
      break;
    case 4:
      PVector p = randomPixelPoints(1)[0];
      float c = 1.0;
      gaussian(p, c);
      break;
    default: 
      println("Frame not found!");
  }

  frame++;
}


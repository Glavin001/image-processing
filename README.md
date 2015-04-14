# Image Processing

> Image Processing assignment for CSCI 4471 Computer Graphics

![single_image_manip](https://cloud.githubusercontent.com/assets/1885333/7149015/f1af58e0-e2de-11e4-82bf-55336948548b.gif)

## Author

- Glavin Wiechert

## Installation

1. Download and install [Processing](https://processing.org/).
2. Download / Clone this repository.
3. Follow [usage](#usage) below.

## Usage

### 1. Sample Image Creation

Run the [sketch_1_create_images]() script and it will generate images in your [original_images] directory.

To change the image size, you can change the `size(300,300)` call before running. The image size generated is the same as the Processing's display size.

### 2. Single-Image Manipulation

Run the [sketch_2_single_image_manipulation]() script.
It will load the images from [original_images] directory and allow you to view them with different manipulators.

#### Controls

- `UP` / `DOWN` - Change Manipulator of image
- `LEFT` / `RIGHT` - Change selected sample image
- `+` / `-` - Zoom in/out
- `r` - Reset zoom, etc

### 3. Multi-Image Manipulation

*Coming soon.*

## Features

List of implemented features to be graded.

### [✓] 1. Sample Image Creation

See https://github.com/Glavin001/image-processing/issues/1

- [✓] `Constant`: Set each pixel to a given constant intensity value.

    ![constant_image_300x300_1](https://cloud.githubusercontent.com/assets/1885333/7014403/d2d93412-dc9a-11e4-8efc-added019aaa8.png)
    ![constant_image_300x300_2](https://cloud.githubusercontent.com/assets/1885333/7014402/d2d8ec3c-dc9a-11e4-8b9a-fa0f8b964c2f.png)
    ![constant_image_300x300_3](https://cloud.githubusercontent.com/assets/1885333/7014404/d2dac32c-dc9a-11e4-9f2b-5934abd6eb1e.png)

- [✓] `White noise`: Set each pixel to a random float between 0 (dark) and 1 (bright), independent of every other pixel

    ![white_noise_300x300_1](https://cloud.githubusercontent.com/assets/1885333/7014417/d2f8e7f8-dc9a-11e4-9d38-0a4f5c951014.png)
    ![white_noise_300x300_2](https://cloud.githubusercontent.com/assets/1885333/7014418/d2fbaede-dc9a-11e4-9dae-80b5df901e1b.png)
    ![white_noise_300x300_3](https://cloud.githubusercontent.com/assets/1885333/7014419/d2fe751a-dc9a-11e4-925d-ea27c580a8fa.png)


- [✓] An `interesting noise`:

    - Step 0: Set all pixel values to 0.5

    - Step 1: Randomly choose 2 pixels in the image; note that they define a straight line

    - Step 2: For all pixels to the left of the line, increase their brightness by δ; for all pixels to the right of the line, decrease their brightness by δ.

    - Go back to step 1.
    Play around with different values of δ. What happens if you choose δ randomly on
    each iteration? What happens if you apply δ multiplicatively versus additively?

    Additively:

    ![interesting_noise_additively_300x300_1](https://cloud.githubusercontent.com/assets/1885333/7014409/d2e7416a-dc9a-11e4-8b3e-740e4427f42f.png)
    ![interesting_noise_additively_300x300_2](https://cloud.githubusercontent.com/assets/1885333/7014408/d2e6e4c2-dc9a-11e4-8ee7-ad898cff4aa1.png)
    ![interesting_noise_additively_300x300_3](https://cloud.githubusercontent.com/assets/1885333/7014410/d2e8f1fe-dc9a-11e4-8e88-0335e34284a6.png)

    Multiplicatively:

    ![interesting_noise_multiplicatively_300x300_1](https://cloud.githubusercontent.com/assets/1885333/7014412/d2ea75c4-dc9a-11e4-8423-b0bc92ddf89d.png)
    ![interesting_noise_multiplicatively_300x300_2](https://cloud.githubusercontent.com/assets/1885333/7014411/d2ea67fa-dc9a-11e4-809a-73d946312d9c.png)
    ![interesting_noise_multiplicatively_300x300_3](https://cloud.githubusercontent.com/assets/1885333/7014413/d2ed6e64-dc9a-11e4-95fe-c34bbfb895a0.png)

- [✓] `Photographs`: Load in a few photographs of your choice

    Sample photograph:

    ![photograph_flowers_300x300_1](original_images/photograph_flowers_300x300_1.png)

    You can easily load more by simply placing them in the [original_images]() directory.

- [✓] `Gaussian`: See http://en.wikipedia.org/wiki/Gaussian_function

    ![gaussian function equation](http://upload.wikimedia.org/math/5/a/4/5a46a2be0dabeefc8a496bb06c268fc2.png)

    ![gaussian_300x300_1](https://cloud.githubusercontent.com/assets/1885333/7014405/d2db125a-dc9a-11e4-9f95-99e88f6c937f.png)
    ![gaussian_300x300_2](https://cloud.githubusercontent.com/assets/1885333/7014406/d2dbde9c-dc9a-11e4-9356-07ac5c417a03.png)
    ![gaussian_300x300_3](https://cloud.githubusercontent.com/assets/1885333/7014407/d2dcee0e-dc9a-11e4-8cf7-dd873add661e.png)

- [✓] `Stripes`: Create an image filled with parallel lines. Can your stripe function take a parameter θ so that the stripes are at an orientation θ?

    ![stripes_300x300_1](https://cloud.githubusercontent.com/assets/1885333/7014414/d2f556ec-dc9a-11e4-9e5e-19fc86914afb.png)
    ![stripes_300x300_2](https://cloud.githubusercontent.com/assets/1885333/7014415/d2f726ca-dc9a-11e4-8b5a-200bad72ddd1.png)
    ![stripes_300x300_3](https://cloud.githubusercontent.com/assets/1885333/7014416/d2f7751c-dc9a-11e4-9ef8-10aa4b376447.png)


### [✓] 2. Single-Image Manipulation

See https://github.com/Glavin001/image-processing/issues/2

![single_image_manip](https://cloud.githubusercontent.com/assets/1885333/7149015/f1af58e0-e2de-11e4-82bf-55336948548b.gif)

- [✓] 2.1 Brightness
- [✓] 2.2 Equalize
- [✓] 2.3 Normalize
- [✓] 2.4 Histogram
- [✓] 2.5 Quantization
- [✓] 2.6 Resizing

### [ ] 3. Multi-Image Manipulation

*Not yet implemented.*


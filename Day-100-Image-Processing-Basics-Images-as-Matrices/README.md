# Day 100 · Image Processing Basics: Images as Matrices

_Advanced MATLAB and Toolboxes_

## An image is a matrix
- A **grey-scale** image is an m×n matrix: each element is the brightness of one pixel (`uint8` 0–255, or `double` 0–1).
- A **colour (RGB)** image is m×n×3: red, green and blue layers.
- A **binary** image is a logical matrix.

## Core commands
| Command | Does |
|---------|------|
| `A = imread('photo.jpg')` | read an image file |
| `imshow(A)` / `image(A)` / `imagesc(A)` | display |
| `imwrite(A, 'out.png')` | save |
| `size(A)` | rows, columns, colour layers |
| `rgb2gray(A)` | to grey-scale (Image Processing Toolbox; or a weighted sum of the layers) |
| `im2double`, `uint8` | convert the type |
| `A(r1:r2, c1:c2, :)` | crop |
| `A(end:-1:1, :, :)` / `fliplr` | flip |
| `imresize`, `imrotate`, `imadjust`, `imhist`, `histeq`, `imbinarize`, `edge`, `imfilter`, `medfilt2`, `bwlabel`, `regionprops` | Image Processing Toolbox |

## Filtering with convolution
`conv2(A, K, 'same')` slides a small **kernel** K over the image:
- blur: `K = ones(3)/9`
- edges (Sobel): `Kx = [-1 0 1; -2 0 2; -1 0 1]`, `Ky = Kx'`, magnitude `sqrt(Gx.^2 + Gy.^2)`
- sharpen: `[0 -1 0; -1 5 -1; 0 -1 0]`

## Examples

### Example 1: Making and displaying an image matrix  ([`example_1.m`](example_1.m))

```matlab
[X, Y] = meshgrid(1:200, 1:150);
img = uint8(255 * (0.5 + 0.5*sin(X/10) .* cos(Y/15)));   % a grey-scale pattern
img(60:90, 80:130) = 255;                                 % a white rectangle
size(img), class(img)
subplot(1, 2, 1); imagesc(img); colormap(gray); axis image; title('Grey-scale (uint8)')
rgb = zeros(150, 200, 3, 'uint8');
rgb(:, :, 1) = uint8(255 * X/200);         % red increases to the right
rgb(:, :, 3) = uint8(255 * Y/150);         % blue increases downwards
subplot(1, 2, 2); image(rgb); axis image; title('RGB (m x n x 3)')
fprintf('Mean brightness %.1f, the pixel (100, 100) = %d\n', mean(img(:)), img(100, 100));
```

### Example 2: Brightness, contrast, threshold and histogram  ([`example_2.m`](example_2.m))

```matlab
rng(4);
img = 80 + 30*rand(120, 160);                     % a dull, low-contrast, noisy image
img(40:80, 50:110) = img(40:80, 50:110) + 70;     % a brighter object
stretched = (img - min(img(:))) / (max(img(:)) - min(img(:))) * 255;   % contrast stretch
level = 128;                                      % half-way in the stretched range
mask = stretched > level;                         % a binary image
subplot(2, 2, 1); imagesc(img, [0 255]); colormap(gray); axis image; title('Original')
subplot(2, 2, 2); imagesc(stretched, [0 255]); axis image; title('Contrast stretched')
subplot(2, 2, 3); hist(stretched(:), 40); title('Histogram')
subplot(2, 2, 4); imagesc(mask); axis image; title('Threshold')
[r, c] = find(mask);
fprintf('Object found at rows %d-%d, columns %d-%d (%d pixels)\n', min(r), max(r), min(c), max(c), nnz(mask));
```

### Example 3: Blur and edge detection with conv2  ([`example_3.m`](example_3.m))

```matlab
img = zeros(100);
img(30:70, 30:70) = 1;                            % a square
[X, Y] = meshgrid(1:100);
img((X - 75).^2 + (Y - 25).^2 < 15^2) = 0.6;      % a circle
blur = conv2(img, ones(5)/25, 'same');
Kx = [-1 0 1; -2 0 2; -1 0 1];
Gx = conv2(img, Kx, 'same'); Gy = conv2(img, Kx', 'same');
edges = sqrt(Gx.^2 + Gy.^2);
subplot(1, 3, 1); imagesc(img); axis image; title('Image')
subplot(1, 3, 2); imagesc(blur); axis image; title('Blurred')
subplot(1, 3, 3); imagesc(edges > 0.5); axis image; title('Sobel edges')
colormap(gray)
fprintf('Edge pixels found: %d\n', nnz(edges > 0.5));
```

## Practice

1. Read one of your own photos with `imread`, show its size and display each colour layer separately.
2. Convert an RGB image to grey with `0.299R + 0.587G + 0.114B`.
3. Crop the middle half of an image and flip it upside down.
4. Apply the sharpening kernel to a blurred image.

---

[⬅ Day 099](../Day-099-Control-Systems-2-Bode-Root-Locus-Margins-and-PID-Design/README.md) · [🏠 Home](../README.md) · [Day 101 ➡](../Day-101-Statistics-and-Probability-Distributions/README.md)

% Day 100 · Image Processing Basics: Images as Matrices — Brightness, contrast, threshold and histogram
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

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

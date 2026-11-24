% Day 100 · Image Processing Basics: Images as Matrices — Making and displaying an image matrix
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

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

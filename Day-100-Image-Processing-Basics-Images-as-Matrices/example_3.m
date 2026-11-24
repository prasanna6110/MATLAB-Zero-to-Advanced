% Day 100 · Image Processing Basics: Images as Matrices — Blur and edge detection with conv2
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

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

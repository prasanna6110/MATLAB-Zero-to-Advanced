% Day 080 · Contour Plots and Special 3-D Graphics — Points, stems, sphere and cylinder
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

subplot(2, 2, 1)
rng(1); P = randn(3, 80);
scatter3(P(1, :), P(2, :), P(3, :), 20, P(3, :), 'filled'); title('scatter3')
% In MATLAB, bar3(magic(4)) draws 3-D bars (not available in GNU Octave)
subplot(2, 2, 2)
t = linspace(0, 2*pi, 20);
stem3(cos(t), sin(t), t); title('stem3')
subplot(2, 2, 3)
[Xs, Ys, Zs] = sphere(30);
surf(Xs, Ys, Zs); axis equal; title('sphere')
subplot(2, 2, 4)
[Xc, Yc, Zc] = cylinder(1 + 0.3*sin(linspace(0, 2*pi, 20)), 40);   % a vase shape
surf(Xc, Yc, Zc); title('cylinder (shape of revolution)')

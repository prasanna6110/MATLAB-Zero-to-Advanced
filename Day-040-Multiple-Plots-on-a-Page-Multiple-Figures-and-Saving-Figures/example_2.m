% Day 040 · Multiple Plots on a Page, Multiple Figures and Saving Figures — Spanning cells and multiple figure windows
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = linspace(0, 10, 300);
figure(1)
subplot(2, 2, 1); plot(x, sin(x)); title('sin')
subplot(2, 2, 2); plot(x, cos(x)); title('cos')
subplot(2, 2, [3 4]); plot(x, sin(x).*cos(x)); title('sin \cdot cos spans the bottom row')
figure(2)
plot(x, exp(-x/3)); title('A second window')
fprintf('Open figure windows: %d\n', numel(get(0, 'Children')));
close all

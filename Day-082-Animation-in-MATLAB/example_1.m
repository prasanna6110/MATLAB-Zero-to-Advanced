% Day 082 · Animation in MATLAB — A travelling wave by updating YData
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

x = linspace(0, 4*pi, 300);
h = plot(x, sin(x), 'LineWidth', 2);
ylim([-1.2 1.2]); grid on
xlabel('x'); title('A travelling wave')
for k = 1:60
    set(h, 'YData', sin(x - 0.2*k));
    drawnow
end
fprintf('Animated %d frames\n', k);

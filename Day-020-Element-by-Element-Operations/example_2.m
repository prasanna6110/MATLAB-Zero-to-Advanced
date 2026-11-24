% Day 020 · Element-by-Element Operations — Evaluating a formula at many points
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = 1:5;
y = (x.^2 + 1) ./ (x + 3)
% Same thing with a loop (slower, longer):
y_loop = zeros(1, 5);
for k = 1:5
    y_loop(k) = (x(k)^2 + 1) / (x(k) + 3);
end
y_loop
isequal(y, y_loop)

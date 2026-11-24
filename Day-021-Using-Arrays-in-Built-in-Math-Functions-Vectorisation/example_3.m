% Day 021 · Using Arrays in Built-in Math Functions (Vectorisation) — Loop vs vectorised code, and timing it
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

N = 1e6;
x = linspace(0, 10, N);
tic
y1 = zeros(1, N);
for k = 1:N
    y1(k) = exp(-0.2 * x(k)) * sin(3 * x(k));
end
t_loop = toc;
tic
y2 = exp(-0.2 * x) .* sin(3 * x);
t_vec = toc;
fprintf('Loop: %.4f s   Vectorised: %.4f s   Same result: %d\n', t_loop, t_vec, max(abs(y1 - y2)) < 1e-12);

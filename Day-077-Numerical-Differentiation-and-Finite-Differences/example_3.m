% Day 077 · Numerical Differentiation and Finite Differences — Velocity and acceleration from position data, and Euler's method
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

t = 0:0.05:2;
rng(6);
pos = 4.9*t.^2 + 0.002*randn(size(t));     % a falling object with tiny noise
vel = gradient(pos, 0.05);
acc = gradient(vel, 0.05);
fprintf('Mean acceleration from data: %.2f m/s^2 (true 9.8)\n', mean(acc(5:end-5)));
% Euler's method for dy/dt = -2y, y(0) = 1
for h = [0.5 0.1 0.01]
    tt = 0:h:2; y = zeros(size(tt)); y(1) = 1;
    for k = 1:numel(tt) - 1
        y(k + 1) = y(k) + h * (-2*y(k));
    end
    fprintf('h = %.2f: y(2) = %.5f (exact %.5f)\n', h, y(end), exp(-4));
end

% Day 023 · Generation of Random Numbers — A dice experiment and an estimate of pi
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

rng(3);
rolls = randi(6, 1, 60000);
for face = 1:6
    fprintf('Face %d: %.4f\n', face, mean(rolls == face));   % close to 1/6 each
end
% Monte Carlo: fraction of random points inside the quarter circle
N = 200000;
x = rand(1, N); y = rand(1, N);
inside = (x.^2 + y.^2) <= 1;
pi_estimate = 4 * mean(inside)

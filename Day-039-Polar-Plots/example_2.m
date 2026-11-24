% Day 039 · Polar Plots — An antenna-like radiation pattern
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

theta = linspace(0, 2*pi, 720);
pattern = abs(cos(theta) .* sin(4*theta)) + 0.05;   % a made-up multi-lobe pattern
polar(theta, pattern, 'r')
title('Radiation pattern')
[~, k] = max(pattern);
fprintf('Main lobe at %.1f degrees\n', rad2deg(theta(k)));

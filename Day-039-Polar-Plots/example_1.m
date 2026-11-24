% Day 039 · Polar Plots — Rose curves and spirals
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

theta = linspace(0, 2*pi, 400);
subplot(1, 2, 1)
polar(theta, abs(cos(3*theta)))
title('r = |cos 3\theta|')
subplot(1, 2, 2)
th = linspace(0, 6*pi, 600);
polar(th, th)
title('Spiral r = \theta')

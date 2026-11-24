% Day 039 · Polar Plots — A phasor diagram with compass
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

V = 230;
I = 10 * exp(-1j*deg2rad(36.87));         % lagging current, pf 0.8
VR = 8 * 10 * exp(-1j*deg2rad(36.87));    % drop across an 8 ohm resistor
compass([V/23, I, VR/23])                 % scaled so all are visible
title('Phasors (scaled): V, I, V_R')
fprintf('Power factor = %.2f lagging\n', cos(angle(V) - angle(I)));

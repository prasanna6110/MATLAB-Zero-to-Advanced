% Day 069 · Interpolation: interp1, spline and interp2 — Filling gaps in hourly data and 2-D interpolation
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

hours = 0:23;
temp = [22 21 21 20 20 21 23 NaN NaN 30 32 33 34 NaN 35 34 33 31 29 NaN 26 25 24 23];
good = ~isnan(temp);
filled = temp;
filled(~good) = interp1(hours(good), temp(good), hours(~good), 'pchip');
fprintf('Filled hours %s with %s\n', mat2str(hours(~good)), mat2str(filled(~good), 3));
% A motor efficiency map: rows = torque, columns = speed
speed = [500 1000 1500];
torque = [10 20 30];
eta = [80 86 88; 84 90 91; 83 89 92];
fprintf('Efficiency at 1250 rpm, 25 Nm: %.2f %%\n', interp2(speed, torque, eta, 1250, 25));

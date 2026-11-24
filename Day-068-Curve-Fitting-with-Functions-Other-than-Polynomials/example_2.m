% Day 068 · Curve Fitting with Functions Other than Polynomials — Power-law fit: a fan law
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

speed = [600 800 1000 1200 1400];          % rpm
power = [0.52 1.25 2.40 4.20 6.70];        % kW
p = polyfit(log(speed), log(power), 1);
m = p(1); b = exp(p(2));
fprintf('P = %.3g * N^%.2f  (the fan law predicts the exponent 3)\n', b, m);
fprintf('Predicted power at 1500 rpm: %.2f kW\n', b * 1500^m);
loglog(speed, power, 'bo', speed, b*speed.^m, 'r-'); grid on
xlabel('Speed (rpm)'); ylabel('Power (kW)')

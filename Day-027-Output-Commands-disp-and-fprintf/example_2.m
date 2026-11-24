% Day 027 · Output Commands: disp and fprintf — Width, alignment and signs
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

items = {'Resistor', 'Capacitor', 'IC 555'};
prices = [2.5 12 18.75];
fprintf('%-12s|%8s\n', 'Item', 'Price');
fprintf('%s\n', repmat('-', 1, 21));
for k = 1:3
    fprintf('%-12s|%8.2f\n', items{k}, prices(k));
end
fprintf('%+d %+d\n', 5, -5);
fprintf('[%06.2f]\n', 3.14159);
fprintf('Tab\tseparated\tvalues\n');

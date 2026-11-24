% Day 028 · Building Text with sprintf, num2str and Formatted Tables — sprintf for labels and file names
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

P = 12.3456;
label = sprintf('Load = %.1f kW', P)
for k = [1 7 23]
    fname = sprintf('report_%03d.txt', k);
    disp(fname)
end
msg = sprintf('%s scored %d marks', 'Neha', 87);
disp(upper(msg))

% Day 028 · Building Text with sprintf, num2str and Formatted Tables — A vectorised table with one fprintf
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

f = [50 100 500 1000 5000];
L = 10e-3;  C = 10e-6;
XL = 2*pi*f*L;
XC = 1 ./ (2*pi*f*C);
tbl = [f; XL; XC];
fprintf('%8s %10s %10s\n', 'f (Hz)', 'XL (ohm)', 'XC (ohm)');
fprintf('%8d %10.3f %10.3f\n', tbl);       % tbl is 3xN, read column by column

% Day 054 · Anonymous Functions — Engineering formulas as anonymous functions
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

XL = @(f, L) 2*pi*f.*L;
XC = @(f, C) 1 ./ (2*pi*f.*C);
Zmag = @(R, f, L, C) sqrt(R.^2 + (XL(f, L) - XC(f, C)).^2);   % uses the other two
f = [25 50 100 200];
disp([f; Zmag(10, f, 0.1, 100e-6)])
f0 = fzero(@(f) XL(f, 0.1) - XC(f, 100e-6), 50);
fprintf('Resonance at %.2f Hz\n', f0);

% Day 055 · Function Handles and Function Functions (feval) — Handles to built-in and anonymous functions
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

h = @cos;
h(0)
fns = {@sin, @cos, @(x) x.^2, @sqrt};       % a cell array of functions
x = 0.5;
for k = 1:numel(fns)
    fprintf('%-12s(%.1f) = %.4f\n', func2str(fns{k}), x, fns{k}(x));
end
f = str2func('exp');
f(1)
feval(@log10, 1000)
feval('max', [3 9 2])                      % the old way, by name

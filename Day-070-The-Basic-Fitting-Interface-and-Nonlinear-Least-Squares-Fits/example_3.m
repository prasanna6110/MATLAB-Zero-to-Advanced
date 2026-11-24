% Day 070 · The Basic Fitting Interface and Nonlinear Least-Squares Fits — Toolbox fits: lsqcurvefit and fit
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: needs the Optimization and Curve Fitting toolboxes
% Needs: Optimization Toolbox, Curve Fitting Toolbox
x = (0:0.5:5)';
y = 3*exp(-0.7*x) + 0.5 + 0.05*randn(size(x));
model = @(c, x) c(1)*exp(-c(2)*x) + c(3);
c = lsqcurvefit(model, [1 1 0], x, y)
f = fit(x, y, 'exp2')          % a library model: a*exp(b*x) + c*exp(d*x)
plot(f, x, y)

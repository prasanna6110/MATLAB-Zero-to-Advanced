% Day 065 · Polynomials: polyval, roots and poly — roots and poly are opposites
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

p = [1 -6 11 -6];          % (x-1)(x-2)(x-3)
r = roots(p)'
back = poly(r)             % recovers p
q = poly([-2 0.5 4])       % build from roots
polyval(q, [-2 0.5 4])     % all zero
roots([1 0 4])             % x^2 + 4: complex roots +/- 2i

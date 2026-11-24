% Day 105 · Debugging, the Code Analyzer and Unit Testing — A test script with assert
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Each check compares with an answer we know is right
tol = 1e-12;
r = quadratic_roots(1, -3, 2);
assert(max(abs(r - [1 2])) < tol, 'distinct real roots');
r = quadratic_roots(1, 2, 1);
assert(max(abs(r - [-1 -1])) < tol, 'repeated root');
r = quadratic_roots(1, 0, 4);
assert(max(abs(sort(imag(r)) - [-2 2])) < tol && all(abs(real(r)) < tol), 'complex roots');
r = quadratic_roots(2, -4, -6);
assert(max(abs(polyval([2 -4 -6], r))) < tol, 'roots satisfy the equation');
threw = false;
try
    quadratic_roots(0, 1, 1);
catch ME
    threw = strcmp(ME.identifier, 'quadratic_roots:notQuadratic');
end
assert(threw, 'a = 0 must raise an error');
disp('All 5 tests passed.')

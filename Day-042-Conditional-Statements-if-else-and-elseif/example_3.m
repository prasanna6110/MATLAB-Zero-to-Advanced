% Day 042 · Conditional Statements: if, else and elseif — Classifying the roots of a quadratic
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

coeffs = [1 -2 5; 1 -5 6; 1 4 4];     % three equations a x^2 + b x + c = 0
for k = 1:3
    a = coeffs(k, 1); b = coeffs(k, 2); c = coeffs(k, 3);
    D = b^2 - 4*a*c;
    if D > 0
        r = (-b + [1 -1]*sqrt(D)) / (2*a);
        fprintf('Real distinct roots: %g and %g\n', r);
    elseif D == 0
        fprintf('One repeated root: %g\n', -b/(2*a));
    else
        re = -b/(2*a); im = sqrt(-D)/(2*a);
        fprintf('Complex roots: %g +/- %gi\n', re, im);
    end
end

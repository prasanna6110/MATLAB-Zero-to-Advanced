function r = quadratic_roots(a, b, c)
% QUADRATIC_ROOTS  Roots of a x^2 + b x + c = 0 (real or complex), sorted.
if a == 0
    error('quadratic_roots:notQuadratic', 'a must not be zero');
end
D = b^2 - 4*a*c;
r = sort([(-b + sqrt(D)) / (2*a), (-b - sqrt(D)) / (2*a)]);
end

% (Course file for Day 105 · Debugging, the Code Analyzer and Unit Testing)

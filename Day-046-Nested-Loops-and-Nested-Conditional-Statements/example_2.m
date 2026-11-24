% Day 046 · Nested Loops and Nested Conditional Statements — Building a matrix with conditions
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

n = 5;
A = zeros(n);
for r = 1:n
    for c = 1:n
        if r == c
            A(r, c) = 4;
        elseif abs(r - c) == 1
            A(r, c) = -1;
        end
    end
end
disp(A)                          % a tridiagonal matrix used in numerical methods

% Day 046 · Nested Loops and Nested Conditional Statements — A multiplication table in a matrix
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

n = 6;
T = zeros(n);
for r = 1:n
    for c = 1:n
        T(r, c) = r * c;
    end
end
disp(T)
isequal(T, (1:n)' * (1:n))     % the vectorised way

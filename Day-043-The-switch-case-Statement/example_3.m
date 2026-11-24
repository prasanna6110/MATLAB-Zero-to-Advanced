% Day 043 · The switch-case Statement — A small calculator menu
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

a = 18; b = 4;
ops = {'+', '-', '*', '/', '^', '%'};
for k = 1:numel(ops)
    op = ops{k};
    switch op
        case '+', r = a + b;
        case '-', r = a - b;
        case '*', r = a * b;
        case '/', r = a / b;
        case '^', r = a ^ b;
        otherwise
            fprintf('%s is not supported\n', op);
            continue
    end
    fprintf('%g %s %g = %g\n', a, op, b, r);
end

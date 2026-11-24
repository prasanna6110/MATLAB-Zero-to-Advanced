% Day 108 · Project 1: Scientific Calculator with a Menu — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear;
INTERACTIVE = false;                % true: type your own inputs
% Demo inputs: menu choice followed by the numbers each option needs
demo = {1, 12, '*', 7,   2, 2, 10,   3, 1000,   4, 30,   5, 6,   6, 1, -3, 2,   7, 100,   0};
state = struct('interactive', INTERACTIVE, 'demo', {demo}, 'pos', 1);
history = {};
while true
    fprintf('\n===== SCIENTIFIC CALCULATOR =====\n');
    fprintf(' 1) a op b      2) power x^n     3) logarithms\n');
    fprintf(' 4) trig (deg)  5) factorial     6) quadratic equation\n');
    fprintf(' 7) temperature conversion       0) exit\n');
    [choice, state] = next_input(state, 'Choice: ');
    switch choice
        case 1
            [a, state] = next_input(state, 'a = ');
            [op, state] = next_input(state, 'operator (+ - * /): ');
            [b, state] = next_input(state, 'b = ');
            switch op
                case '+', r = a + b;
                case '-', r = a - b;
                case '*', r = a * b;
                case '/'
                    if b == 0, disp('Cannot divide by zero'); continue; end
                    r = a / b;
                otherwise, disp('Unknown operator'); continue;
            end
            msg = sprintf('%g %s %g = %g', a, op, b, r);
        case 2
            [x, state] = next_input(state, 'x = ');
            [n, state] = next_input(state, 'n = ');
            msg = sprintf('%g^%g = %g', x, n, x^n);
        case 3
            [x, state] = next_input(state, 'x (> 0) = ');
            if x <= 0, disp('x must be positive'); continue; end
            msg = sprintf('ln(%g) = %.6f, log10 = %.6f, log2 = %.6f', x, log(x), log10(x), log2(x));
        case 4
            [d, state] = next_input(state, 'angle in degrees = ');
            msg = sprintf('sin %g = %.4f, cos %g = %.4f, tan %g = %.4f', d, sind(d), d, cosd(d), d, tand(d));
        case 5
            [n, state] = next_input(state, 'n = ');
            if n < 0 || n ~= fix(n), disp('n must be a non-negative integer'); continue; end
            msg = sprintf('%d! = %d', n, factorial(n));
        case 6
            [a, state] = next_input(state, 'a = ');
            [b, state] = next_input(state, 'b = ');
            [c, state] = next_input(state, 'c = ');
            msg = solve_quadratic(a, b, c);
        case 7
            [c, state] = next_input(state, 'temperature in C = ');
            msg = sprintf('%g C = %g F = %g K', c, c*9/5 + 32, c + 273.15);
        case 0
            break
        otherwise
            disp('Invalid choice'); continue
    end
    fprintf('>> %s\n', msg);
    history{end + 1} = msg;
end
fprintf('\n===== HISTORY (%d results) =====\n', numel(history));
rows = [num2cell(1:numel(history)); history];
fprintf('%2d. %s\n', rows{:});

function [val, state] = next_input(state, prompt)
    if state.interactive
        txt = input(prompt, 's');
        num = str2double(txt);
        if isnan(num), val = strtrim(txt); else, val = num; end
    else
        val = state.demo{state.pos};
        state.pos = state.pos + 1;
        if ischar(val), fprintf('%s%s\n', prompt, val); else, fprintf('%s%g\n', prompt, val); end
    end
end

function msg = solve_quadratic(a, b, c)
    if a == 0
        msg = sprintf('Linear equation: x = %g', -c/b);
        return
    end
    D = b^2 - 4*a*c;
    if D >= 0
        r = (-b + [1 -1]*sqrt(D)) / (2*a);
        msg = sprintf('Real roots: x1 = %g, x2 = %g', r);
    else
        msg = sprintf('Complex roots: %g +/- %gi', -b/(2*a), sqrt(-D)/(2*a));
    end
end

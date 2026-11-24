% Day 083 · Symbolic Objects and Symbolic Expressions — Symbolic functions and substitution
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Symbolic Math Toolbox
syms f(x) t
f(x) = x^3 - 2*x + 1;
f(2)                        % exact value
f(t + 1)                    % substitute an expression
syms V0 tau
v = V0 * (1 - exp(-t/tau));
v_at_tau = subs(v, t, tau)  % value at t = tau
num = subs(v, [V0 tau t], [12 0.5 1])
double(num)                 % convert to an ordinary number

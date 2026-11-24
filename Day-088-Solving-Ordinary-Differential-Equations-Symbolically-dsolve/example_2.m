% Day 088 · Solving Ordinary Differential Equations Symbolically: dsolve — Second-order ODE: an RLC circuit
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Symbolic Math Toolbox
syms q(t)
Dq = diff(q, t);
R = 6; L = 1; C = sym(1)/25; V = 10;              % numbers chosen for a neat answer
ode = L*diff(q, t, 2) + R*Dq + q/C == V;
qs = dsolve(ode, [q(0) == 0, Dq(0) == 0]);
i_t = simplify(diff(qs, t))
vC = simplify(qs / C)
fh = matlabFunction(vC);
fprintf('vC at t = 0.5 s: %.4f V (final value %d V)\n', fh(0.5), V);

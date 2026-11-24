% Day 076 · Systems of Nonlinear Equations: fsolve and Newton-Raphson — Operating point of a nonlinear circuit
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% A 5 V source, 1 kohm resistor and a diode in series, with a 2 kohm load across the diode.
% Unknowns: node voltage Vd and diode current Id.
Is = 1e-12; VT = 0.02585;
F = @(u) [ (5 - u(1))/1000 - u(2) - u(1)/2000;      % KCL at the node
           u(2) - Is*(exp(u(1)/VT) - 1) ];          % the diode equation
u = [0.6; 1e-3];
for k = 1:50                                        % Newton with a numerical Jacobian
    Fu = F(u); Jn = zeros(2);
    for j = 1:2
        du = zeros(2, 1); du(j) = 1e-8 * max(1, abs(u(j)));
        Jn(:, j) = (F(u + du) - Fu) / du(j);
    end
    step = -Jn \ Fu;
    u = u + step;
    if norm(step) < 1e-14, break; end
end
fprintf('Vd = %.4f V, Id = %.4f mA after %d iterations\n', u(1), u(2)*1000, k);

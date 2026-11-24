% Day 125 · Project 18: Heat Conduction in a Plate (Finite Differences) — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
n = 40;                                       % inside points per side
Ttop = 100; Tbottom = 0; Tleft = 75; Tright = 50;
% ---- (a) SOR iteration ----
T = zeros(n + 2);
T(1, :) = Ttop; T(end, :) = Tbottom; T(:, 1) = Tleft; T(:, end) = Tright;
T(1, 1) = (Ttop + Tleft)/2; T(1, end) = (Ttop + Tright)/2; T(end, 1) = (Tbottom + Tleft)/2; T(end, end) = (Tbottom + Tright)/2;
w = 2/(1 + sin(pi/(n + 1)));                 % the optimal over-relaxation factor
tic
for iter = 1:5000
    change = 0;
    for i = 2:n + 1
        for j = 2:n + 1
            new = (T(i+1, j) + T(i-1, j) + T(i, j+1) + T(i, j-1))/4;
            delta = w*(new - T(i, j));
            T(i, j) = T(i, j) + delta;
            change = max(change, abs(delta));
        end
    end
    if change < 1e-6, break; end
end
t_sor = toc;
% ---- (b) one sparse linear system ----
tic
e = ones(n, 1);
D = spdiags([e -2*e e], -1:1, n, n);
A = kron(speye(n), D) + kron(D, speye(n));   % the 2-D Laplacian
b = zeros(n);                                % move the known boundary values to the right side
b(1, :) = b(1, :) - Ttop;  b(end, :) = b(end, :) - Tbottom;
b(:, 1) = b(:, 1) - Tleft; b(:, end) = b(:, end) - Tright;
Tin = reshape(A \ b(:), n, n);
t_sparse = toc;
fprintf('SOR: %d iterations, %.3f s | sparse direct: %.3f s | max difference %.2e C\n', iter, t_sor, t_sparse, max(max(abs(Tin - T(2:end-1, 2:end-1)))));
fprintf('Centre temperature: %.3f C (by symmetry of the equation it is the mean of the edges, %.2f C)\n', Tin(n/2, n/2)/2 + Tin(n/2 + 1, n/2 + 1)/2, mean([Ttop Tbottom Tleft Tright]));
subplot(1, 2, 1); contourf(T, 20); axis ij equal tight; colorbar; title('Steady state (C)')
% ---- (c) transient heating of a cold plate ----
alpha = 1.1e-4; L = 0.4; h = L/(n + 1);
dt = 0.2*h^2/alpha;                           % below the stability limit 0.25
r = alpha*dt/h^2;
U = zeros(n + 2); U(1, :) = Ttop; U(end, :) = Tbottom; U(:, 1) = Tleft; U(:, end) = Tright;
centre = zeros(1, 4000);
for k = 1:4000
    U(2:end-1, 2:end-1) = U(2:end-1, 2:end-1) + r*(U(3:end, 2:end-1) + U(1:end-2, 2:end-1) + U(2:end-1, 3:end) + U(2:end-1, 1:end-2) - 4*U(2:end-1, 2:end-1));
    centre(k) = U(n/2 + 1, n/2 + 1);
end
fprintf('Transient: r = %.2f, after %.0f s the centre is at %.2f C\n', r, 4000*dt, centre(end));
subplot(1, 2, 2); plot((1:4000)*dt, centre); grid on; xlabel('t (s)'); ylabel('T centre (C)'); title('Heating of the centre')

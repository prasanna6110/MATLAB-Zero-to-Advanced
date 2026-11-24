% Day 075 · Systems of ODEs and Higher-Order ODEs — A predator-prey model with a parameter structure
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

p = struct('a', 1.0, 'b', 0.1, 'c', 1.5, 'd', 0.075);
[t, Y] = ode45(@(t, y) predator_prey(t, y, p), [0 30], [40; 9]);
subplot(1, 2, 1); plot(t, Y); legend('prey', 'predators'); xlabel('time'); grid on
subplot(1, 2, 2); plot(Y(:, 1), Y(:, 2)); xlabel('prey'); ylabel('predators'); title('Phase plane'); grid on
fprintf('Prey ranges from %.1f to %.1f\n', min(Y(:, 1)), max(Y(:, 1)));

function dy = predator_prey(~, y, p)
    dy = zeros(2, 1);
    dy(1) = p.a*y(1) - p.b*y(1)*y(2);
    dy(2) = -p.c*y(2) + p.d*y(1)*y(2);
end

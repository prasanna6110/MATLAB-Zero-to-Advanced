% Day 075 · Systems of ODEs and Higher-Order ODEs — A stiff problem: ode45 vs ode15s
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% A fast mode (rate 1000) and a slow mode (rate 1)
f = @(t, y) [-1000*y(1) + 999*y(2); -y(2)];
tic; [t1, ~] = ode45(f, [0 5], [2; 1]); time45 = toc;
tic; [t2, Y2] = ode15s(f, [0 5], [2; 1]); time15 = toc;
fprintf('ode45 : %5d steps, %.3f s\n', numel(t1), time45);
fprintf('ode15s: %5d steps, %.3f s\n', numel(t2), time15);
fprintf('y(5) = [%.5f %.5f], exact exp(-5) = %.5f\n', Y2(end, :), exp(-5));

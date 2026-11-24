% Day 098 · Control Systems 1: Transfer Functions, Poles and Step Response — Combining blocks: series, feedback and stability
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Control System Toolbox
s = tf('s');
plant = 1 / (s*(s + 2)*(s + 5));
for K = [10 40 65 100]                      % theory (Routh): stable only for K < 70
    T = feedback(K*plant, 1);
    p = pole(T);
    if all(real(p) < 0), state = 'stable'; else, state = 'UNSTABLE'; end
    fprintf('K = %3d: poles %s -> %s\n', K, mat2str(p.', 3), state);
end
T = feedback(40*plant, 1);
[y, t] = step(T, 10);
plot(t, y); grid on; title('Closed loop with K = 40')

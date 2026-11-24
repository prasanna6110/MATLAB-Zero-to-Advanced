% Day 126 · Project 19: Epidemic Spread Model (SIR) with Vaccination — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
N = 1e6; I0 = 10;
gamma = 1/7;                                   % 7 days infectious
scenarios = struct('name', {'R0 = 2.5', 'R0 = 1.8', 'distancing from day 40', 'vaccination 0.5%/day'}, ...
                   'R0', {2.5, 1.8, 2.5, 2.5}, 'dist', {false, false, true, false}, 'vacc', {0, 0, 0, 0.005});
tspan = 0:1:300;
fprintf('%-24s %12s %10s %14s\n', 'Scenario', 'Peak infected', 'Peak day', 'Total infected');
colors = lines(numel(scenarios));
for k = 1:numel(scenarios)
    sc = scenarios(k);
    beta0 = sc.R0 * gamma;
    beta = @(t) beta0 * (1 - 0.45*(sc.dist && t >= 40));
    f = @(t, y) [-beta(t)*y(1)*y(2)/N - sc.vacc*y(1);
                  beta(t)*y(1)*y(2)/N - gamma*y(2);
                  gamma*y(2) + sc.vacc*y(1)];
    [t, Y] = ode45(f, tspan, [N - I0; I0; 0], odeset('MaxStep', 1));
    [pk, kp] = max(Y(:, 2));
    infected_total = trapz(t, gamma*Y(:, 2)) + I0;
    fprintf('%-24s %12.0f %10d %13.1f%%\n', sc.name, pk, t(kp), 100*infected_total/N);
    plot(t, Y(:, 2)/N*100, 'Color', colors(k, :), 'LineWidth', 1.5); hold on
end
hold off; grid on; xlabel('Day'); ylabel('Infected (% of population)'); legend({scenarios.name}); title('SIR scenarios')
for R0 = [1.5 2.5 3.5 6]
    fprintf('R0 = %.1f -> herd immunity threshold %.0f %%\n', R0, 100*(1 - 1/R0));
end

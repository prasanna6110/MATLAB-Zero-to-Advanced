# Day 126 · Project 19: Epidemic Spread Model (SIR) with Vaccination

_Projects_

## Goal
Model the spread of an infectious disease with the **SIR** model, find the **peak** of infections and its day, explore the effect of the **reproduction number R₀**, **social distancing** (lower contact rate after a trigger) and **vaccination**, and estimate the **herd-immunity** threshold.

## Model
- dS/dt = -β S I / N - v S (vaccination rate v)
- dI/dt = β S I / N - γ I
- dR/dt = γ I + v S
with R₀ = β/γ. Herd immunity when the immune fraction exceeds 1 - 1/R₀.

## Concepts used
`ode45` with a parameter structure, time-dependent parameters, comparing scenarios in a loop, `trapz`, multiple plots.

## Code

### Full program  ([`main.m`](main.m))

```matlab
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
```

## Extend this project

- Add an "Exposed" group (SEIR model) with a 5-day incubation period.
- Fit β and γ to a set of daily case numbers with `fminsearch`.
- Model hospital capacity and find the distancing level that keeps the peak below it.
- Add waning immunity (R flows back to S) and look for repeated waves.

---

[⬅ Day 125](../Day-125-Project-18-Heat-Conduction-in-a-Plate-Finite-Differences/README.md) · [🏠 Home](../README.md) · [Day 127 ➡](../Day-127-Project-20-Experimental-Data-Analysis-and-Automatic-Report/README.md)

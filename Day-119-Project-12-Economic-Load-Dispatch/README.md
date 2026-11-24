# Day 119 · Project 12: Economic Load Dispatch

_Projects_

## Goal
Share a total demand between thermal generators so that the **total fuel cost is minimum**, respecting each unit's minimum and maximum output. Then add **transmission losses** with a simple loss formula, and draw the cost of meeting demands across the day.

## Theory
Each unit has a quadratic cost: Cᵢ(Pᵢ) = aᵢ + bᵢPᵢ + cᵢPᵢ² (Rs/h).
At the optimum every unit runs at the **same incremental cost λ**:
dCᵢ/dPᵢ = bᵢ + 2cᵢPᵢ = λ → Pᵢ = (λ - bᵢ)/(2cᵢ), clipped to [Pmin, Pmax].

**Lambda iteration**: adjust λ (by bisection) until ΣPᵢ = demand (+ losses).

With losses PL = Σ Bᵢ Pᵢ², the condition becomes (bᵢ + 2cᵢPᵢ) = λ(1 - 2BᵢPᵢ) (penalty factors).

## Concepts used
Vectorised formulas, bisection (`while`), `min`/`max` clipping, verification with `fmincon`-free brute force, plots of the daily dispatch.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
gen = struct('name', {'Unit A', 'Unit B', 'Unit C'}, ...
             'a', {500, 400, 200}, 'b', {5.3, 5.5, 5.8}, 'c', {0.004, 0.006, 0.009}, ...
             'Pmin', {200, 150, 100}, 'Pmax', {450, 350, 225});
b = [gen.b]; c = [gen.c]; a = [gen.a]; Pmin = [gen.Pmin]; Pmax = [gen.Pmax];
B = [0.00003 0.00009 0.00012];                 % loss coefficients (1/MW)
demand = 800;
[P, lambda] = dispatch(demand, a, b, c, Pmin, Pmax, zeros(1, 3));
fprintf('Without losses, demand %d MW: lambda = %.4f Rs/MWh\n', demand, lambda);
print_table(gen, P, a, b, c);
[PL_P, lambdaL, PL] = dispatch(demand, a, b, c, Pmin, Pmax, B);
fprintf('\nWith losses: lambda = %.4f, losses %.2f MW, generation %.2f MW\n', lambdaL, PL, sum(PL_P));
print_table(gen, PL_P, a, b, c);
% Check: equal sharing would cost more
P_equal = min(max(demand/3*ones(1, 3), Pmin), Pmax);
P_equal(1) = demand - sum(P_equal(2:3));
fprintf('\nCost of the optimal dispatch %.0f Rs/h vs a simple split %.0f Rs/h\n', sum(a + b.*P + c.*P.^2), sum(a + b.*P_equal + c.*P_equal.^2));
% A day of demands
h = 0:23;
D = 600 + 350*exp(-(h - 19).^2/10) + 150*exp(-(h - 11).^2/8);
Pday = zeros(24, 3); cost = zeros(1, 24);
for k = 1:24
    Pday(k, :) = dispatch(D(k), a, b, c, Pmin, Pmax, zeros(1, 3));
    cost(k) = sum(a + b.*Pday(k, :) + c.*Pday(k, :).^2);
end
fprintf('Daily fuel cost: Rs %.2f lakh\n', sum(cost)/1e5);
subplot(2, 1, 1); area(h, Pday); legend({gen.name}, 'Location', 'northwest'); ylabel('MW'); title('Economic dispatch over a day')
subplot(2, 1, 2); plot(h, cost/1000, 'k-o'); ylabel('Cost (thousand Rs/h)'); xlabel('Hour'); grid on

function [P, lambda, PL] = dispatch(demand, ~, b, c, Pmin, Pmax, B)
    lo = 0; hi = 50;
    for it = 1:200
        lambda = (lo + hi)/2;
        P = (lambda - b) ./ (2*c + 2*lambda*B);       % includes the loss penalty factor
        P = min(max(P, Pmin), Pmax);
        PL = sum(B .* P.^2);
        if sum(P) - PL > demand, hi = lambda; else, lo = lambda; end
        if hi - lo < 1e-10, break; end
    end
end

function print_table(gen, P, a, b, c)
    fprintf('%-8s %9s %12s %14s\n', 'Unit', 'P (MW)', 'Cost (Rs/h)', 'dC/dP (Rs/MWh)');
    for i = 1:numel(P)
        fprintf('%-8s %9.2f %12.2f %14.4f\n', gen(i).name, P(i), a(i) + b(i)*P(i) + c(i)*P(i)^2, b(i) + 2*c(i)*P(i));
    end
    fprintf('%-8s %9.2f %12.2f\n', 'Total', sum(P), sum(a + b.*P + c.*P.^2));
end
```

## Extend this project

- Add a fourth unit and a demand that forces one unit to its maximum.
- Include a valve-point effect term and solve with `fminsearch` instead.
- Add unit commitment: switch off the most expensive unit when the demand is low.
- Combine with Project 10: schedule a battery to reduce the evening peak cost.

---

[⬅ Day 118](../Day-118-Project-11-Load-Flow-Analysis-by-the-Gauss-Seidel-Method/README.md) · [🏠 Home](../README.md) · [Day 120 ➡](../Day-120-Project-13-Transmission-Line-Performance-Calculator/README.md)

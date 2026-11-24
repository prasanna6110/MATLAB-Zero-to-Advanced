# Day 111 · Project 4: Electricity Bill Generator with Slab and Time-of-Day Tariffs

_Projects_

## Goal
Generate monthly electricity bills for domestic and commercial consumers using **slab tariffs**, a fixed charge by connected load, electricity duty, and an optional **time-of-day (ToD)** tariff from 24-hour metered data. Compare the bills and show where the money goes.

## Concepts used
Functions with structures, slab calculation with `min`/`max`, vectorised ToD pricing with logical indexing, formatted bills with `fprintf`, `bar` (stacked) and `stairs` plots.

## How it works
1. A tariff is a structure: slab limits, slab rates, fixed charge per kW and the duty percentage.
2. `slab_energy_charge` walks through the slabs: the units in each slab are `min(units, upper) - lower`.
3. For ToD, each hour's energy is multiplied by that hour's rate.
4. `print_bill` prints an itemised bill.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
domestic.name = 'Domestic';
domestic.limits = [0 100 200 400 Inf];         % slab boundaries in units (kWh)
domestic.rates = [3.50 4.50 6.00 7.50];        % Rs per unit in each slab
domestic.fixed_per_kW = 40;  domestic.duty = 0.05;
commercial.name = 'Commercial';
commercial.limits = [0 200 Inf];
commercial.rates = [7.00 8.50];
commercial.fixed_per_kW = 120;  commercial.duty = 0.09;
consumers = struct('name', {'R. Sharma', 'P. Verma', 'City Bakery'}, ...
                   'units', {85, 365, 1240}, 'load_kW', {2, 5, 15}, 'tariff', {domestic, domestic, commercial});
totals = zeros(numel(consumers), 3);
for k = 1:numel(consumers)
    b = make_bill(consumers(k));
    print_bill(consumers(k), b);
    totals(k, :) = [b.energy b.fixed b.duty];
end
% ---- time-of-day comparison for the bakery ----
hours = 0:23;
profile = [8 8 8 8 10 30 60 75 70 60 55 55 50 50 55 60 70 80 85 75 50 30 15 10];
profile = profile / sum(profile) * consumers(3).units / 30;     % kWh per hour, one day
tod_rate = 8.0 * ones(1, 24);
tod_rate(hours >= 22 | hours < 6) = 6.0;                         % off-peak
tod_rate(hours >= 17 & hours < 22) = 10.5;                       % peak
tod_daily = sum(profile .* tod_rate);
fprintf('\nTime-of-day: the bakery would pay Rs %.2f per day (Rs %.2f per 30 days) for energy\n', tod_daily, 30*tod_daily);
shift = profile;  move = 0.3 * shift(hours >= 17 & hours < 22);  % shift 30% of the peak use to the night
shift(hours >= 17 & hours < 22) = shift(hours >= 17 & hours < 22) - move;
shift(hours >= 0 & hours < 5) = shift(hours >= 0 & hours < 5) + sum(move)/5;
fprintf('Shifting 30%% of the peak use to 0-5 h saves Rs %.2f per month\n', 30*(tod_daily - sum(shift .* tod_rate)));
subplot(1, 2, 1); bar(totals, 'stacked'); legend('energy', 'fixed', 'duty', 'Location', 'northwest')
set(gca, 'XTickLabel', {consumers.name}); ylabel('Rs'); title('Bill breakdown')
subplot(1, 2, 2); yyaxis_like(hours, profile, tod_rate)

function b = make_bill(c)
    t = c.tariff;
    b.energy = slab_energy_charge(c.units, t.limits, t.rates);
    b.fixed = t.fixed_per_kW * c.load_kW;
    b.duty = t.duty * b.energy;
    b.total = b.energy + b.fixed + b.duty;
end

function cost = slab_energy_charge(units, limits, rates)
    cost = 0;
    for s = 1:numel(rates)
        in_slab = max(0, min(units, limits(s + 1)) - limits(s));
        cost = cost + in_slab * rates(s);
    end
end

function print_bill(c, b)
    fprintf('\n------------------------------------------\n');
    fprintf(' Consumer : %-20s (%s)\n', c.name, c.tariff.name);
    fprintf(' Units    : %d kWh, connected load %g kW\n', c.units, c.load_kW);
    fprintf(' Energy charge          Rs %10.2f\n', b.energy);
    fprintf(' Fixed charge           Rs %10.2f\n', b.fixed);
    fprintf(' Electricity duty       Rs %10.2f\n', b.duty);
    fprintf(' TOTAL PAYABLE          Rs %10.2f\n', b.total);
    fprintf(' Average rate           Rs %10.2f per unit\n', b.total / c.units);
end

function yyaxis_like(hours, profile, rate)
    stairs(hours, rate * max(profile) / max(rate), 'r', 'LineWidth', 1.5); hold on
    bar(hours, profile, 0.6); hold off
    xlabel('Hour'); title('Bakery load (bars) and scaled ToD rate (red)'); xlim([-0.5 23.5])
end
```

## Extend this project

- Add a subsidy for the first 50 units for consumers using less than 100 units.
- Read meter readings (previous and current) from a CSV and print bills for all consumers.
- Add a late-payment surcharge of 2% per month.
- Compute the break-even point where a commercial ToD tariff becomes cheaper than the flat one.

---

[⬅ Day 110](../Day-110-Project-3-Smart-Unit-Converter/README.md) · [🏠 Home](../README.md) · [Day 112 ➡](../Day-112-Project-5-DC-Circuit-Solver-using-Nodal-Analysis/README.md)

# Day 110 · Project 3: Smart Unit Converter

_Projects_

## Goal
Convert between units of length, mass, temperature, energy, power, pressure and data size, with any unit to any unit in the same category, plus a full conversion table.

## Concepts used
`containers.Map` (unit → factor to the base unit), nested structures, `switch` for the non-linear temperature case, functions, error handling.

## How it works
1. Each category stores factors that convert **to its base unit** (metre, kilogram, joule, watt, pascal, byte).
2. To convert x from unit A to unit B: `x * factor(A) / factor(B)`.
3. Temperature is not a simple factor (it has an offset), so it goes through Celsius with its own formulas.
4. Unknown units or mixed categories raise a clear error.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear;
U = build_units();
requests = {
    5,       'km',   'mile'
    72,      'km/h', 'm/s'
    1,       'kWh',  'MJ'
    100,     'F',    'C'
    1,       'hp',   'kW'
    1,       'atm',  'bar'
    2.5,     'GB',   'MB'
    1,       'tonne','lb'
    300,     'K',    'F'
    10,      'kg',   'm'          % an invalid request: different categories
    };
for k = 1:size(requests, 1)
    [x, from, to] = requests{k, :};
    try
        y = convert_unit(U, x, from, to);
        fprintf('%10g %-6s = %12.6g %s\n', x, from, y, to);
    catch ME
        fprintf('%10g %-6s -> %-6s : %s\n', x, from, to, ME.message);
    end
end
% A conversion table for one category
category = 'power';
names = keys(U.(category));
fprintf('\n1 unit of ... in each %s unit\n%8s', category, '');
fprintf('%11s', names{:}); fprintf('\n');
for i = 1:numel(names)
    fprintf('%8s', names{i});
    for j = 1:numel(names)
        fprintf('%11.4g', convert_unit(U, 1, names{i}, names{j}));
    end
    fprintf('\n');
end

function U = build_units()
    U.length   = containers.Map({'mm', 'cm', 'm', 'km', 'inch', 'ft', 'yard', 'mile'}, ...
                                {1e-3, 1e-2, 1, 1e3, 0.0254, 0.3048, 0.9144, 1609.344});
    U.speed    = containers.Map({'m/s', 'km/h', 'mph', 'knot'}, {1, 1/3.6, 0.44704, 0.514444});
    U.mass     = containers.Map({'g', 'kg', 'tonne', 'lb', 'oz'}, {1e-3, 1, 1000, 0.45359237, 0.0283495});
    U.energy   = containers.Map({'J', 'kJ', 'MJ', 'Wh', 'kWh', 'cal', 'kcal'}, {1, 1e3, 1e6, 3600, 3.6e6, 4.184, 4184});
    U.power    = containers.Map({'W', 'kW', 'MW', 'hp'}, {1, 1e3, 1e6, 745.7});
    U.pressure = containers.Map({'Pa', 'kPa', 'bar', 'atm', 'psi'}, {1, 1e3, 1e5, 101325, 6894.76});
    U.data     = containers.Map({'B', 'KB', 'MB', 'GB', 'TB'}, {1, 1024, 1024^2, 1024^3, 1024^4});
end

function y = convert_unit(U, x, from, to)
    temps = {'C', 'F', 'K'};
    if any(strcmp(from, temps)) && any(strcmp(to, temps))
        switch from                         % first to Celsius
            case 'C', c = x;
            case 'F', c = (x - 32) * 5/9;
            case 'K', c = x - 273.15;
        end
        switch to
            case 'C', y = c;
            case 'F', y = c * 9/5 + 32;
            case 'K', y = c + 273.15;
        end
        return
    end
    cats = fieldnames(U);
    for k = 1:numel(cats)
        m = U.(cats{k});
        if isKey(m, from) && isKey(m, to)
            y = x * m(from) / m(to);
            return
        end
    end
    error('cannot convert "%s" to "%s" (unknown unit or different quantities)', from, to);
end
```

## Extend this project

- Add area and volume categories (m², acre, hectare; litre, gallon).
- Make an interactive version that asks for the value and the two units.
- Add currency conversion with rates read from a text file.
- Print every conversion with the formula used.

---

[⬅ Day 109](../Day-109-Project-2-Student-Result-Management-System/README.md) · [🏠 Home](../README.md) · [Day 111 ➡](../Day-111-Project-4-Electricity-Bill-Generator-with-Slab-and-Time-of-Day-Tariffs/README.md)

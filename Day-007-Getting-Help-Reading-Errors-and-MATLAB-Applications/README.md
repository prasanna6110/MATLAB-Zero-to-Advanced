# Day 007 · Getting Help, Reading Errors and MATLAB Applications

_Getting Started_

## Getting help
| Command | Use |
|---------|-----|
| `help sqrt` | a short help text in the Command Window |
| `doc sqrt` | the full documentation page with examples |
| `lookfor keyword` | searches the first help line of every function |
| **F1** | help for the function under the cursor |
| **Tab** | auto-completes variable and function names |
| Function hints | type `plot(` and pause: MATLAB shows the possible inputs |

## Reading error messages
MATLAB errors are red and tell you **what** went wrong and **on which line**. The most common ones:

| Message | Usual cause |
|---------|-------------|
| `Unrecognized function or variable 'x'` | typo, variable not created yet, or file not in the current folder |
| `Incorrect dimensions for matrix multiplication` | used `*` where `.*` was meant, or the sizes do not match |
| `Index exceeds the number of array elements` | asked for element 6 of a 5-element vector |
| `Array indices must be positive integers or logical values` | `x(0)` or `x(1.5)`: indices start at **1** |
| `Arrays have incompatible sizes for this operation` | adding a 3-element vector to a 4-element vector |
| `Invalid expression` / `Parse error` | missing bracket, quote or operator |

## Examples of MATLAB applications
Most real problems follow the same pattern: **inputs → formula → output**. Write the inputs as variables at the top, so you can change them and run again.

## Examples

### Example 1: Catching and reading common errors  ([`example_1.m`](example_1.m))

```matlab
% try/catch lets a script continue after an error (covered fully later)
try
    v = [1 2 3];
    v(5)                         % index too large
catch err
    disp(['Caught: ' err.message])
end
try
    a = [1 2 3]; b = [4 5 6];
    a * b                        % matrix multiplication needs inner dims to match
catch err
    disp(['Caught: ' err.message])
end
try
    a .* b                       % element-wise multiplication works
catch err
    disp(err.message)
end
```

### Example 2: Application: the cost of running a pump  ([`example_2.m`](example_2.m))

```matlab
% A 7.5 kW pump runs 6 h a day. Efficiency 88%. Tariff Rs 8.10 per kWh.
P_out = 7.5;                 % kW of mechanical output
eta = 0.88;
P_in = P_out / eta;          % electrical input
energy_month = P_in * 6 * 30;
bill = energy_month * 8.10;
fprintf('Input power        : %.2f kW\n', P_in);
fprintf('Energy per month   : %.1f kWh\n', energy_month);
fprintf('Monthly bill       : Rs %.0f\n', bill);
```

### Example 3: Application: the projectile range formula  ([`example_3.m`](example_3.m))

```matlab
v0 = 25;                      % launch speed m/s
theta = 40;                   % launch angle in degrees
g = 9.81;
range = v0^2 * sind(2 * theta) / g;
h_max = (v0 * sind(theta))^2 / (2 * g);
t_flight = 2 * v0 * sind(theta) / g;
fprintf('Range %.2f m, max height %.2f m, flight time %.2f s\n', range, h_max, t_flight);
```

## Practice

1. Use `lookfor logarithm` to find all functions about logarithms.
2. Open `doc fprintf` and read one example.
3. Create each error from the table on purpose, read the message, then fix it.
4. Write a script for the voltage drop in a 200 m copper cable (ρ = 1.72e-8 Ω·m, area 10 mm², current 40 A).

---

[⬅ Day 006](../Day-006-Script-Files-Sections-and-the-Current-Folder/README.md) · [🏠 Home](../README.md) · [Day 008 ➡](../Day-008-Creating-Vectors-Row-Column-Colon-and-linspace/README.md)

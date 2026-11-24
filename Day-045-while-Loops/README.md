# Day 045 · while Loops

_Programming in MATLAB_

## Syntax
```matlab
while condition
    commands
end
```
- The commands repeat **as long as the condition is true**.
- Use `while` when you **do not know in advance** how many times to repeat: iterate until an error is small, until the user types "quit", until a tank is full.
- Something inside the loop **must change** the condition, otherwise you get an **infinite loop**. Stop a runaway loop with **Ctrl+C**.
- A safety counter (`iter < maxIter`) is good practice.

## for vs while
| Use `for` | Use `while` |
|-----------|-------------|
| known number of repetitions | repeat until a condition |
| iterate over a vector or list | convergence, user input, events |

## Examples

### Example 1: Square root by repeated averaging  ([`example_1.m`](example_1.m))

```matlab
a = 50;                    % find sqrt(a)
x = a;                     % first guess
iter = 0;
while abs(x^2 - a) > 1e-10 && iter < 100
    x = (x + a/x) / 2;     % average of x and a/x
    iter = iter + 1;
    fprintf('iteration %d: x = %.12f\n', iter, x);
end
fprintf('sqrt(%d) = %.10f (built-in %.10f)\n', a, x, sqrt(a));
```

### Example 2: How many years to double an investment?  ([`example_2.m`](example_2.m))

```matlab
balance = 10000;
rate = 0.072;
years = 0;
while balance < 20000
    balance = balance * (1 + rate);
    years = years + 1;
end
fprintf('It takes %d years (balance Rs %.2f)\n', years, balance);
fprintf('Rule of 72 estimate: %.1f years\n', 72 / (rate*100));
```

### Example 3: Charging a battery until it is full  ([`example_3.m`](example_3.m))

```matlab
soc = 20;          % state of charge, %
capacity_kWh = 10;
P_charge = 2.2;    % kW
eff = 0.95;
hour = 0;
while soc < 100
    added = P_charge * eff / capacity_kWh * 100;   % % per hour
    soc = min(100, soc + added);
    hour = hour + 1;
    fprintf('Hour %d: SOC = %.1f %%\n', hour, soc);
end
```

## Practice

1. Find the smallest n such that 1 + 2 + … + n > 1000.
2. Keep halving a number until it is less than 0.001. Count the steps.
3. Use a while loop to find the first Fibonacci number greater than 10 000.
4. Write a loop that asks the user for numbers until they enter 0, then prints the sum.

---

[⬅ Day 044](../Day-044-for-Loops/README.md) · [🏠 Home](../README.md) · [Day 046 ➡](../Day-046-Nested-Loops-and-Nested-Conditional-Statements/README.md)

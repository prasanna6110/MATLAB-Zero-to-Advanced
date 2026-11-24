# Day 056 · Subfunctions and Nested Functions

_User-Defined Functions_

## Subfunctions (local functions in a function file)
A function file can contain **several functions**. The **first** is the **main function** (callable from outside, by the file name). The others are **subfunctions**: only the functions in that file can call them.
```matlab
function out = main_fn(x)
    out = helper(x) + 1;
end

function y = helper(x)       % visible only inside this file
    y = 2 * x;
end
```
Each subfunction has its own workspace, like any function.

## Nested functions
A **nested function** is written **inside** another function, before the parent's `end`. Every function in the file must then end with `end`.
- A nested function **can see and change the parent's variables** directly (they share the workspace).
- Useful for callbacks in GUIs and for functions that need many shared parameters.
```matlab
function total = parent(a)
    b = 10;
    child();                 % child can use and change a and b
    total = b;
    function child()
        b = b + a;
    end
end
```

## Examples

### The file motor_report.m with subfunctions  ([`motor_report.m`](motor_report.m))

```matlab
function report = motor_report(P_out_kW, V, pf, eta)
% MOTOR_REPORT  Input current, losses and a text summary for a 3-phase motor.
P_in = input_power(P_out_kW, eta);
I = line_current(P_in, V, pf);
report = sprintf('Pout %.1f kW, Pin %.2f kW, losses %.2f kW, I_line %.2f A', ...
                 P_out_kW, P_in, P_in - P_out_kW, I);
end

function P_in = input_power(P_out, eta)       % subfunction
P_in = P_out / eta;
end

function I = line_current(P_in_kW, V_line, pf) % subfunction
I = P_in_kW * 1000 / (sqrt(3) * V_line * pf);
end
```

### The file running_account.m with a nested function  ([`running_account.m`](running_account.m))

```matlab
function balance = running_account(start, deposits, rate)
% RUNNING_ACCOUNT  Balance after a list of yearly deposits, with interest.
balance = start;
for d = deposits
    add_interest();           % the nested function changes 'balance' directly
    balance = balance + d;
end

    function add_interest()
        balance = balance * (1 + rate);
    end
end
```

### Example 1: Using subfunctions and nested functions  ([`example_1.m`](example_1.m))

```matlab
disp(motor_report(15, 415, 0.85, 0.9))
disp(motor_report(55, 415, 0.88, 0.93))
b = running_account(1000, [500 500 500], 0.1);
fprintf('Balance: %.2f\n', b);
try
    input_power(10, 0.9)        % a subfunction cannot be called from outside
catch ME
    disp('input_power is not visible outside motor_report.m')
end
```

## Practice

1. Write a function file `triangle_info.m` whose main function returns the area and perimeter, using two subfunctions.
2. Write a nested function that increments a counter variable of its parent each time it is called.
3. What is the difference in variable visibility between a subfunction and a nested function?
4. Why must every function in a file with nested functions end with `end`?

---

[⬅ Day 055](../Day-055-Function-Handles-and-Function-Functions-feval/README.md) · [🏠 Home](../README.md) · [Day 057 ➡](../Day-057-Recursion/README.md)

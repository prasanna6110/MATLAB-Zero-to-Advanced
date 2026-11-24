# Day 026 · The Workspace and Input to a Script File

_Scripts and Data_

## The MATLAB workspace
The **base workspace** holds the variables created in the Command Window **and** by script files. A script shares this workspace, so:
- a script can use variables that already exist in the workspace
- variables the script creates are still there after it ends

(Functions have their **own** private workspace, Day 52.)

## Three ways to give a script its inputs
1. **Assign them in the script**: `R = 220;`. Change and re-run. Best for most work.
2. **Assign them in the Command Window first**, then run the script (the script just uses them).
3. **Ask the user** with `input` while the script runs:

```matlab
x = input('Enter the resistance in ohm: ');        % a number, vector or expression
name = input('Enter your name: ', 's');            % 's' -> keep the reply as text
```
- For a vector, the user types `[1 2 3]`.
- Without `'s'`, the reply is **evaluated**: typing `2*pi` gives 6.2832.
- If the user just presses Enter, `input` returns an empty `[]`. Check with `isempty`.

Related: `keyboard` (pause and type commands), `pause` / `pause(n)` (wait), `menu` (a pop-up choice) and `inputdlg` (a dialog box) in MATLAB.

## Examples

### Example 1: Inputs assigned in the script  ([`example_1.m`](example_1.m))

```matlab
% Change these numbers and run again
principal = 100000;     % Rs
rate = 8.5;             % % per year
years = 10;
amount = principal * (1 + rate/100)^years;
fprintf('After %d years, Rs %d grows to Rs %.2f\n', years, principal, amount);
```

### Example 2: Asking the user with input  ([`example_2.m`](example_2.m))

```matlab
R = input('Enter the resistance in ohm: ');
V = input('Enter the voltage in volt: ');
name = input('Name of the circuit: ', 's');
I = V / R;
P = V * I;
fprintf('\nCircuit "%s": I = %.3f A, P = %.3f W\n', name, I, P);
```

### Example 3: Validating what the user typed  ([`example_3.m`](example_3.m))

```matlab
age = input('Enter your age: ');
if isempty(age) || ~isnumeric(age) || age < 0
    disp('That is not a valid age.')
else
    fprintf('In 10 years you will be %d.\n', age + 10);
end
% Re-ask until the value is valid (a while loop, Day 45)
n = -1;
tries = 0;
while (isempty(n) || n <= 0) && tries < 3
    n = input('Enter a positive number of samples: ');
    tries = tries + 1;
end
fprintf('Using %d samples.\n', n);
```

## Practice

1. Write a script that asks for the radius of a sphere and prints its volume and surface area.
2. Ask the user for a vector of marks (they type `[..]`) and print the average.
3. Ask for a name with `input(..., 's')` and greet the user. What happens without `'s'`?
4. Run a script after creating its input variable in the Command Window first.

---

[⬅ Day 025](../Day-025-Complex-Numbers-and-Phasors/README.md) · [🏠 Home](../README.md) · [Day 027 ➡](../Day-027-Output-Commands-disp-and-fprintf/README.md)

# Day 052 · Local, Global and Persistent Variables

_User-Defined Functions_

## Local variables
Every function has its **own workspace**. Variables created inside a function are **local**: they exist only while it runs and are not visible in the Command Window, in scripts, or in other functions. Inputs are passed **by value**: changing an input inside a function does not change the caller's variable.

## Global variables
```matlab
global G_CONST     % in EVERY function and in the workspace that needs it
```
A global variable is shared by all the places that declare it `global`. It is easy to break code with globals (anyone can change them), so **prefer passing values as inputs** or use a structure of parameters. Use globals only for a few true constants, if at all.

## Persistent variables
```matlab
persistent count
if isempty(count), count = 0; end
count = count + 1;
```
A persistent variable is local to one function but **keeps its value between calls**. Useful for counters, caching, and remembering the previous state. `clear functionName` resets it.

## Examples

### The function file change_input.m  ([`change_input.m`](change_input.m))

```matlab
function y = change_input(x)
% CHANGE_INPUT  Shows that inputs are copies (passed by value).
x = x * 100;          % changes only the local copy
temp_inside = 5;      % a local variable, invisible outside
y = x + temp_inside;
end
```

### Example 1: Local variables and pass-by-value  ([`example_1.m`](example_1.m))

```matlab
x = 2;
y = change_input(x);
fprintf('x is still %d, y = %d\n', x, y);
fprintf('Is temp_inside visible here? %d\n', exist('temp_inside', 'var'));
```

### The function file counter_tick.m with a persistent variable  ([`counter_tick.m`](counter_tick.m))

```matlab
function n = counter_tick()
% COUNTER_TICK  Returns how many times it has been called.
persistent count
if isempty(count)
    count = 0;
end
count = count + 1;
n = count;
end
```

### The function file gravity_force.m using a global  ([`gravity_force.m`](gravity_force.m))

```matlab
function F = gravity_force(m)
% GRAVITY_FORCE  Weight of a mass, using the global G_ACCEL.
global G_ACCEL
F = m * G_ACCEL;
end
```

### Example 2: persistent and global in action  ([`example_2.m`](example_2.m))

```matlab
clear counter_tick                 % reset the persistent counter
for k = 1:3
    fprintf('called %d times\n', counter_tick());
end
global G_ACCEL
G_ACCEL = 9.81;
fprintf('Weight on Earth: %.1f N\n', gravity_force(70));
G_ACCEL = 1.62;                    % every function that uses it sees the change
fprintf('Weight on the Moon: %.1f N\n', gravity_force(70));
clear global G_ACCEL
```

## Practice

1. Prove that a function cannot see a variable created in the Command Window.
2. Write a function with a persistent variable that returns a new ID number each time (1, 2, 3 …).
3. Rewrite the gravity example so `g` is passed as an input instead of a global. Which is clearer?
4. When is a persistent variable better than a global one?

---

[⬅ Day 051](../Day-051-Input-and-Output-Arguments-nargin-nargout-Defaults-and-varargin/README.md) · [🏠 Home](../README.md) · [Day 053 ➡](../Day-053-Scripts-vs-Functions-and-Local-Functions-in-Scripts/README.md)

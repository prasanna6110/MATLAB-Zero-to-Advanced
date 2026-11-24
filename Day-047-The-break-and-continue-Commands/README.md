# Day 047 · The break and continue Commands

_Programming in MATLAB_

## `break`
Ends the loop **immediately** and jumps to the first command after the loop's `end`. In nested loops it only leaves the **innermost** loop.

## `continue`
Skips the **rest of this pass** and starts the **next** pass of the loop.

## `return`
Ends the whole script or function.

Typical uses:
- `break`: stop searching once you have found what you need; leave an endless `while true` loop when a condition is met.
- `continue`: skip invalid data and process the rest.

## Examples

### Example 1: break: stop at the first match  ([`example_1.m`](example_1.m))

```matlab
rng(5);
readings = 220 + 15*rand(1, 50);
for k = 1:numel(readings)
    if readings(k) > 233
        fprintf('First reading above 233 V is #%d (%.2f V)\n', k, readings(k));
        break
    end
end
% A while-true loop with break
n = 1;
while true
    if mod(n, 7) == 0 && mod(n, 11) == 0 && n > 200
        break
    end
    n = n + 1;
end
fprintf('Smallest number above 200 divisible by 7 and 11: %d\n', n);
```

### Example 2: continue: skip bad data  ([`example_2.m`](example_2.m))

```matlab
data = [12 -1 15 NaN 18 999 14 -1 16];
total = 0; used = 0;
for k = 1:numel(data)
    x = data(k);
    if isnan(x) || x < 0 || x > 100
        fprintf('skipping sample %d (%g)\n', k, x);
        continue
    end
    total = total + x;
    used = used + 1;
end
fprintf('Average of %d good samples = %.2f\n', used, total / used);
```

### Example 3: Prime numbers with break inside nested loops  ([`example_3.m`](example_3.m))

```matlab
primes_found = [];
for n = 2:60
    is_prime = true;
    for d = 2:floor(sqrt(n))
        if mod(n, d) == 0
            is_prime = false;
            break                 % leaves only the inner loop
        end
    end
    if is_prime
        primes_found(end + 1) = n;
    end
end
disp(primes_found)
isequal(primes_found, primes(60))
```

## Practice

1. Search a vector for the first negative number and print its position (or "none").
2. Print the numbers 1–50 except the multiples of 3, using `continue`.
3. Use `while true` with `break` to keep doubling 1 until it exceeds 1e6.
4. In nested loops, how would you leave **both** loops at once? (Hint: a flag variable.)

---

[⬅ Day 046](../Day-046-Nested-Loops-and-Nested-Conditional-Statements/README.md) · [🏠 Home](../README.md) · [Day 048 ➡](../Day-048-Preallocation-Vectorisation-and-Timing-Code/README.md)

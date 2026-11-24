# Day 023 · Generation of Random Numbers

_Mathematics with Arrays_

## Random number functions
| Function | Gives |
|----------|-------|
| `rand` | one uniform number in (0, 1) |
| `rand(m, n)` | an m×n matrix of uniform numbers in (0, 1) |
| `a + (b - a) * rand(m, n)` | uniform numbers in (a, b) |
| `randi(imax, m, n)` | random **integers** from 1 to imax |
| `randi([imin imax], m, n)` | random integers between imin and imax |
| `randn(m, n)` | **normal** (Gaussian) numbers, mean 0, std 1 |
| `mu + sigma * randn(m, n)` | normal numbers with mean mu and std sigma |
| `randperm(n)` | a random permutation of 1..n (shuffle) |
| `randperm(n, k)` | k distinct random integers from 1..n |

## Reproducible results with `rng`
The numbers are pseudo-random: they come from an algorithm that starts from a **seed**.
- `rng(42)` sets the seed, so the same "random" numbers come every run (needed for testing and reports).
- `rng('shuffle')` seeds from the clock.
- `rng('default')` resets to the start-up state.

## Examples

### Example 1: Uniform, integer and normal random numbers  ([`example_1.m`](example_1.m))

```matlab
rng(1);                              % reproducible
u = rand(1, 5)
in_range = 10 + (20 - 10) * rand(1, 5)   % between 10 and 20
dice = randi(6, 1, 10)
temps = randi([20 35], 1, 7)
noise = 0.5 * randn(1, 5)
heights = 170 + 8 * randn(1, 1000);
fprintf('Mean %.1f cm, std %.1f cm\n', mean(heights), std(heights));
```

### Example 2: Shuffling and sampling  ([`example_2.m`](example_2.m))

```matlab
rng(7);
students = 1:30;
order = randperm(30)                  % a shuffled presentation order
team_A = sort(order(1:15))
lucky_three = randperm(100, 3)        % 3 different numbers from 1..100
names = {'Asha', 'Ravi', 'Meena', 'Kabir', 'Ishaan'};
picked = names{randi(numel(names))}
```

### Example 3: A dice experiment and an estimate of pi  ([`example_3.m`](example_3.m))

```matlab
rng(3);
rolls = randi(6, 1, 60000);
for face = 1:6
    fprintf('Face %d: %.4f\n', face, mean(rolls == face));   % close to 1/6 each
end
% Monte Carlo: fraction of random points inside the quarter circle
N = 200000;
x = rand(1, N); y = rand(1, N);
inside = (x.^2 + y.^2) <= 1;
pi_estimate = 4 * mean(inside)
```

## Practice

1. Generate 10 random integers between -5 and 5.
2. Simulate tossing a coin 1000 times and count the heads.
3. Generate 500 normal values with mean 230 and std 3 (supply voltage) and count those outside 230 ± 6.
4. Run `rand(1,3)` twice after `rng(5)` each time. What do you notice?

---

[⬅ Day 022](../Day-022-Built-in-Functions-for-Analyzing-Arrays-Statistics/README.md) · [🏠 Home](../README.md) · [Day 024 ➡](../Day-024-Linear-Algebra-rank-norm-eig-lu-qr-and-svd/README.md)

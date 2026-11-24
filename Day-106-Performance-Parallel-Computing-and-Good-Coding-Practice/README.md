# Day 106 · Performance, Parallel Computing and Good Coding Practice

_Advanced MATLAB and Toolboxes_

## Measuring
- `tic`/`toc`, `timeit(@() f(x))`
- **Run and Time** (Profiler): `profile on; myscript; profile viewer` shows the time spent on every line.
- `memory` (Windows), `whos` for variable sizes.

## Making code faster
1. **Preallocate** arrays (`zeros`, `cell`, `strings`).
2. **Vectorise**: whole-array operations, logical indexing, `cumsum`, `sum(..., dim)`, implicit expansion.
3. Use the right **built-in function** (they are compiled and optimised): `histcounts` instead of counting loops, `\` instead of `inv`, `ismember` instead of nested loops.
4. Put code in **functions**, not scripts.
5. Use **sparse** matrices when most elements are zero (`sparse`, `speye`, `spdiags`): large power-system and finite-element matrices.
6. Avoid repeated file reading, printing and plotting inside loops.

## Parallel and GPU computing (Parallel Computing Toolbox)
- `parfor`: like `for`, but iterations run on several CPU cores at once (iterations must be independent).
- `parpool(4)` starts the workers; `parfeval` runs tasks in the background.
- `gpuArray(A)`: computations on the graphics card; `gather` brings results back.
- `parsim` runs many Simulink simulations in parallel.

## Good coding practice
- Meaningful names (`load_kW`, not `a1`), units in names or comments.
- One task per function, with help text.
- No magic numbers: put constants at the top or in a parameter structure.
- Use version control (**Git** is built into the MATLAB Current Folder browser and Projects).
- Use **MATLAB Projects** to manage paths and files of bigger work.

## Examples

### Example 1: Sparse matrices: memory and speed  ([`example_1.m`](example_1.m))

```matlab
n = 2000;
e = ones(n, 1);
A_sparse = spdiags([-e 2*e -e], -1:1, n, n);     % a tridiagonal matrix
A_full = full(A_sparse);
b = ones(n, 1);
tic; x1 = A_full \ b;  t_full = toc;
tic; x2 = A_sparse \ b; t_sparse = toc;
s1 = whos('A_full'); s2 = whos('A_sparse');
fprintf('Full  : %8.0f kB, solve %.4f s\n', s1.bytes/1024, t_full);
fprintf('Sparse: %8.0f kB, solve %.4f s\n', s2.bytes/1024, t_sparse);
fprintf('Same answer: %d, non-zeros %d of %d\n', norm(x1 - x2) < 1e-6*norm(x1), nnz(A_sparse), n^2);
```

### Example 2: Choosing the faster built-in way  ([`example_2.m`](example_2.m))

```matlab
rng(9);
v = randi(100, 1, 1e6);
tic
counts_loop = zeros(1, 100);
for k = 1:numel(v)
    counts_loop(v(k)) = counts_loop(v(k)) + 1;
end
t1 = toc;
tic; counts_acc = accumarray(v', 1)'; t2 = toc;
fprintf('Counting 1e6 values: loop %.4f s, accumarray %.4f s, equal = %d\n', t1, t2, isequal(counts_loop, counts_acc));
A = rand(500); b = rand(500, 1);
tic; for r = 1:20, x = inv(A)*b; end; t_inv = toc;
tic; for r = 1:20, x2 = A\b; end; t_bs = toc;
fprintf('inv(A)*b: %.4f s   A\\b: %.4f s\n', t_inv, t_bs);
```

### Example 3: parfor and gpuArray  ([`example_3.m`](example_3.m))

```matlab
% MATLAB-ONLY: needs the Parallel Computing Toolbox (and a supported GPU for gpuArray)
% Needs: Parallel Computing Toolbox
N = 200;
result = zeros(1, N);
tic
parfor k = 1:N                          % independent iterations run on several cores
    A = rand(300);
    result(k) = max(abs(eig(A)));
end
fprintf('parfor took %.2f s\n', toc);
if gpuDeviceCount > 0
    G = gpuArray(rand(4000, 'single'));
    tic; H = G * G; wait(gpuDevice); fprintf('GPU matrix multiply %.3f s\n', toc);
    H = gather(H);
end
```

## Practice

1. Profile one of your slow scripts with **Run and Time** and speed up the slowest line.
2. Build a 10 000 × 10 000 sparse identity matrix. How much memory does it use compared to `eye(10000)`?
3. Replace a counting loop with `histc`/`histcounts` or `accumarray`.
4. (MATLAB) Convert a `for` loop of independent simulations into `parfor` and compare the times.

---

[⬅ Day 105](../Day-105-Debugging-the-Code-Analyzer-and-Unit-Testing/README.md) · [🏠 Home](../README.md) · [Day 107 ➡](../Day-107-MATLAB-with-Python-and-Other-Tools-Interview-Questions-and-Common-Mistakes/README.md)

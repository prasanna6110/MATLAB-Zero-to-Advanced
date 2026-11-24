% Day 106 · Performance, Parallel Computing and Good Coding Practice — Choosing the faster built-in way
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

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

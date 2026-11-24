% Day 048 · Preallocation, Vectorisation and Timing Code — The cost of growing an array
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

n = 2e5;
tic
a = [];
for k = 1:n
    a(end + 1) = k^2;          % grows every pass
end
t_grow = toc;
tic
b = zeros(1, n);               % preallocated
for k = 1:n
    b(k) = k^2;
end
t_pre = toc;
tic
c = (1:n).^2;                  % vectorised
t_vec = toc;
fprintf('Growing: %.4f s  Preallocated: %.4f s  Vectorised: %.4f s\n', t_grow, t_pre, t_vec);
isequal(a, b, c)

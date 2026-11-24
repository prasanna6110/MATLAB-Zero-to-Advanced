% Day 048 · Preallocation, Vectorisation and Timing Code — Rewriting loops as vector code
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = linspace(0, 1, 11);
% Loop version: count values above 0.5 and add their squares
count = 0; s = 0;
for k = 1:numel(x)
    if x(k) > 0.5
        count = count + 1;
        s = s + x(k)^2;
    end
end
% Vector version
mask = x > 0.5;
count2 = nnz(mask);
s2 = sum(x(mask).^2);
fprintf('loop: %d, %.4f   vector: %d, %.4f\n', count, s, count2, s2);
% Running maximum, loop vs vector
y = [3 1 4 1 5 9 2 6];
rm = zeros(size(y)); rm(1) = y(1);
for k = 2:numel(y), rm(k) = max(rm(k-1), y(k)); end
disp(rm); disp(cummax(y))

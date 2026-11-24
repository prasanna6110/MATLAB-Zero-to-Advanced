% Day 057 · Recursion — Tower of Hanoi and recursive merge sort
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

hanoi(3, 'A', 'C', 'B');
v = [38 27 43 3 9 82 10];
fprintf('Sorted: %s\n', mat2str(merge_sort(v)));

function hanoi(n, from, to, via)
    if n == 0, return; end
    hanoi(n - 1, from, via, to);
    fprintf('Move disc %d from %s to %s\n', n, from, to);
    hanoi(n - 1, via, to, from);
end

function s = merge_sort(v)
    if numel(v) <= 1
        s = v;
        return
    end
    mid = floor(numel(v) / 2);
    a = merge_sort(v(1:mid));
    b = merge_sort(v(mid+1:end));
    s = zeros(1, numel(v)); i = 1; j = 1;
    for k = 1:numel(v)
        if j > numel(b) || (i <= numel(a) && a(i) <= b(j))
            s(k) = a(i); i = i + 1;
        else
            s(k) = b(j); j = j + 1;
        end
    end
end

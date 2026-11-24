# Day 064 · Set Operations and Key-Value Maps

_Data Types_

## Set operations
| Function | Result |
|----------|--------|
| `unique(a)` | the distinct elements (sorted); `[u, ia, ic] = unique(a)` also gives positions |
| `union(a, b)` | elements in a **or** b |
| `intersect(a, b)` | elements in **both** |
| `setdiff(a, b)` | in a but **not** in b |
| `setxor(a, b)` | in exactly one of them |
| `ismember(x, a)` | is each x in a? `[tf, loc] = ismember(...)` also gives where |

They work for numeric vectors and cell arrays of texts. Add `'rows'` to treat each row as one element, and `'stable'` to keep the original order instead of sorting.

## `containers.Map`: a dictionary
A map stores **key → value** pairs. Keys can be texts or numbers.
```matlab
m = containers.Map();
m('Delhi') = 32;
m('Satna') = 29;
m('Delhi')              % 32
isKey(m, 'Pune')        % false
keys(m), values(m)
remove(m, 'Satna');
m.Count
```
Newer MATLAB (R2022b+) also has the faster `dictionary` type.

`accumarray(subs, vals)` is another useful tool: it **adds up values by group index**, e.g. totals per category.

## Examples

### Example 1: Sets of students and courses  ([`example_1.m`](example_1.m))

```matlab
ml = {'Asha', 'Ravi', 'Meena', 'Kabir'};
ps = {'Ravi', 'Isha', 'Meena', 'Arjun'};
both = intersect(ml, ps)
either = union(ml, ps)
only_ml = setdiff(ml, ps)
just_one = setxor(ml, ps)
[tf, loc] = ismember({'Isha', 'Neha'}, ps)
[u, ~, idx] = unique([3 1 3 2 1 3]);
counts = accumarray(idx(:), 1)'          % how many times each unique value appears
disp([u; counts])
```

### Example 2: A dictionary of resistor colour codes  ([`example_2.m`](example_2.m))

```matlab
colours = {'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'};
code = containers.Map(colours, num2cell(0:9));
band = {'yellow', 'violet', 'red'};                    % 47 x 10^2 = 4.7 kohm
R = (10*code(band{1}) + code(band{2})) * 10^code(band{3});
fprintf('%s-%s-%s = %g ohm\n', band{:}, R);
fprintf('Map has %d keys. Is "gold" a key? %d\n', code.Count, isKey(code, 'gold'));
```

### Example 3: Counting words with a map and grouping with accumarray  ([`example_3.m`](example_3.m))

```matlab
text = 'the load on the feeder and the load on the bus';
words = strsplit(text, ' ');
counter = containers.Map();
for k = 1:numel(words)
    w = words{k};
    if isKey(counter, w)
        counter(w) = counter(w) + 1;
    else
        counter(w) = 1;
    end
end
ks = keys(counter);
for k = 1:numel(ks)
    fprintf('%-7s %d\n', ks{k}, counter(ks{k}));
end
% Total energy per day of the week with accumarray
day_of_reading = [1 2 1 3 2 1 3];
energy = [10 12 9 15 11 8 14];
totals = accumarray(day_of_reading', energy')'
```

## Practice

1. Find the common elements and the differences of `[1 3 5 7 9]` and `3:3:12`.
2. Build a map from state names to their capitals and look up three of them.
3. Count how often each character appears in your name using a map.
4. Use `accumarray` to add up sales per month from vectors `month` and `amount`.

---

[⬅ Day 063](../Day-063-Regular-Expressions-and-Advanced-Text-Processing/README.md) · [🏠 Home](../README.md) · [Day 065 ➡](../Day-065-Polynomials-polyval-roots-and-poly/README.md)

# Day 051 · Input and Output Arguments: nargin, nargout, Defaults and varargin

_User-Defined Functions_

## Multiple inputs and outputs
- Call with fewer outputs than defined: only the first ones are returned. `[~, k] = max(v)` ignores the first.
- A function can have **no outputs** (`function show_table(data)`) or **no inputs** (`function r = random_color()`).

## Checking how it was called
| Variable / function | Gives |
|---------------------|-------|
| `nargin` | how many inputs were actually passed |
| `nargout` | how many outputs were requested |
| `exist('x', 'var')` | whether an input was supplied |
| `isempty(x)` | whether the caller passed `[]` as "use the default" |

Using `nargin` you can give **default values** to optional inputs:
```matlab
if nargin < 3, tariff = 7.5; end
```

## Variable numbers of arguments
- `varargin`: a cell array holding any extra inputs → `varargin{1}`, `numel(varargin)`.
- `varargout`: a cell array of extra outputs.

## The `arguments` block (MATLAB R2019b+)
A modern way to declare types, sizes, defaults and checks:
```matlab
function y = scale(x, factor)
    arguments
        x double
        factor (1,1) double {mustBePositive} = 2
    end
    y = x * factor;
end
```

## Examples

### The function file bmi_calc.m with default inputs  ([`bmi_calc.m`](bmi_calc.m))

```matlab
function [bmi, category] = bmi_calc(weight_kg, height_m, units)
% BMI_CALC  Body mass index and its category.
%   BMI = BMI_CALC(W, H) with W in kg and H in metres.
%   BMI_CALC(W, H, 'imperial') takes W in pounds and H in inches.
if nargin < 2
    error('bmi_calc needs at least the weight and the height');
end
if nargin < 3 || isempty(units)
    units = 'metric';
end
if strcmpi(units, 'imperial')
    weight_kg = weight_kg * 0.4536;
    height_m = height_m * 0.0254;
end
bmi = weight_kg / height_m^2;
if nargout > 1                    % only work out the text if it was asked for
    if bmi < 18.5
        category = 'Underweight';
    elseif bmi < 25
        category = 'Normal';
    elseif bmi < 30
        category = 'Overweight';
    else
        category = 'Obese';
    end
end
end
```

### Example 1: Calling bmi_calc in different ways  ([`example_1.m`](example_1.m))

```matlab
b = bmi_calc(68, 1.72)
[b, cat] = bmi_calc(68, 1.72)
[b2, cat2] = bmi_calc(160, 66, 'imperial')
try
    bmi_calc(70)
catch ME
    disp(ME.message)
end
```

### The function file stats_summary.m using varargin  ([`stats_summary.m`](stats_summary.m))

```matlab
function varargout = stats_summary(varargin)
% STATS_SUMMARY  Mean of any number of vectors; also max and min if asked.
%   [MEANS, MAXS, MINS] = STATS_SUMMARY(V1, V2, ...)
n = numel(varargin);
means = zeros(1, n); maxs = zeros(1, n); mins = zeros(1, n);
for k = 1:n
    v = varargin{k};
    means(k) = mean(v);
    maxs(k) = max(v);
    mins(k) = min(v);
end
all_out = {means, maxs, mins};
varargout = all_out(1:max(1, nargout));
end
```

### Example 2: Calling stats_summary with any number of inputs  ([`example_2.m`](example_2.m))

```matlab
m = stats_summary([1 2 3], [10 20], 5:5:50)
[m, mx, mn] = stats_summary([4 8 15 16 23 42], [-1 1])
```

## Practice

1. Write `area = rect_area(L, W)` where W defaults to L (a square) when not given.
2. Write `[mn, mx] = min_max(v)` that returns only the minimum when called with one output.
3. Write `total = add_all(varargin)` that adds any number of numbers.
4. (MATLAB R2019b+) Rewrite question 1 with an `arguments` block.

---

[⬅ Day 050](../Day-050-Creating-a-Function-File-and-Its-Structure/README.md) · [🏠 Home](../README.md) · [Day 052 ➡](../Day-052-Local-Global-and-Persistent-Variables/README.md)

# Day 059 · Structures

_Data Types_

## What is a structure?
A **structure** groups related data under **named fields**:
```matlab
motor.name = 'M1';
motor.power_kW = 15;
motor.voltage = 415;
% or in one line:
motor = struct('name', 'M1', 'power_kW', 15, 'voltage', 415);
```
Access with a dot: `motor.power_kW`. A field can hold anything, even another structure (`plant.motor.power_kW`).

## Structure arrays
`motors(2).name = 'M2'` creates a **1×2 structure array**; every element has the same fields.
- `[motors.power_kW]` collects one field from all elements into a vector.
- `{motors.name}` collects text fields into a cell array.
- `motors(2) = []` deletes an element.

## Functions for structures
| Function | Does |
|----------|------|
| `fieldnames(s)` | a cell array of field names |
| `isfield(s, 'f')` | does the field exist? |
| `rmfield(s, 'f')` | remove a field |
| `s.(name)` | **dynamic field name** from a text variable |
| `orderfields(s)` | sort the fields |
| `struct2cell`, `cell2struct` | convert to / from cell arrays |
| `arrayfun(@(m) ..., s)` | apply a function to each element |

Structures are perfect for **parameters** of a model (`p.R`, `p.L`, `p.C`) and for **records** (one structure per student, per bus, per device).

## Examples

### Example 1: Building and using a structure  ([`example_1.m`](example_1.m))

```matlab
bus.id = 3;
bus.name = 'Kurukshetra 220 kV';
bus.voltage_pu = 0.98;
bus.load = struct('P_MW', 120, 'Q_MVAr', 45);    % a structure inside a structure
bus
fprintf('%s carries %d MW at %.2f pu\n', bus.name, bus.load.P_MW, bus.voltage_pu);
fieldnames(bus)'
isfield(bus, 'generation')
bus = rmfield(bus, 'id');
f = 'voltage_pu';
bus.(f) = 1.01;                                   % dynamic field name
fprintf('New voltage: %.2f pu\n', bus.voltage_pu);
```

### Example 2: A structure array of students  ([`example_2.m`](example_2.m))

```matlab
students(1) = struct('name', 'Asha',  'marks', [78 82 91]);
students(2) = struct('name', 'Ravi',  'marks', [65 70 58]);
students(3) = struct('name', 'Meena', 'marks', [88 95 90]);
for k = 1:numel(students)
    students(k).avg = mean(students(k).marks);   % add a new field to each
end
avgs = [students.avg]
names = {students.name}
[~, top] = max(avgs);
fprintf('Topper: %s with %.2f\n', students(top).name, avgs(top));
passed = students(avgs >= 70);
fprintf('Passed with 70+: %s\n', strjoin({passed.name}, ', '));
```

### Example 3: Parameters of a model in one structure  ([`example_3.m`](example_3.m))

```matlab
p = struct('R', 10, 'L', 0.5, 'C', 100e-6, 'V', 24);
res = rlc_summary(p);
disp(res)
p.R = 100;                                         % change one parameter
res2 = rlc_summary(p);
fprintf('With R = %g: zeta = %.3f (%s)\n', p.R, res2.zeta, res2.type);

function out = rlc_summary(p)
    out.w0 = 1 / sqrt(p.L * p.C);
    out.zeta = p.R / 2 * sqrt(p.C / p.L);
    if out.zeta < 1
        out.type = 'underdamped';
    elseif out.zeta == 1
        out.type = 'critically damped';
    else
        out.type = 'overdamped';
    end
end
```

## Practice

1. Make a structure for a book with title, author, year and price, then print it neatly.
2. Create a structure array of 4 transformers (name, kVA, load) and list those loaded above 80%.
3. Loop over `fieldnames(s)` and print every field and value of a structure.
4. Use a dynamic field name to read the field whose name is typed by the user.

---

[⬅ Day 058](../Day-058-Cell-Arrays/README.md) · [🏠 Home](../README.md) · [Day 060 ➡](../Day-060-Tables/README.md)

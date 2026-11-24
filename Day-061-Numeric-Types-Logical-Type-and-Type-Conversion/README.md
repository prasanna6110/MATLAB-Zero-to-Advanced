# Day 061 · Numeric Types, Logical Type and Type Conversion

_Data Types_

## Classes of numbers
| Class | Bytes | Range / note |
|-------|-------|--------------|
| `double` (default) | 8 | about ±1.8e308, ~16 significant digits |
| `single` | 4 | about ±3.4e38, ~7 digits, half the memory |
| `int8`, `uint8` | 1 | -128…127 / 0…255 (images use `uint8`) |
| `int16`, `uint16` | 2 | -32768…32767 / 0…65535 |
| `int32`, `uint32` | 4 | about ±2.1e9 / 0…4.3e9 |
| `int64`, `uint64` | 8 | about ±9.2e18 |
| `logical` | 1 | true / false |
| `char` | 2 | characters |

## Rules for integers
- Converting **rounds** to the nearest integer: `int8(2.7)` → 3.
- Results **saturate** at the limits (no wrap-around): `uint8(250) + 10` → 255; `int8(-100) - 100` → -128.
- Integer division rounds: `int32(7) / int32(2)` → 4. Use `idivide(a, b)` for floor/fix division.
- Mixing an integer with a double gives an integer; two different integer types cannot be mixed.

## Checking and converting
`class(x)`, `isa(x, 'integer')`, `isa(x, 'float')`, `isinteger`, `isfloat`, `islogical`, `isnumeric`, `ischar`, `intmax('int16')`, `intmin`, `realmax('single')`, `eps('single')`, `cast(x, 'int16')`, `double(x)`, `logical(x)`, `typecast` (reinterpret the bytes).

## Examples

### Example 1: Integer types: rounding and saturation  ([`example_1.m`](example_1.m))

```matlab
a = int8(2.7)
b = uint8(250) + 10           % saturates at 255
c = int8(-100) - 100          % saturates at -128
d = int32(7) / int32(2)       % 3.5 rounds to 4
e = idivide(int32(7), int32(2))   % 3 (fix division)
intmax('int16'), intmin('int16')
class(uint8(5) * 2.6)         % integer * double -> integer
uint8(5) * 2.6
```

### Example 2: single vs double precision  ([`example_2.m`](example_2.m))

```matlab
x = single(1) / 3
y = 1 / 3
fprintf('single: %.20f\ndouble: %.20f\n', x, y);
eps('single'), eps('double')
A = rand(1000);
B = single(A);
s1 = whos('A'); s2 = whos('B');
fprintf('double uses %d bytes, single uses %d bytes\n', s1.bytes, s2.bytes);
```

### Example 3: Logical values and conversions  ([`example_3.m`](example_3.m))

```matlab
flags = logical([1 0 2 -3 0])        % any non-zero -> true
class(flags)
sum(flags)
v = 10:10:50;
v(flags)                             % logical indexing
n = double('A') + 1                  % char -> number
char(n)
k = cast(3.99, 'int16')
isa(k, 'integer'), isa(k, 'numeric'), isfloat(k)
bitand(uint8(12), uint8(10))         % bit operations on integers: 1100 & 1010 = 1000
dec2bin(bitshift(5, 2))              % 101 shifted left by 2 -> 10100
```

## Practice

1. What is `uint8(200) + uint8(100)`? And `int8(127) + 1`? Explain.
2. Compare the memory of a 500×500 matrix stored as double, single and uint8.
3. Why does `int16(5) / int16(2)` give 3?
4. Use `bitand` and `bitshift` to read bits 2–3 of the number 0b1101 (13).

---

[⬅ Day 060](../Day-060-Tables/README.md) · [🏠 Home](../README.md) · [Day 062 ➡](../Day-062-Date-and-Time/README.md)

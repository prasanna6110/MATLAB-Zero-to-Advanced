# Day 025 · Complex Numbers and Phasors

_Mathematics with Arrays_

## Complex numbers
Write them with `i` or `j`: `z = 3 + 4i`, `Z = 10 - 5j`. Safer: `1i` and `1j` (in case `i` was used as a loop counter).

| Function | Gives |
|----------|-------|
| `real(z)`, `imag(z)` | real and imaginary parts |
| `abs(z)` | magnitude |
| `angle(z)` | phase in radians; `rad2deg(angle(z))` in degrees |
| `conj(z)` | the conjugate |
| `complex(a, b)` | builds `a + bi` |
| `isreal(z)` | true if there is no imaginary part |
| `exp(1i*theta)` | a unit phasor at angle theta |
| `[th, r] = cart2pol(x, y)` / `pol2cart` | rectangular ↔ polar |

All arithmetic (`+ - * /`) works on complex numbers directly, which makes **AC circuit analysis** easy:
- Impedances: `ZR = R`, `ZL = 1j*w*L`, `ZC = 1/(1j*w*C)` with `w = 2*pi*f`
- Phasor in polar form: `V = Vm * exp(1j*deg2rad(phi))`
- Complex power: `S = V * conj(I)`; `P = real(S)`, `Q = imag(S)`, power factor `= cos(angle(V) - angle(I))`

## Examples

### Example 1: Complex number basics  ([`example_1.m`](example_1.m))

```matlab
z1 = 3 + 4i;
z2 = 1 - 2i;
z1 + z2
z1 * z2
z1 / z2
abs(z1)
rad2deg(angle(z1))
conj(z1)
[theta, r] = cart2pol(real(z1), imag(z1))
roots([1 2 5])                 % a quadratic with complex roots
```

### Example 2: A series RLC circuit with AC supply  ([`example_2.m`](example_2.m))

```matlab
V = 230;  f = 50;  w = 2*pi*f;
R = 10;  L = 50e-3;  C = 100e-6;
Z = R + 1j*w*L + 1/(1j*w*C);
I = V / Z;
fprintf('Impedance Z = %.2f %+.2fj ohm (|Z| = %.2f, angle %.2f deg)\n', real(Z), imag(Z), abs(Z), rad2deg(angle(Z)));
fprintf('Current |I| = %.3f A at %.2f deg\n', abs(I), rad2deg(angle(I)));
S = V * conj(I);
fprintf('P = %.1f W, Q = %.1f VAR, |S| = %.1f VA, pf = %.3f\n', real(S), imag(S), abs(S), cos(angle(S)));
```

### Example 3: Adding phasors of a three-phase system  ([`example_3.m`](example_3.m))

```matlab
Vm = 230;
Va = Vm * exp(1j*deg2rad(0));
Vb = Vm * exp(1j*deg2rad(-120));
Vc = Vm * exp(1j*deg2rad(120));
fprintf('Va + Vb + Vc = %.2e (balanced, so ~0)\n', abs(Va + Vb + Vc));
Vab = Va - Vb;
fprintf('Line voltage |Vab| = %.1f V at %.1f deg (sqrt(3) x 230 = %.1f)\n', abs(Vab), rad2deg(angle(Vab)), sqrt(3)*230);
```

## Practice

1. Convert `5∠53.13°` to rectangular form and back.
2. Find the impedance of R = 20 Ω in parallel with L = 0.1 H at 50 Hz.
3. A load draws 10∠-30° A from 230∠0° V. Find P, Q and the power factor.
4. What capacitor in parallel would make the power factor of question 3 equal to 1?

---

[⬅ Day 024](../Day-024-Linear-Algebra-rank-norm-eig-lu-qr-and-svd/README.md) · [🏠 Home](../README.md) · [Day 026 ➡](../Day-026-The-Workspace-and-Input-to-a-Script-File/README.md)

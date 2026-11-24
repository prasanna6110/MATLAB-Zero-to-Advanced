# Day 090 · Laplace and Fourier Transforms

_Symbolic Math_

## Laplace transform
The Laplace transform turns a differential equation in **t** into an algebraic equation in **s**, which is why it is central to **circuit analysis** and **control systems**.

| Command | Gives |
|---------|-------|
| `laplace(f, t, s)` | F(s) = ∫₀^∞ f(t) e^(-st) dt |
| `ilaplace(F, s, t)` | f(t) from F(s) |
| `heaviside(t)` | the unit step u(t) |
| `dirac(t)` | the impulse δ(t) |
| `fourier(f, x, w)` / `ifourier` | Fourier transform pair |
| `ztrans(f, n, z)` / `iztrans` | z-transform for discrete-time signals |

## Solving a circuit with Laplace
1. Transform each element: R → R, L → sL, C → 1/(sC) (zero initial conditions), sources → their transforms (a step of V volts → V/s).
2. Solve the algebraic circuit equations in s (`solve` or plain algebra).
3. Transform back with `ilaplace` to get the time response.

Useful pairs: `1 → 1/s`, `e^(-at) → 1/(s + a)`, `sin(wt) → w/(s² + w²)`, `t → 1/s²`.

## Examples

### Example 1: Laplace and inverse Laplace transforms  ([`example_1.m`](example_1.m))

```matlab
% Needs: Symbolic Math Toolbox
syms t s a w positive
laplace(sym(1), t, s)
laplace(exp(-a*t), t, s)
laplace(sin(w*t), t, s)
laplace(t^2*exp(-3*t), t, s)
ilaplace(1/(s*(s + 2)), s, t)
ilaplace((s + 3)/(s^2 + 4*s + 13), s, t)
```

### Example 2: Step response of a series RLC circuit with Laplace  ([`example_2.m`](example_2.m))

```matlab
% Needs: Symbolic Math Toolbox
syms s t
R = 4; L = 1; C = sym(1)/8; V = 12;
Z = R + s*L + 1/(s*C);            % impedance in the s-domain
I_s = (V/s) / Z;                  % a step of 12 V
VC_s = I_s / (s*C);
i_t = simplify(ilaplace(I_s, s, t))
vC_t = simplify(ilaplace(VC_s, s, t))
fh = matlabFunction(vC_t);
tt = linspace(0, 4, 200);
plot(tt, fh(tt)); grid on; xlabel('t (s)'); ylabel('v_C (V)'); title('RLC step response via Laplace')
```

### Example 3: Solving an ODE with the Laplace transform  ([`example_3.m`](example_3.m))

```matlab
% Needs: Symbolic Math Toolbox
% y'' + 3y' + 2y = 4,  y(0) = 0, y'(0) = 0
syms s t Y
eq = s^2*Y + 3*s*Y + 2*Y == 4/s;     % the transformed equation (zero initial conditions)
Ys = solve(eq, Y)
y_t = ilaplace(Ys, s, t)
check = double(subs(y_t, t, 10))     % approaches the steady value 2
```

## Practice

1. Find the Laplace transform of `e^{-2t} cos(3t)`.
2. Find the inverse Laplace transform of `5/(s(s + 5))`.
3. Use Laplace to find the current in an RL circuit (R = 10 Ω, L = 2 H) for a 20 V step.
4. Solve `y' + 4y = e^{-t}`, y(0) = 1 with the Laplace method.

---

[⬅ Day 089](../Day-089-Plotting-Symbolic-Expressions-and-Numerical-Calculations/README.md) · [🏠 Home](../README.md) · [Day 091 ➡](../Day-091-Introduction-to-Simulink-and-the-Simulink-Environment/README.md)

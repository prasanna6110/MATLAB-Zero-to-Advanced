% Day 066 · Polynomial Arithmetic: conv, deconv, polyder, polyint and residue — Partial fractions with residue
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% F(s) = (2s + 3) / (s^2 + 3s + 2)  =  ?/(s+2) + ?/(s+1)
b = [2 3];
a = [1 3 2];
[r, p, k] = residue(b, a)
for m = 1:numel(r)
    fprintf('%+g / (s %+g)\n', r(m), -p(m));
end
% So f(t) = r1*exp(p1*t) + r2*exp(p2*t)
t = 0:0.5:2;
f_t = r(1)*exp(p(1)*t) + r(2)*exp(p(2)*t);
disp([t; f_t])

% Day 090 · Laplace and Fourier Transforms — Step response of a series RLC circuit with Laplace
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

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

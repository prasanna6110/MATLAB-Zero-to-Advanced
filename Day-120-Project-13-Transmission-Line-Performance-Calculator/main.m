% Day 120 · Project 13: Transmission Line Performance Calculator — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
f = 50;
r = 0.035; L = 1.0e-3; C = 11.5e-9;               % per km: ohm, H, F (a 220 kV line)
z = r + 1j*2*pi*f*L;  y = 1j*2*pi*f*C;
VrL = 220e3;  Pr = 150e6;  pf = 0.9;              % receiving end: line voltage, power, pf lagging
Vr = VrL/sqrt(3);
Ir = Pr/(sqrt(3)*VrL*pf) * exp(-1j*acos(pf));
len = 250;
fprintf('Line: %d km, z = %.4f + j%.4f ohm/km, y = j%.3e S/km\n', len, real(z), imag(z), imag(y));
fprintf('Characteristic impedance |Zc| = %.1f ohm, surge impedance loading = %.1f MW\n\n', abs(sqrt(z/y)), VrL^2/abs(sqrt(z/y))/1e6);
fprintf('%-8s %10s %10s %10s %9s %9s\n', 'Model', '|A|', '|Vs| kV', '|Is| A', 'Reg %', 'Eff %');
models = {'short', 'medium', 'long'};
for m = 1:3
    p = abcd(models{m}, z, y, len);
    [Vs, Is, reg, eff] = performance(p, Vr, Ir);
    fprintf('%-8s %10.4f %10.2f %10.2f %9.2f %9.2f\n', models{m}, abs(p.A), sqrt(3)*abs(Vs)/1e3, abs(Is), reg, eff);
end
% Ferranti effect: receiving-end voltage rises above the sending end at no load
lengths = 50:50:600;
rise = zeros(size(lengths)); reg = rise; eff = rise;
for k = 1:numel(lengths)
    p = abcd('long', z, y, lengths(k));
    rise(k) = (1/abs(p.A) - 1) * 100;              % Vr(no load)/Vs - 1 with Vs fixed
    [~, ~, reg(k), eff(k)] = performance(p, Vr, Ir);
end
fprintf('\nNo-load receiving-end voltage rise (Ferranti) at 600 km: %.1f %%\n', rise(end));
subplot(1, 3, 1); plot(lengths, rise, 'o-'); grid on; xlabel('km'); title('Ferranti rise (%)')
subplot(1, 3, 2); plot(lengths, reg, 'o-'); grid on; xlabel('km'); title('Regulation (%)')
subplot(1, 3, 3); plot(lengths, eff, 'o-'); grid on; xlabel('km'); title('Efficiency (%)')

function p = abcd(model, z, y, len)
    Z = z*len;  Y = y*len;
    switch model
        case 'short'
            p.A = 1; p.B = Z; p.C = 0; p.D = 1;
        case 'medium'
            p.A = 1 + Y*Z/2; p.B = Z; p.C = Y*(1 + Y*Z/4); p.D = p.A;
        case 'long'
            g = sqrt(z*y); Zc = sqrt(z/y);
            p.A = cosh(g*len); p.B = Zc*sinh(g*len); p.C = sinh(g*len)/Zc; p.D = p.A;
    end
end

function [Vs, Is, reg, eff] = performance(p, Vr, Ir)
    Vs = p.A*Vr + p.B*Ir;
    Is = p.C*Vr + p.D*Ir;
    reg = (abs(Vs)/abs(p.A) - abs(Vr)) / abs(Vr) * 100;
    eff = real(Vr*conj(Ir)) / real(Vs*conj(Is)) * 100;
end

% Day 115 · Project 8: Three-Phase System Analyzer — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
VL = 415; Vph = VL/sqrt(3);
a = exp(1j*2*pi/3);
Vabc = Vph * [1; a^2; a];                    % phase voltages Va, Vb, Vc (sequence a-b-c)
cases = {
    'Balanced star',          'Y',     [10+6j; 10+6j; 10+6j]
    'Unbalanced star',        'Y',     [8+6j; 15; 5-4j]
    'Balanced delta',         'D',     [30+18j; 30+18j; 30+18j]
    'Unbalanced delta',       'D',     [20+10j; 40; 25-15j]
    };
for k = 1:size(cases, 1)
    [name, conn, Z] = cases{k, :};
    r = analyse(conn, Z, Vabc);
    fprintf('\n=== %s (Z = %s) ===\n', name, mat2str(Z.', 3));
    fprintf('Line currents : |Ia| %.2f, |Ib| %.2f, |Ic| %.2f A\n', abs(r.Iline));
    if strcmp(conn, 'Y')
        fprintf('Neutral current: %.2f A\n', abs(r.IN));
    else
        fprintf('Phase currents: |Iab| %.2f, |Ibc| %.2f, |Ica| %.2f A\n', abs(r.Iph));
    end
    fprintf('P = %.2f kW, Q = %.2f kVAR, pf = %.3f\n', real(r.S)/1e3, imag(r.S)/1e3, real(r.S)/abs(r.S));
    fprintf('Sequence currents: I0 = %.2f, I1 = %.2f, I2 = %.2f A, unbalance %.1f %%\n', abs(r.I012), 100*abs(r.I012(3))/abs(r.I012(2)));
    if k == 2
        subplot(1, 2, 1); compass(r.Iline.'); title('Unbalanced star: Ia, Ib, Ic')
        subplot(1, 2, 2); bar(abs(r.I012)); set(gca, 'XTickLabel', {'zero', 'positive', 'negative'}); title('Sequence components (A)')
    end
end

function r = analyse(conn, Z, Vabc)
    a = exp(1j*2*pi/3);
    if strcmp(conn, 'Y')
        r.Iph = Vabc ./ Z;                     % with a solid neutral
        r.Iline = r.Iph;
        r.IN = sum(r.Iline);
        r.S = sum(Vabc .* conj(r.Iph));
    else
        Vline = [Vabc(1) - Vabc(2); Vabc(2) - Vabc(3); Vabc(3) - Vabc(1)];   % Vab, Vbc, Vca
        r.Iph = Vline ./ Z;                                                    % Iab, Ibc, Ica
        r.Iline = [r.Iph(1) - r.Iph(3); r.Iph(2) - r.Iph(1); r.Iph(3) - r.Iph(2)];
        r.S = sum(Vline .* conj(r.Iph));
    end
    A = [1 1 1; 1 a a^2; 1 a^2 a] / 3;
    r.I012 = A * r.Iline;
end

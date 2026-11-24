% Day 099 · Control Systems 2: Bode, Root Locus, Margins and PID Design — Root locus and the gain at the stability limit
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Control System Toolbox
s = tf('s');
G = 1 / (s*(s + 2)*(s + 10));
rlocus(G); grid on; title('Root locus')
% The closed loop 1 + K G = 0 -> s^3 + 12 s^2 + 20 s + K = 0
% Routh: unstable when K > 12*20 = 240
for K = [100 239 241]
    p = roots([1 12 20 K]);
    fprintf('K = %3d: max real part of the poles = %+.4f\n', K, max(real(p)));
end
w_osc = sqrt(20);
fprintf('At K = 240 the loop oscillates at %.3f rad/s (period %.3f s)\n', w_osc, 2*pi/w_osc);

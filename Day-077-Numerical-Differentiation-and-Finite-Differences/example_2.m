% Day 077 · Numerical Differentiation and Finite Differences — The step-size trade-off
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

f = @sin; x0 = 1; exact = cos(1);
hs = 10.^(-1:-1:-14);
err_fwd = abs((f(x0 + hs) - f(x0)) ./ hs - exact);
err_cen = abs((f(x0 + hs) - f(x0 - hs)) ./ (2*hs) - exact);
loglog(hs, err_fwd, 'o-', hs, err_cen, 's-'); grid on
xlabel('step h'); ylabel('error'); legend('forward', 'central')
[~, k1] = min(err_fwd); [~, k2] = min(err_cen);
fprintf('Best h: forward %.0e (error %.1e), central %.0e (error %.1e)\n', hs(k1), err_fwd(k1), hs(k2), err_cen(k2));

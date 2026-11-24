% Day 059 · Structures — Parameters of a model in one structure
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

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

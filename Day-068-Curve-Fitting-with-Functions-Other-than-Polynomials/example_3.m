% Day 068 · Curve Fitting with Functions Other than Polynomials — Choosing between models by trying them all
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

x = [1 2 3 4 5 6 7 8];
y = [2.1 3.3 4.0 4.5 4.9 5.3 5.6 5.8];
models = {'linear', 'power', 'exponential', 'logarithmic'};
xx = {x, log(x), x, log(x)};
yy = {y, log(y), log(y), y};
for k = 1:4
    p = polyfit(xx{k}, yy{k}, 1);
    switch k
        case 1, yf = polyval(p, x);
        case 2, yf = exp(p(2)) * x.^p(1);
        case 3, yf = exp(p(2)) * exp(p(1)*x);
        case 4, yf = p(1)*log(x) + p(2);
    end
    sse = sum((y - yf).^2);
    fprintf('%-12s SSE = %.4f\n', models{k}, sse);
end

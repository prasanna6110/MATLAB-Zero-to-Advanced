% Day 067 · Curve Fitting with Polynomials: polyfit — Forecasting with a quadratic fit
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

year = 2015:2023;
demand = [1090 1135 1206 1260 1291 1252 1374 1503 1588];   % TWh (illustrative)
[p, ~, mu] = polyfit(year, demand, 2);    % centring improves accuracy
future = 2024:2026;
forecast = polyval(p, future, [], mu);
for k = 1:numel(future)
    fprintf('%d forecast: %.0f TWh\n', future(k), forecast(k));
end
plot(year, demand, 'bo', [year future], polyval(p, [year future], [], mu), 'r--')
xlabel('Year'); ylabel('TWh'); legend('data', 'quadratic trend'); grid on

% Day 129 · Project 22: Electricity Load Forecasting with Regression — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
rng(42);
days = 35; n = 24*days;
t = (0:n - 1)';
hour = mod(t, 24);  day = floor(t/24);  weekday = mod(day, 7);   % 5 and 6 = weekend
weekend = weekday >= 5;
day_offset = 2*randn(days, 1);                            % some days are hotter than others
temp = 28 + 6*sin(2*pi*(hour - 9)/24) + day_offset(day + 1) + 0.8*randn(n, 1);
load_MW = 500 + 120*sin(2*pi*(hour - 6)/24) + 60*sin(4*pi*(hour - 3)/24) ...
          - 70*weekend + 4*(temp - 24).^2 + 15*randn(n, 1);
X = [ones(n, 1), sin(2*pi*hour/24), cos(2*pi*hour/24), sin(4*pi*hour/24), cos(4*pi*hour/24), ...
     weekend, temp, temp.^2];
train = day < days - 7;  test = ~train;
w = X(train, :) \ load_MW(train);
pred = X(test, :) * w;
actual = load_MW(test);
mape = @(y, yh) 100*mean(abs((y - yh)./y));
rmse = @(y, yh) sqrt(mean((y - yh).^2));
naive = load_MW(find(test) - 24);                          % same hour yesterday
profile = accumarray(hour(train) + 1, load_MW(train)) ./ accumarray(hour(train) + 1, 1);
avg = profile(hour(test) + 1);
fprintf('%-26s %8s %8s\n', 'Method', 'MAPE %', 'RMSE MW');
fprintf('%-26s %8.2f %8.2f\n', 'Yesterday same hour', mape(actual, naive), rmse(actual, naive));
fprintf('%-26s %8.2f %8.2f\n', 'Average daily profile', mape(actual, avg), rmse(actual, avg));
fprintf('%-26s %8.2f %8.2f\n', 'Regression model', mape(actual, pred), rmse(actual, pred));
names = {'intercept', 'sin 24h', 'cos 24h', 'sin 12h', 'cos 12h', 'weekend', 'temp', 'temp^2'};
coef_rows = [names; num2cell(w')];
fprintf('\nCoefficients:\n'); fprintf('  %-10s %10.3f\n', coef_rows{:});
th = t(test)/24;
plot(th, actual, 'k', th, pred, 'r--', 'LineWidth', 1.2); grid on
xlabel('Day'); ylabel('Load (MW)'); legend('actual', 'forecast'); title('Last week: forecast vs actual')

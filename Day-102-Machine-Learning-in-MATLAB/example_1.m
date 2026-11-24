% Day 102 · Machine Learning in MATLAB — Linear regression: normal equation and gradient descent
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

rng(1);
n = 100;
area = 50 + 150*rand(n, 1);                         % m^2
rooms = randi([1 5], n, 1);
price = 8 + 0.35*area + 4*rooms + 3*randn(n, 1);    % lakh rupees
X = [ones(n, 1) area rooms];
w_exact = X \ price;                                % least squares (normal equation)
Xs = [ones(n, 1) normalize(X(:, 2:3))];             % scaled features for gradient descent
w = zeros(3, 1); lr = 0.1;
for epoch = 1:500
    grad = Xs' * (Xs*w - price) / n;
    w = w - lr*grad;
end
pred = Xs*w;
rmse = sqrt(mean((pred - price).^2));
R2 = 1 - sum((price - pred).^2) / sum((price - mean(price)).^2);
fprintf('Normal equation: price = %.2f + %.3f*area + %.2f*rooms\n', w_exact);
fprintf('Gradient descent: RMSE %.2f lakh, R^2 = %.4f\n', rmse, R2);
fprintf('Predicted price of 120 m^2 with 3 rooms: %.1f lakh\n', [1 120 3]*w_exact);

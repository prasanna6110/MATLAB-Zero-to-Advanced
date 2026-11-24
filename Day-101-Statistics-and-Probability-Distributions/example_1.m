% Day 101 · Statistics and Probability Distributions — Normal distribution: probabilities and quality control
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Statistics and Machine Learning Toolbox
mu = 230; sigma = 2.5;                       % supply voltage
p_in = normcdf(236, mu, sigma) - normcdf(224, mu, sigma);
fprintf('P(224 V < V < 236 V) = %.4f\n', p_in);
fprintf('Voltage exceeded only 1%% of the time: %.2f V\n', norminv(0.99, mu, sigma));
x = linspace(220, 240, 300);
plot(x, normpdf(x, mu, sigma), 'LineWidth', 1.5); grid on
hold on
xx = linspace(224, 236, 100);
area(xx, normpdf(xx, mu, sigma), 'FaceColor', [0.7 0.85 1]); hold off
xlabel('Voltage (V)'); title('Normal pdf, shaded = within limits')

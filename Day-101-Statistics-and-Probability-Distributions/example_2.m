% Day 101 · Statistics and Probability Distributions — Binomial and Poisson: failures and arrivals
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Needs: Statistics and Machine Learning Toolbox
n = 20; p = 0.05;                            % 20 transformers, each fails with 5% chance per year
k = 0:5;
pb = binopdf(k, n, p);
fprintf('P(k failures in a year): %s\n', mat2str(pb, 3));
fprintf('P(at least one failure) = %.4f\n', 1 - binopdf(0, n, p));
lambda = 3;                                  % faults per month on a feeder, on average
fprintf('P(more than 5 faults in a month) = %.4f\n', 1 - poisscdf(5, lambda));
bar(0:10, poisspdf(0:10, lambda)); xlabel('faults per month'); ylabel('probability')

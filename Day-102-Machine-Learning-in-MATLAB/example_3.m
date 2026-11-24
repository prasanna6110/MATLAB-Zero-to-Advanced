% Day 102 · Machine Learning in MATLAB — k-means clustering of daily load profiles from scratch
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

rng(3);
h = 0:23;
residential = 1 + 0.8*exp(-(h - 20).^2/8) + 0.4*exp(-(h - 8).^2/4);
commercial  = 0.6 + 1.2*exp(-(h - 13).^2/18);
profiles = [residential + 0.1*randn(30, 24); commercial + 0.1*randn(30, 24)];
K = 2;
cent = profiles(randperm(60, K), :);
for iter = 1:50
    D = zeros(60, K);
    for c = 1:K
        D(:, c) = sum((profiles - cent(c, :)).^2, 2);
    end
    [~, label] = min(D, [], 2);
    new_cent = cent;
    for c = 1:K
        new_cent(c, :) = mean(profiles(label == c, :), 1);
    end
    if max(abs(new_cent(:) - cent(:))) < 1e-9, break; end
    cent = new_cent;
end
fprintf('Converged after %d iterations. Cluster sizes: %s\n', iter, mat2str(accumarray(label, 1)'));
[~, peak_hour] = max(cent, [], 2);
fprintf('Cluster peak hours: %s\n', mat2str(h(peak_hour)));
plot(h, cent', 'LineWidth', 2); xlabel('Hour'); ylabel('Load (pu)'); legend('cluster 1', 'cluster 2'); grid on

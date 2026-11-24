# Day 102 · Machine Learning in MATLAB

_Advanced MATLAB and Toolboxes_

## The workflow
1. **Get data** (`readtable`, sensors, simulation) and **explore** it (plots, statistics).
2. **Prepare** it: remove missing values, scale features (`normalize`), split into training and test sets (`cvpartition`).
3. **Train** a model.
4. **Evaluate** on the test set (accuracy, confusion matrix, RMSE).
5. **Use** it: `predict(model, newData)`, export to C code or deploy.

## Statistics and Machine Learning Toolbox
| Task | Functions |
|------|-----------|
| Regression | `fitlm`, `fitrtree`, `fitrsvm`, `fitrgp`, `fitrensemble`, `fitrnet` |
| Classification | `fitcknn`, `fitctree`, `fitcsvm`, `fitcnb`, `fitcdiscr`, `fitcensemble`, `fitcnet`, `fitglm` (logistic) |
| Clustering | `kmeans`, `kmedoids`, `clusterdata`, `dbscan`, `fitgmdist` |
| Dimension reduction | `pca`, `tsne` |
| Evaluation | `cvpartition`, `crossval`, `kfoldLoss`, `confusionchart`, `perfcurve` (ROC) |
| Apps | **Classification Learner**, **Regression Learner**: try many models with no code, then *Generate Function* |

**Deep Learning Toolbox**: `trainNetwork`/`trainnet`, layers such as `fullyConnectedLayer`, `convolution2dLayer`, `lstmLayer`, the **Deep Network Designer** app, and pretrained networks (ResNet, GoogLeNet) for transfer learning.

## Learning the ideas from scratch
Today's runnable examples write three classic algorithms with plain matrix code (they run anywhere): linear regression by the normal equation and by gradient descent, k-nearest neighbours, and k-means clustering. The last example shows the same tasks with the toolbox in three lines each.

## Examples

### Example 1: Linear regression: normal equation and gradient descent  ([`example_1.m`](example_1.m))

```matlab
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
```

### Example 2: k-nearest neighbours classifier from scratch  ([`example_2.m`](example_2.m))

```matlab
rng(2);
% Two classes of motor condition from (vibration, temperature)
healthy = [2 + 0.6*randn(60, 1), 55 + 4*randn(60, 1)];
faulty  = [4 + 0.8*randn(60, 1), 68 + 5*randn(60, 1)];
X = [healthy; faulty];  y = [zeros(60, 1); ones(60, 1)];
idx = randperm(120);  train = idx(1:90);  test = idx(91:end);
mu = mean(X(train, :)); sd = std(X(train, :));
Z = (X - mu) ./ sd;                                 % scale with the training statistics
k = 5;
pred = zeros(numel(test), 1);
for i = 1:numel(test)
    d = sqrt(sum((Z(train, :) - Z(test(i), :)).^2, 2));
    [~, order] = sort(d);
    pred(i) = mode(y(train(order(1:k))));
end
acc = mean(pred == y(test));
C = [sum(pred == 0 & y(test) == 0), sum(pred == 1 & y(test) == 0);
     sum(pred == 0 & y(test) == 1), sum(pred == 1 & y(test) == 1)];
fprintf('k-NN accuracy on %d test motors: %.1f %%\n', numel(test), 100*acc);
disp('Confusion matrix (rows = true healthy/faulty, columns = predicted):'); disp(C)
```

### Example 3: k-means clustering of daily load profiles from scratch  ([`example_3.m`](example_3.m))

```matlab
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
```

### Example 4: The same tasks with the toolbox  ([`example_4.m`](example_4.m))

```matlab
% MATLAB-ONLY: Statistics and Machine Learning Toolbox functions with MATLAB syntax
% Needs: Statistics and Machine Learning Toolbox
load fisheriris                              % a built-in data set: meas (150x4), species
cv = cvpartition(species, 'HoldOut', 0.3);
Xtr = meas(training(cv), :);  ytr = species(training(cv));
Xte = meas(test(cv), :);      yte = species(test(cv));
knn  = fitcknn(Xtr, ytr, 'NumNeighbors', 5);
tree = fitctree(Xtr, ytr);
fprintf('kNN accuracy %.3f, tree accuracy %.3f\n', mean(strcmp(predict(knn, Xte), yte)), mean(strcmp(predict(tree, Xte), yte)));
confusionchart(yte, predict(knn, Xte));
idx = kmeans(meas, 3, 'Replicates', 5);
lm = fitlm(meas(:, 1:3), meas(:, 4))        % regression with full statistics
```

## Practice

1. Add a third feature to the regression example and see whether R² improves.
2. Change k in the k-NN example to 1, 3, 15. How does the accuracy change?
3. Run k-means with K = 3 on the load profiles. What does the extra cluster look like?
4. (MATLAB) Open the **Classification Learner** app with `fisheriris`, train all models and compare their accuracy.

---

[⬅ Day 101](../Day-101-Statistics-and-Probability-Distributions/README.md) · [🏠 Home](../README.md) · [Day 103 ➡](../Day-103-Object-Oriented-Programming-classdef-Properties-and-Methods/README.md)

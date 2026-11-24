% Day 102 · Machine Learning in MATLAB — The same tasks with the toolbox
% Run: open this file in MATLAB and press Run (or type example_4 in the Command Window)

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

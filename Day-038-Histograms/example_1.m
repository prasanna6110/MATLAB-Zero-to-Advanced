% Day 038 · Histograms — A histogram of exam marks
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

rng(10);
marks = round(min(100, max(0, 62 + 14*randn(1, 200))));
hist(marks, 10)
xlabel('Marks'); ylabel('Number of students')
title('Distribution of 200 marks')
[counts, centers] = hist(marks, 10);
disp([round(centers); counts])

% Day 045 · while Loops — How many years to double an investment?
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

balance = 10000;
rate = 0.072;
years = 0;
while balance < 20000
    balance = balance * (1 + rate);
    years = years + 1;
end
fprintf('It takes %d years (balance Rs %.2f)\n', years, balance);
fprintf('Rule of 72 estimate: %.1f years\n', 72 / (rate*100));

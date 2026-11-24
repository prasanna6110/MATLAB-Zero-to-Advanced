% Day 028 · Building Text with sprintf, num2str and Formatted Tables — A neat table of a loan repayment
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

P = 500000;  annual = 9;  n = 6;                 % 6-month loan
r = annual / 12 / 100;
emi = P * r * (1 + r)^n / ((1 + r)^n - 1);
balance = P;
fprintf('EMI = Rs %.2f\n\n', emi);
fprintf('%5s %12s %12s %14s\n', 'Month', 'Interest', 'Principal', 'Balance');
for m = 1:n
    interest = balance * r;
    principal = emi - interest;
    balance = balance - principal;
    fprintf('%5d %12.2f %12.2f %14.2f\n', m, interest, principal, abs(balance));
end

% Day 103 · Object-Oriented Programming: classdef, Properties and Methods — Using the classes
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

acc = BankAccount('Ravi', 1000);
acc.deposit(500);
acc.withdraw(200);
acc.show();
same = acc;                         % a handle: both names refer to ONE account
same.deposit(100);
fprintf('acc.Balance is now %.2f (changed through "same")\n', acc.Balance);
try
    acc.withdraw(1e6);
catch ME
    fprintf('Refused: %s\n', ME.message);
end
sav = SavingsAccount('Neha', 2000, 0.05);
for year = 1:3
    sav.addInterest();
end
sav.show();
fprintf('Is sav a BankAccount? %d\n', isa(sav, 'BankAccount'));

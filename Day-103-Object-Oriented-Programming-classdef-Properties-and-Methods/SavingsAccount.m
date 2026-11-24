classdef SavingsAccount < BankAccount
    % SAVINGSACCOUNT  A BankAccount that also earns interest.
    properties
        Rate = 0.04
    end
    methods
        function obj = SavingsAccount(owner, amount, rate)
            obj@BankAccount(owner, amount);        % call the parent constructor
            if nargin > 2
                obj.Rate = rate;
            end
        end
        function addInterest(obj)
            interest = obj.Balance * obj.Rate;
            obj.deposit(interest);                 % reuse the parent's method
        end
    end
end

% (Course file for Day 103 · Object-Oriented Programming: classdef, Properties and Methods)

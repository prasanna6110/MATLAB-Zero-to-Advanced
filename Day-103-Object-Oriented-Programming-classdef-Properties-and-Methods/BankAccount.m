classdef BankAccount < handle
    % BANKACCOUNT  A simple bank account (a handle class).
    properties
        Owner = ''
        Balance = 0
    end
    properties (SetAccess = private)
        History = []
    end
    methods
        function obj = BankAccount(owner, amount)
            obj.Owner = owner;
            if nargin > 1
                obj.deposit(amount);
            end
        end
        function deposit(obj, amount)
            if amount <= 0
                error('BankAccount:badAmount', 'Deposit must be positive');
            end
            obj.Balance = obj.Balance + amount;
            obj.History(end + 1) = amount;
        end
        function withdraw(obj, amount)
            if amount > obj.Balance
                error('BankAccount:insufficient', 'Not enough balance (have %.2f)', obj.Balance);
            end
            obj.Balance = obj.Balance - amount;
            obj.History(end + 1) = -amount;
        end
        function show(obj)
            fprintf('%s: balance Rs %.2f after %d transactions\n', obj.Owner, obj.Balance, numel(obj.History));
        end
    end
end

% (Course file for Day 103 · Object-Oriented Programming: classdef, Properties and Methods)

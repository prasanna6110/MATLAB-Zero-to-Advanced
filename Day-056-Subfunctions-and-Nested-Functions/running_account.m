function balance = running_account(start, deposits, rate)
% RUNNING_ACCOUNT  Balance after a list of yearly deposits, with interest.
balance = start;
for d = deposits
    add_interest();           % the nested function changes 'balance' directly
    balance = balance + d;
end

    function add_interest()
        balance = balance * (1 + rate);
    end
end

% (Course file for Day 056 · Subfunctions and Nested Functions)

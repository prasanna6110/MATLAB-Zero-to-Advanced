% Day 132 · Project 25: Library Management System with Object-Oriented Programming — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear;
lib = Library('NIT Central Library');
lib.addBook(Book('111', 'Power System Analysis', 'Electrical', 2018));
lib.addBook(Book('222', 'Signals and Systems', 'Electronics', 2016));
lib.addBook(Book('333', 'Electric Machinery', 'Electrical', 2020));
lib.addBook(Book('444', 'Numerical Methods for Engineers', 'Mathematics', 2015));
lib.addBook(Book('555', 'Control Systems Engineering', 'Electrical', 2019));
day0 = datenum(2026, 11, 1);
lib.issue('111', 'Asha', day0);
lib.issue('333', 'Ravi', day0 + 2);
lib.issue('555', 'Meena', day0 + 5);
try
    lib.issue('111', 'Kabir', day0 + 6);
catch ME
    fprintf('Cannot issue: %s\n', ME.message);
end
fine = lib.giveBack('333', day0 + 20);           % 4 days late
fprintf('Ravi returned late: fine Rs %d\n', fine);
fine = lib.giveBack('555', day0 + 10);
fprintf('Meena returned on time: fine Rs %d\n', fine);
try
    lib.giveBack('999', day0 + 11);
catch ME
    fprintf('Error: %s\n', ME.message);
end
results = lib.search('systems');
fprintf('\nSearch "systems": %d result(s)\n', numel(results));
for k = 1:numel(results), fprintf('  %s\n', results{k}.describe()); end
lib.report(day0 + 24);

# Day 132 · Project 25: Library Management System with Object-Oriented Programming

_Projects_

## Goal
Model a small library with **classes**: a `Book` class (title, subject, ISBN, availability) and a `Library` handle class that stores books and members, **issues** and **returns** books with due dates, calculates **fines** for late returns, searches the catalogue, and prints reports.

## Design
- `Book` (handle class): ISBN, title, subject, year, availability, and a `describe` method.
- `Library` (handle class): a `containers.Map` from ISBN to Book, a record of loans, and methods `addBook`, `issue`, `giveBack`, `search`, `report`.
- Errors (book not found, already issued) are raised with `error` and caught by the caller.
- Dates are serial date numbers (`datenum`) so it runs in MATLAB and Octave.

## Concepts used
`classdef`, constructors, handle semantics, `containers.Map`, `error`/`try-catch`, cell arrays, `datestr`.

## Code

### The class file Book.m  ([`Book.m`](Book.m))

```matlab
classdef Book < handle
    % BOOK  One book in the library.
    properties
        ISBN = ''
        Title = ''
        Subject = ''
        Year = 0
        Available = true
    end
    methods
        function obj = Book(isbn, title, subject, year)
            obj.ISBN = isbn; obj.Title = title; obj.Subject = subject; obj.Year = year;
        end
        function txt = describe(obj)
            if obj.Available, st = 'available'; else, st = 'issued'; end
            txt = sprintf('[%s] %s, %s (%d) - %s', obj.ISBN, obj.Title, obj.Subject, obj.Year, st);
        end
    end
end
```

### The class file Library.m  ([`Library.m`](Library.m))

```matlab
classdef Library < handle
    % LIBRARY  A catalogue of books with loans, due dates and fines.
    properties
        Name = ''
        FinePerDay = 2           % Rs per late day
        LoanDays = 14
    end
    properties (SetAccess = private)
        Books                    % containers.Map: ISBN -> Book
        Loans = {}               % rows: {isbn, member, issue_date, due_date}
        FinesCollected = 0
    end
    methods
        function obj = Library(name)
            obj.Name = name;
            obj.Books = containers.Map();
        end
        function addBook(obj, b)
            obj.Books(b.ISBN) = b;
        end
        function issue(obj, isbn, member, when)
            b = obj.getBook(isbn);
            if ~b.Available
                error('Library:issued', '"%s" is already issued', b.Title);
            end
            b.Available = false;
            obj.Loans(end + 1, :) = {isbn, member, when, when + obj.LoanDays};
        end
        function fine = giveBack(obj, isbn, when)
            b = obj.getBook(isbn);
            row = find(strcmp(obj.Loans(:, 1), isbn), 1);
            if isempty(row)
                error('Library:notIssued', '"%s" was not issued', b.Title);
            end
            late = max(0, floor(when - obj.Loans{row, 4}));
            fine = late * obj.FinePerDay;
            obj.FinesCollected = obj.FinesCollected + fine;
            obj.Loans(row, :) = [];
            b.Available = true;
        end
        function found = search(obj, word)
            found = {};
            ks = keys(obj.Books);
            for k = 1:numel(ks)
                b = obj.Books(ks{k});
                if ~isempty(strfind(lower([b.Title ' ' b.Subject]), lower(word)))
                    found{end + 1} = b; %#ok<AGROW>
                end
            end
        end
        function report(obj, today)
            fprintf('\n=== %s: %d books, %d on loan, fines collected Rs %d ===\n', obj.Name, obj.Books.Count, size(obj.Loans, 1), obj.FinesCollected);
            for r = 1:size(obj.Loans, 1)
                b = obj.Books(obj.Loans{r, 1});
                overdue = '';
                if today > obj.Loans{r, 4}, overdue = sprintf('  OVERDUE by %d days', floor(today - obj.Loans{r, 4})); end
                fprintf('  %-32s -> %-8s due %s%s\n', b.Title, obj.Loans{r, 2}, datestr(obj.Loans{r, 4}, 'dd-mmm-yyyy'), overdue);
            end
        end
    end
    methods (Access = private)
        function b = getBook(obj, isbn)
            if ~isKey(obj.Books, isbn)
                error('Library:unknown', 'No book with ISBN %s', isbn);
            end
            b = obj.Books(isbn);
        end
    end
end
```

### Full program  ([`main.m`](main.m))

```matlab
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
```

## Extend this project

- Add a `Member` class with a limit of 3 books per member.
- Save the library to a MAT-file and load it back.
- Add reservations: a queue of members waiting for an issued book.
- Add a method that lists the most borrowed books.

---

[⬅ Day 131](../Day-131-Project-24-Tic-Tac-Toe-with-an-Unbeatable-Computer-Player/README.md) · [🏠 Home](../README.md) · [Day 133 ➡](../Day-133-Project-26-PID-Controller-Tuning-by-Optimisation/README.md)

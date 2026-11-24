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

% (Course file for Day 132 · Project 25: Library Management System with Object-Oriented Programming)

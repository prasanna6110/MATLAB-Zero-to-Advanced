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

% (Course file for Day 132 · Project 25: Library Management System with Object-Oriented Programming)

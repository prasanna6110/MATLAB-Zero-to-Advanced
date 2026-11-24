% Day 006 · Script Files, Sections and the Current Folder — Block comments and the folder commands
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

%{
This is a block comment.
Everything between the two markers is ignored,
handy for a description at the top of a script.
%}
current_folder = pwd             % where am I?
files = dir('*.m');              % list the .m files here
fprintf('There are %d .m files in this folder\n', numel(files));
which sqrt                       % sqrt is a built-in function

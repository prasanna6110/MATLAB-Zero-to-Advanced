function tests = test_quadratic
% TEST_QUADRATIC  Unit tests for quadratic_roots (MATLAB only).
%   Run with:  results = runtests('test_quadratic')
    tests = functiontests(localfunctions);
end

function test_real_roots(testCase)
    verifyEqual(testCase, quadratic_roots(1, -3, 2), [1 2], 'AbsTol', 1e-12);
end

function test_repeated_root(testCase)
    verifyEqual(testCase, quadratic_roots(1, 2, 1), [-1 -1], 'AbsTol', 1e-12);
end

function test_error_for_linear(testCase)
    verifyError(testCase, @() quadratic_roots(0, 1, 1), 'quadratic_roots:notQuadratic');
end

% (Course file for Day 105 · Debugging, the Code Analyzer and Unit Testing)

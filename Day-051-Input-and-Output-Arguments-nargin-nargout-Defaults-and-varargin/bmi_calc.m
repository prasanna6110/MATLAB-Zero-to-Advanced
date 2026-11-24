function [bmi, category] = bmi_calc(weight_kg, height_m, units)
% BMI_CALC  Body mass index and its category.
%   BMI = BMI_CALC(W, H) with W in kg and H in metres.
%   BMI_CALC(W, H, 'imperial') takes W in pounds and H in inches.
if nargin < 2
    error('bmi_calc needs at least the weight and the height');
end
if nargin < 3 || isempty(units)
    units = 'metric';
end
if strcmpi(units, 'imperial')
    weight_kg = weight_kg * 0.4536;
    height_m = height_m * 0.0254;
end
bmi = weight_kg / height_m^2;
if nargout > 1                    % only work out the text if it was asked for
    if bmi < 18.5
        category = 'Underweight';
    elseif bmi < 25
        category = 'Normal';
    elseif bmi < 30
        category = 'Overweight';
    else
        category = 'Obese';
    end
end
end

% (Course file for Day 051 · Input and Output Arguments: nargin, nargout, Defaults and varargin)

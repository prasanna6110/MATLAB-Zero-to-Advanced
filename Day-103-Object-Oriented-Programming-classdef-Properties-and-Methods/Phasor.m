classdef Phasor
    % PHASOR  An AC quantity stored as a complex number (a value class).
    properties
        Value = 0          % complex rms value
    end
    methods
        function obj = Phasor(mag, angle_deg)
            if nargin > 0
                obj.Value = mag * exp(1j*deg2rad(angle_deg));
            end
        end
        function r = plus(a, b)                % overloads a + b
            r = Phasor();
            r.Value = a.Value + b.Value;
        end
        function r = mtimes(a, b)              % overloads a * b
            r = Phasor();
            r.Value = a.Value * b.Value;
        end
        function txt = polar(obj)
            txt = sprintf('%.2f at %.1f deg', abs(obj.Value), rad2deg(angle(obj.Value)));
        end
    end
end

% (Course file for Day 103 · Object-Oriented Programming: classdef, Properties and Methods)

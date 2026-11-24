function report = motor_report(P_out_kW, V, pf, eta)
% MOTOR_REPORT  Input current, losses and a text summary for a 3-phase motor.
P_in = input_power(P_out_kW, eta);
I = line_current(P_in, V, pf);
report = sprintf('Pout %.1f kW, Pin %.2f kW, losses %.2f kW, I_line %.2f A', ...
                 P_out_kW, P_in, P_in - P_out_kW, I);
end

function P_in = input_power(P_out, eta)       % subfunction
P_in = P_out / eta;
end

function I = line_current(P_in_kW, V_line, pf) % subfunction
I = P_in_kW * 1000 / (sqrt(3) * V_line * pf);
end

% (Course file for Day 056 · Subfunctions and Nested Functions)

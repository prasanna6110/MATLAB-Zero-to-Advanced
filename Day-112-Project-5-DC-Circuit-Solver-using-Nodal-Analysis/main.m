% Day 112 · Project 5: DC Circuit Solver using Nodal Analysis — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear;
% Netlist: type, name, node+, node-, value   (R in ohm, V in volt, I in ampere)
netlist = {
    'V', 'Vs',  1, 0, 24
    'R', 'R1',  1, 2, 4
    'R', 'R2',  2, 0, 6
    'R', 'R3',  2, 3, 3
    'R', 'R4',  3, 0, 12
    'I', 'Is',  0, 3, 2        % 2 A injected into node 3
    'V', 'Vb',  4, 0, 5
    'R', 'R5',  3, 4, 2
    };
[v, isrc, info] = solve_mna(netlist);
fprintf('Node voltages:\n');
for n = 1:numel(v)
    fprintf('  V%d = %9.4f V\n', n, v(n));
end
fprintf('\n%-4s %-5s %10s %10s %10s\n', 'Elem', 'Type', 'V (V)', 'I (A)', 'P (W)');
total_P = 0;
nv = 0;
for k = 1:size(netlist, 1)
    [type, name, a, b, val] = netlist{k, :};
    va = 0; vb = 0;
    if a > 0, va = v(a); end
    if b > 0, vb = v(b); end
    vab = va - vb;
    switch type
        case 'R', i = vab / val;               % current from a to b through R
        case 'I', i = val;                     % the source current flows from a to b through it
        case 'V', nv = nv + 1; i = isrc(nv);   % current from a to b through the source (from MNA)
    end
    P = vab * i;                               % absorbed power (negative = delivered)
    total_P = total_P + P;
    fprintf('%-4s %-5s %10.4f %10.4f %10.4f\n', name, type, vab, i, P);
end
fprintf('\nSum of absorbed powers = %.2e W (should be 0)\n', total_P);
fprintf('Matrix size %dx%d, condition number %.1f\n', info.size, info.size, info.cond);

function [v, isrc, info] = solve_mna(netlist)
    nodes = max(max(cell2mat(netlist(:, 3:4))));
    nV = sum(strcmp(netlist(:, 1), 'V'));
    N = nodes + nV;
    A = zeros(N);  z = zeros(N, 1);
    vk = 0;
    for k = 1:size(netlist, 1)
        [type, ~, a, b, val] = netlist{k, :};
        switch type
            case 'R'
                g = 1 / val;
                if a > 0, A(a, a) = A(a, a) + g; end
                if b > 0, A(b, b) = A(b, b) + g; end
                if a > 0 && b > 0
                    A(a, b) = A(a, b) - g;  A(b, a) = A(b, a) - g;
                end
            case 'I'                      % current 'val' flows from node a to node b through the source
                if a > 0, z(a) = z(a) - val; end
                if b > 0, z(b) = z(b) + val; end
            case 'V'
                vk = vk + 1;  row = nodes + vk;
                if a > 0, A(row, a) = 1;  A(a, row) = 1;  end
                if b > 0, A(row, b) = -1; A(b, row) = -1; end
                z(row) = val;
        end
    end
    x = A \ z;
    v = x(1:nodes);
    isrc = x(nodes + 1:end);           % current flowing from a to b through each voltage source
    info.size = N;  info.cond = cond(A);
end

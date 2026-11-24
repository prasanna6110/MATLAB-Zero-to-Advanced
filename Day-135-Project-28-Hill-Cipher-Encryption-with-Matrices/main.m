% Day 135 · Project 28: Hill Cipher Encryption with Matrices — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear;
K = [3 3; 2 5];
fprintf('Key matrix det = %d, gcd(det, 26) = %d -> valid key\n', round(det(K)), gcd(round(det(K)), 26));
Kinv = modinv_matrix(K, 26);
disp('Inverse key (mod 26):'); disp(Kinv)
disp('Check K*Kinv mod 26:'); disp(mod(K*Kinv, 26))
messages = {'MEET ME AT THE LIBRARY', 'MATLAB IS FUN', 'POWER SYSTEMS'};
for k = 1:numel(messages)
    c = hill(messages{k}, K);
    p = hill(c, Kinv);
    fprintf('%-24s -> %-24s -> %s\n', messages{k}, c, p);
end
% A 3x3 key
K3 = [6 24 1; 13 16 10; 20 17 15];
c3 = hill('ACT NOW', K3);
fprintf('\n3x3 key: ACT NOW -> %s -> %s\n', c3, hill(c3, modinv_matrix(K3, 26)));
% Known-plaintext attack: two known 2-letter blocks reveal a 2x2 key
P = text2num('HELP');  C = text2num(hill('HELP', K));
Pm = reshape(P, 2, 2);  Cm = reshape(C, 2, 2);
K_found = mod(Cm * modinv_matrix(Pm, 26), 26);
fprintf('\nKnown-plaintext attack recovered the key: %s (true key %s)\n', mat2str(K_found), mat2str(K));
bad = [2 4; 1 3];
fprintf('Key %s has det %d: gcd with 26 = %d -> NOT usable\n', mat2str(bad), round(det(bad)), gcd(round(det(bad)), 26));

function out = hill(txt, K)
    n = size(K, 1);
    v = text2num(txt);
    v = [v, 23*ones(1, mod(-numel(v), n))];          % pad with X (23)
    M = reshape(v, n, []);
    out = char(mod(K*M, 26) + 'A');
    out = out(:)';
end

function v = text2num(txt)
    txt = upper(txt(isletter(txt)));
    v = double(txt) - double('A');
end

function Kinv = modinv_matrix(K, m)
    d = mod(round(det(K)), m);
    dinv = modinv(d, m);
    adjK = round(inv(K) * det(K));                   % the adjugate matrix
    Kinv = mod(dinv * adjK, m);
end

function x = modinv(a, m)
    [g, x] = egcd(a, m);
    if g ~= 1, error('%d has no inverse modulo %d', a, m); end
    x = mod(x, m);
end

function [g, x, y] = egcd(a, b)
    if b == 0
        g = a; x = 1; y = 0;
    else
        [g, x1, y1] = egcd(b, mod(a, b));
        x = y1; y = x1 - floor(a/b)*y1;
    end
end

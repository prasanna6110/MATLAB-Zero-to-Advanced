# Day 135 · Project 28: Hill Cipher Encryption with Matrices

_Projects_

## Goal
Encrypt and decrypt messages with the **Hill cipher**, a classical cipher based on **matrix multiplication modulo 26**. Compute the **modular inverse of the key matrix**, check that a key is valid, and show why the cipher is weak against a **known-plaintext attack** (you can recover the key with linear algebra).

## How it works
- Letters → numbers A = 0 … Z = 25. Split the text into blocks of n letters (pad with X).
- Encrypt each block vector p: c = K·p (mod 26).
- Decrypt: p = K⁻¹·c (mod 26), where K⁻¹ is the inverse **modulo 26**: K⁻¹ = det(K)⁻¹ · adj(K) (mod 26).
- A key is valid only if gcd(det K, 26) = 1.

## Concepts used
Character ↔ number conversion, `reshape`, `mod`, `round(det(K))`, the adjugate via `inv(K)*det(K)`, the extended Euclidean algorithm with `gcd`, functions.

## Code

### Full program  ([`main.m`](main.m))

```matlab
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
```

## Extend this project

- Make a random valid key generator (random matrices until gcd(det, 26) = 1).
- Extend the alphabet to 29 symbols (letters, space, full stop, question mark) so the modulus is prime.
- Count how many 2×2 keys are valid modulo 26.
- Implement the Caesar and Vigenère ciphers and compare.

---

[⬅ Day 134](../Day-134-Project-27-Battery-State-of-Charge-Estimation-with-a-Kalman-Filter/README.md) · [🏠 Home](../README.md) · [Day 136 ➡](../Day-136-Project-29-Weather-Data-Dashboard/README.md)

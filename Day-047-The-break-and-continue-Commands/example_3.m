% Day 047 · The break and continue Commands — Prime numbers with break inside nested loops
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

primes_found = [];
for n = 2:60
    is_prime = true;
    for d = 2:floor(sqrt(n))
        if mod(n, d) == 0
            is_prime = false;
            break                 % leaves only the inner loop
        end
    end
    if is_prime
        primes_found(end + 1) = n;
    end
end
disp(primes_found)
isequal(primes_found, primes(60))

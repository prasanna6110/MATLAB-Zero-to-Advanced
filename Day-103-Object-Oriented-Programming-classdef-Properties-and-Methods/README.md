# Day 103 · Object-Oriented Programming: classdef, Properties and Methods

_Advanced MATLAB and Toolboxes_

## Classes and objects
A **class** is a blueprint that bundles **data (properties)** and **functions that act on it (methods)**. An **object** is one instance of the class. MATLAB itself is full of classes: `table`, `datetime`, figures, `tf` models.

```matlab
classdef BankAccount < handle          % < handle: a handle class (see below)
    properties
        Owner
        Balance = 0                    % default value
    end
    properties (SetAccess = private)
        History = []                   % read-only from outside
    end
    methods
        function obj = BankAccount(owner, amount)   % the constructor
            obj.Owner = owner;
            if nargin > 1, obj.deposit(amount); end
        end
        function deposit(obj, amount)
            obj.Balance = obj.Balance + amount;
            obj.History(end+1) = amount;
        end
    end
end
```
- Save each class in its own file with the class name: `BankAccount.m` (or in a folder `@BankAccount`).
- Create an object: `acc = BankAccount('Ravi', 500);` and call methods: `acc.deposit(100)` or `deposit(acc, 100)`.

## Value vs handle classes
| Value class (default) | Handle class (`< handle`) |
|-----------------------|---------------------------|
| copying gives an **independent** copy | copies point to the **same** object |
| a method must **return** the changed object: `obj = obj.method()` | methods change the object **in place** |
| like numbers and structures | like figures and files |

## More features
- **Inheritance**: `classdef SavingsAccount < BankAccount` reuses and extends a class; call the parent constructor with `obj@BankAccount(args)`.
- **Access**: `properties (Access = private)`, `methods (Static)`.
- **Dependent** properties calculated on the fly (`get.PropName` methods), **validation** (`Balance (1,1) double {mustBeNonnegative}`), **events** and **listeners**, **enumerations**.
- Overload operators by defining methods such as `plus`, `mtimes`, `disp`.

## Examples

### The class file BankAccount.m  ([`BankAccount.m`](BankAccount.m))

```matlab
classdef BankAccount < handle
    % BANKACCOUNT  A simple bank account (a handle class).
    properties
        Owner = ''
        Balance = 0
    end
    properties (SetAccess = private)
        History = []
    end
    methods
        function obj = BankAccount(owner, amount)
            obj.Owner = owner;
            if nargin > 1
                obj.deposit(amount);
            end
        end
        function deposit(obj, amount)
            if amount <= 0
                error('BankAccount:badAmount', 'Deposit must be positive');
            end
            obj.Balance = obj.Balance + amount;
            obj.History(end + 1) = amount;
        end
        function withdraw(obj, amount)
            if amount > obj.Balance
                error('BankAccount:insufficient', 'Not enough balance (have %.2f)', obj.Balance);
            end
            obj.Balance = obj.Balance - amount;
            obj.History(end + 1) = -amount;
        end
        function show(obj)
            fprintf('%s: balance Rs %.2f after %d transactions\n', obj.Owner, obj.Balance, numel(obj.History));
        end
    end
end
```

### The class file SavingsAccount.m (inheritance)  ([`SavingsAccount.m`](SavingsAccount.m))

```matlab
classdef SavingsAccount < BankAccount
    % SAVINGSACCOUNT  A BankAccount that also earns interest.
    properties
        Rate = 0.04
    end
    methods
        function obj = SavingsAccount(owner, amount, rate)
            obj@BankAccount(owner, amount);        % call the parent constructor
            if nargin > 2
                obj.Rate = rate;
            end
        end
        function addInterest(obj)
            interest = obj.Balance * obj.Rate;
            obj.deposit(interest);                 % reuse the parent's method
        end
    end
end
```

### Example 1: Using the classes  ([`example_1.m`](example_1.m))

```matlab
acc = BankAccount('Ravi', 1000);
acc.deposit(500);
acc.withdraw(200);
acc.show();
same = acc;                         % a handle: both names refer to ONE account
same.deposit(100);
fprintf('acc.Balance is now %.2f (changed through "same")\n', acc.Balance);
try
    acc.withdraw(1e6);
catch ME
    fprintf('Refused: %s\n', ME.message);
end
sav = SavingsAccount('Neha', 2000, 0.05);
for year = 1:3
    sav.addInterest();
end
sav.show();
fprintf('Is sav a BankAccount? %d\n', isa(sav, 'BankAccount'));
```

### The value class file Phasor.m with operator overloading  ([`Phasor.m`](Phasor.m))

```matlab
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
```

### Example 2: Using the value class Phasor  ([`example_2.m`](example_2.m))

```matlab
I1 = Phasor(10, -30);
I2 = Phasor(5, 45);
Itotal = I1 + I2;                   % uses the plus method
fprintf('I1 + I2 = %s A\n', Itotal.polar());
Z = Phasor(20, 36.87);
V = Z * I1;                          % uses mtimes
fprintf('V = Z * I1 = %s V\n', V.polar());
copy = I1;  copy.Value = 0;          % a value class: the copy is independent
fprintf('I1 is unchanged: %s\n', I1.polar());
```

## Practice

1. Add a `transfer(obj, other, amount)` method to `BankAccount`.
2. Write a value class `Resistor` with a `Value` property and methods `series` and `parallel`.
3. Add a `minus` method to `Phasor` and test `I1 - I2`.
4. Explain with an example why a handle class behaves differently from a value class when copied.

---

[⬅ Day 102](../Day-102-Machine-Learning-in-MATLAB/README.md) · [🏠 Home](../README.md) · [Day 104 ➡](../Day-104-Building-GUIs-App-Designer-and-Programmatic-Apps/README.md)

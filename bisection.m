function root = bisection(fun,a,b,accuracy,iterLimit)
% BISECTION  Find a root of fun using the bisection method.
%   root = BISECTION(fun,a,b)
%       Runs bisection on the interval (a,b)
%
%   root = BISECTION(fun, a, b, accuracy, iterLimit)
%       Runs bisection on the interval (a,b) with custom accuracy
%       and iteration limit
%   
%   Default arguments:
%       accuracy = eps()*1000
%       iterLimit = 100

if nargin < 5
    iterLimit = 100;
end
if nargin < 4
    accuracy = eps()*1000;
end

aSign = sign(fun(a));

while iterLimit > 0 && abs(b-a) > accuracy
    iterLimit = iterLimit - 1;
    middle = (a+b)/2;
    
    middleSign = sign(fun(middle));
    if aSign ~= middleSign
        b = middle;
        continue
    end
    a = middle;
    aSign = middleSign; 
end

root = (a+b)/2;

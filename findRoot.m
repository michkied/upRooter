function root = findRoot(fun,a,b)
%FINDROOT Summary of this function goes here
%   Detailed explanation goes here

accuracy = eps()*1000;
iterLimit = 100;
aSign = sign(fun(a));

while iterLimit > 0 && abs(b-a) > accuracy

    iterLimit = iterLimit - 1;
    middle = (a+b)/2;

    if abs(middle) < 1
        accuracy = eps()*1000;
    else
        accuracy = abs(eps()*1000*middle);
    end
    
    middleSign = sign(fun(middle));
    if aSign ~= middleSign
        b = middle;
        continue
    end
    a = middle;
    aSign = middleSign;
    
end

root = (a+b)/2;

end


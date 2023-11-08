function rts = upRooter(fun,initSize,ratio,seqLength,accuracy,iterLimit)
% UPROOTER  Numerically find multiple roots of a given funciton
%   rts = UPROOTER(fun)
%       Takes in a function handle 'fun', and returns found roots 'rts' as
%       a vertical vector
% 
%   rts = UPROOTER(fun, initSize, ratio, seqLength, accuracy, iterLimit)
%       Runs the root finding algorithm with custom parameters (see below)
% 
%   To calculate the roots, upRooter uses the following algorithm:
%   1.  Generate a vector of the first seqLength elements of a geometric
%       series (with initial size = initSize and common ratio = ratio).
%       Then concatenate this vector with its negative, flipped copy.
%   2.  In the resulting vector find such pairs of neighbouring points,
%       that values of fun in these points have opposite signs (bisection
%       requirement).
%   3.  Run bisection with found pairs of boundary points, given accuracy
%       and iterLimit parameters
% 
%   Default arguments:
%       initSize = 5e-010
%       ratio = 1.0000555
%       seqLength = 950000
%       accuracy = eps()*1000
%       iterLimit = 100

if nargin < 6
    iterLimit = 100;
end
if nargin < 5
    accuracy = eps()*1000;
end
if nargin < 4
    seqLength = 950000;
end
if nargin < 3
    ratio = 1.0000555;
end
if nargin < 2
    initSize = 5e-010;
end

scalingVector = cumprod(repmat(ratio, 1, seqLength));
pointsR = cumsum(initSize*scalingVector);
pointsL = -flip(pointsR);
points = [pointsL, pointsR];
values = fun(points);

values(end) = 0; % makes the following code more compact
signChanges = find((values.*circshift(values, -1)) < 0);

rts = zeros(100000,1);
rtsFound = 0;
for i = 1:size(signChanges,2)
    aPos = signChanges(i);
    aVal = values(aPos);
    bVal = values(aPos+1);
    if ~isreal(aVal) || ~isreal(bVal) || isnan(aVal) || isnan(bVal)
        continue
    end
    rtsFound = rtsFound + 1;
    rts(rtsFound) = bisection(fun,points(aPos),points(aPos+1),...
        accuracy,iterLimit);
end

rts = rts(1:rtsFound);

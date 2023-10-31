function [roots] = nlinGeom(fun)
%NLIN Summary of this function goes here
%   Detailed explanation goes here

%n = 480000;
%q = 1.0001;
%initSize = 1e-08;

n = 1000000;
q = 1.000053;
initSize = 1e-09;

%n = 510000;
%q = 1.0001;
%initSize = 1e-09;

%fID = fopen("settings.txt", "r");
%settings = fscanf(fID, '%f');
%fclose(fID); 
%n = settings(1);
%q = settings(2);
%initSize = settings(3);

scalingVector = cumprod(repmat(q, 1, n));

pointsR = cumsum(initSize*scalingVector);
pointsL = -flip(pointsR);
points = [pointsL, pointsR];
values = fun(points);

signs1 = sign(values);
signs2 = circshift(signs1, 1);
signChanges = find((signs1.*signs2) < 0);

roots = zeros(1,100000);
rootsFound = 0;

for i = 1:size(signChanges,2)
    bPos = signChanges(i);
    if bPos == 1
        continue
    end
    aVal = values(bPos-1);
    bVal = values(bPos);
    if ~isreal(aVal) || ~isreal(bVal) || isnan(aVal) || isnan(bVal)
        continue
    end

    rootsFound = rootsFound+1;
    roots(rootsFound) = findRoot(fun,points(bPos-1),points(bPos));
end

roots = roots(1:rootsFound);

end


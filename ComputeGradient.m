function m = ComputeGradient(X, Y)

numerator = 0;
denominator = 0;

for i=1:82
    numerator = numerator + X(i)*Y(i);
    denominator = denominator + X(i)^2;
end

m = numerator/denominator;

end
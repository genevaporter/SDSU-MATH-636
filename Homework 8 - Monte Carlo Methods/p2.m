clear
clc

syms p(n)
p0 = 50;

p(n) = 1.04^n*p0;

populationAfterTenYears = vpa(p(10))
timeToDouble = vpa(solve(p(n)==100,n))


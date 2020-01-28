function [pValues] = Update(Updating_Function,x0,xf)
%UPDATE
%   Udating_Function: must be a symbolic function made by "syms f(x)".
%       Just use "f" when plugging in 
%   x0: initial population
%   xf:the number of iterations you want to do

pValues=[x0]; %starting a matrix that will contain all iterative values

for t=1:xf
    pValues=cat(1,pValues,vpa(Updating_Function(x0),6));%adding matrix
    x0=vpa(Updating_Function(x0),6);%updating input value
end

%this function returns a matrix. When using this function,
%set it equal to a variable: P = Update(f,50,3)
%to find the value at n, type P(n)

end
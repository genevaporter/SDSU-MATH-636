function [pValues] = Model_Updating(Updating_Function,parameters,p0,xf)
%UPDATE
%   Udating_Function: must be a symbolic function made by "syms f(x)".
%       Just use "f" when plugging in 
%   x0: initial population
%   xf:the number of iterations you want to do

syms x;
pValues=[p0]; %starting a matrix that will contain all iterative values

if parameters==1
    for t=1:xf
        pValues=cat(1,pValues,Updating_Function(p0));%adding to population list matrix
        p0=Updating_Function(p0);%updating input value
    end
Equilibrium=vpa(solve(Updating_Function(x)-x,x),6);
D=diff(Updating_Function);
Stability=vpa(D(Equilibrium),6);

elseif parameters==2
    for t=1:xf
        pValues=cat(1,pValues,Updating_Function(p0,t));%adding to population list matrix
        p0=Updating_Function(p0,t);%updating input value
    end
Equilibrium=vpa(solve(Updating_Function(x,t)-x,x),6);
D=diff(Updating_Function,x);
Stability=vpa(compose(D,Equilibrium),6);
    
end

%this function returns a matrix. When using this function,
%set it equal to a variable: P = Update(f,50,3)
%to find the value at n, type P(n)

Updating_Function=vpa(Updating_Function,6);
pValues=vpa(pValues,6);
%the vpa(item, number) command outputs the 
%"item" with "number" significant figures.

Updating_Function
Equilibrium
Stability
%shows these values

end


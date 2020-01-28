function Errors_Minimize( Guess_For_Parameters, x_Data, y_Data, Function_Type)
%ERRORS_MINIMIZE    optimize "guess" parameter 
%                   using data from polyfit function
%
%   Function_Type: choose form from below
%   Guess_For_Parameters: vector, just put anything
%   x_Data: empirical input values
%   y_Data: empirical output values
%
%	Function_Type: choose:
%       type 1: Discrete Logistic f(a,b,x)=x*(a-b*x)
%       type 2: Beverton-Holt f(a,b,x)=(a*x)/(1+x/b)
%
%

rng default

guess=Guess_For_Parameters;
x=x_Data;
y=y_Data;
n=Function_Type;
v=sym('v');

    function sse = SSE1(guess,x,y)
       sse=sum((y-x.*(guess(1)-guess(2).*x)).^2);
    end

    function sse = SSE2(guess,x,y)
        sse=sum(((y-(guess(1).*x)./(1+x./guess(2))).^2));
    end


switch n
    
    case 1 % Discrete Logistic f(a,b,x)=x*(a-b*x)
        fun = @(guess)SSE1(guess,x,y);
        x0=rand(2,1);
        Best_Fit_Parameters=fminsearch(fun,x0);
        SSE=sum((y-x.*(Best_Fit_Parameters(1)-Best_Fit_Parameters(2).*x)).^2);
        Equilibria=vpa(solve(v-v*(Best_Fit_Parameters(1)-Best_Fit_Parameters(2)*v),v),6);
        
    case 2 %Beverton-Holt f(a,b,x)=(a*x)/(1+x/b)
        fun = @(guess)SSE2(guess,x,y);
        x0=rand(2,1);
        Best_Fit_Parameters=fminsearch(fun,x0);
        SSE=sum(((y-(Best_Fit_Parameters(1).*x)/(1+(x./Best_Fit_Parameters(2)))).^2)); 
        Equilibria=vpa(solve(v-(Best_Fit_Parameters(1)*v)/(1+(v/Best_Fit_Parameters(2))),v),6);
end

Best_Fit_Parameters
SSE
Equilibria
end




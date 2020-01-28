function [Model_Equation] = Model_Basic( function_type, xData, yData )
%Model_Basic Summary:
%   function_type can be:
 %       1 = linear model
 %       2 = 2nd degree polynomial model
 %       3 = logarithmic model
 %       4 = power model
%   xData and yData are the empirical data sets.

i=1;
SSE=[0];

switch function_type

    case 1
        K=2;
    parameters = polyfit(xData, yData,1);
    m=parameters(1);
    b=parameters(2);
    syms fun(x);
    fun(x)=m.*x+b;
    while i <= length(xData)
        square=(fun(xData(i))-yData(i))^2;
        SSE=cat(1,SSE,square);
        i=i+1;
    end
    SSE=double(sum(SSE));

    case 2
        K=3;
    parameters = polyfit(xData, yData,2);
    a=parameters(1);
    b=parameters(2);
    c=parameters(3);
    syms fun(x);
    fun(x)=a.*x.^2+b.*x+c;
    while i<= length(xData)
        square=(fun(xData(i))-yData(i))^2;
        SSE=cat(1,SSE,square);
        i=i+1;
    end
    SSE=double(sum(SSE));
    
    case 3
        K=2;
    xData=log(xData);
    yData=log(yData);
    parameters = polyfit(xData, yData,1);
    a=parameters(1);
    k=exp(parameters(2));
    syms fun(x);
    fun(x)=a.*x+k;
    while i<= length(xData)
        square=(fun(xData(i))-yData(i))^2;
        SSE=cat(1,SSE,square);
        i=i+1;
    end
    SSE=double(sum(SSE));

    
    case 4
        K=2;
    xData=log(xData);
    yData=log(yData);
    parameters = polyfit(xData, yData,1);
    a=parameters(1);
    k=exp(parameters(2));
    syms fun(x);
    fun(x)=k.*x.^double(a);
    while i<= length(xData)
        square=(fun(xData(i))-yData(i))^2;
        SSE=cat(1,SSE,square);
        i=i+1;
    end
    SSE=double(sum(SSE));

    otherwise
    fprintf('no function type\n');

end

SSE=vpa(SSE,7);
Model_Equation=vpa(fun(x),6);
n=numel(xData);

BIC=n*log(SSE/N)+K*log(n);
AIC=2*K+n*(log(2*pi*SSE/n)+1);

Model_Equation
SSE
BIC
AIC

%returns model as a symboluc equation
%prints equation, SSE, and ICs

end


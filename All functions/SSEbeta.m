function [ sse ] = SSE( p0, y_Data )
%SSE 
a = 0.869365040540936;
b = 0.107031460490896;
c = -0.00476953097596288;

y=y_Data;
error=(y(1)-p0)^2;
N=length(y);

for i=2:N
    p0=a*p0+b*p0^2+c*p0^3;
    error = error + (y(i)-p0)^2;
end

sse=error;

end


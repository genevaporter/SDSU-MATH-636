function J = SSE_diff( p0,pdata,tdata )
%SSE_DIFF 
%    p0 = [C(0) ci b]

err = [];

for i=1:length(pdata)
    p = p0(2)+(p0(1)-p0(2))*exp(-p0(3)*(i-1));
    err = [err,p-pdata(i)];
end

J = sum(err.^2);


end


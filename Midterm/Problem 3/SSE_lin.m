function J = SSE_lin( p0,pdata)
%SSE_LIN updating linear function
%   p0 = [P(0) beta u]

N = length(pdata);
p = p0(1);
err = p-pdata(1);


for i=2:N
    p = p-p0(2)*p+p0(3);
    err = [err, p-pdata(i)];
end

J = sum(err.^2);

end


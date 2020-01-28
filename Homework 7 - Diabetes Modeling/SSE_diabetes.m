function SSE = SSE_diabetes(p0, tdata, pdata)
%SSE_DIABETES 

syms G t

G0 = p0(1);
a = p0(2);
A = p0(3);
w = p0(4);
d = p0(5);

G(t) = G0+A*exp(-a*t)*cos(w*(t-d));

err = zeros(length(tdata),1);

for i=1:length(tdata)
    peval = G(tdata(i));
    err(i) = peval - pdata(i);
end

SSE = err'*err;

end


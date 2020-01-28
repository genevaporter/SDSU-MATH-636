function J = Rickers_lst(p0,tdata,pdata)
% Least Squares fit to Nonautonomous Malthusian Growth

a = 0.869365040540936;
b = 0.107031460490896;
c=-0.00476953097596288;

p = p0(1);
pop = [p];
err = [pdata(1) - p];
for i = 2:N  % Nonautonomous iteration
    p = a*p+b*p^2+c*p^3;
    pop = [pop,p];
    err = [err, pdata(i) - p];
end
transpose(pop)
J = err*err'; % Sum of square errors
end

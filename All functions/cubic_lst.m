function J = cubic_lst(p0,tdata,pdata, a,b,c)
% Least Squares fit to Nonautonomous Malthusian Growth
N = length(tdata);
p = p0(1);
pop = [p];
err = [pdata(1) - p];
for i = 2:N  % Nonautonomous iteration
    p = a*p + b*p^2 +c*p^3;
    pop = [pop,p];
    err = [err, pdata(i) - p];
end
J = err*err'; % Sum of square errors
end


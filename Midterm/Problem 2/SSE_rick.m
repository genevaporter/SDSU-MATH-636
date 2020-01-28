function J = SSE_rick(p0,pdata,tdata)
% Least Squares fit to Ricker's Model
% p0 = [p0 a b]

p = p0(1);
psim = p0(1);

for i = 2:16  % Logistic iteration
    p = p0(2)*p*exp(-p0(3)*p);
    psim = [psim, p];
end

pop = psim(tdata+1);
err = pop-pdata;
J = err*err'; 

end


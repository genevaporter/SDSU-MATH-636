function J = SIR_SSE(p0,tdata,pdata)
% Least Squares fit to Logistic Growth

n = length(tdata);
p = p0(1);

parameters=p0; %vector of optimization values

N=148636;
I0=4;
S0=N-I0;


pop = [p];
err = [pdata(1) - p];

for i = 2:n  % Logistic iteration
    p = N-S0-I0;
    S0=S0-b/N*S0*I0;
    I0
    pop = [pop,p];
    err = [err, pdata(i) - p];
end
transpose(pop)
J = err*err'; % Sum of square errors
end


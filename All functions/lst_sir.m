function J = lst_sir(p,idata)
%Least Squares best fit of SIR model
K = length(idata);
N = 148636;
Sn(1) = [148632];
In(1) = [4];
for i = 2:K
    Sn(i) = Sn(i-1) - p(1)*Sn(i-1)*In(i-1)/N;
    In(i) = In(i-1) + p(1)*Sn(i-1)*In(i-1)/N - p(2)*In(i-1);
end
err = idata - In;
J = err*err';
end

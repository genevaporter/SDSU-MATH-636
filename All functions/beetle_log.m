function J = beetle_log(p0,pndata,pn1data)
% Least Squares fit to Logistic Growth
N = length(pndata);
err = [pn1data - (pndata + p0(1)*pndata.*(1 - pndata/p0(2)))];
J = err*err'; % Sum of square errors
end


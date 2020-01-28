syms E(x) x k m

N0 = 10000;
t = 20;

P = symprod((N0+m)/m,m,N0,k)*exp(-x*N0*t)*(1-exp(-x*t))^k;

E(x) = symsum((N0+k)*P,k,0,inf)





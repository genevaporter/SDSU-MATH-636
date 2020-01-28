clear
clc

syms m p r t
b1 = 1;
b2 = 0.1;
b3 = 0.5;
k = 0;
dm(m,p,r) = 1/(1+r(t)^4)-b1*m(t);
dp(m,p,r) = m(t)-b2*p(t);
dr(m,p,r) = p(t)-b3*r(t);

goodwin = [dm;dp;dr];

e1 = vpasolve(goodwin==[0;0;0],[m,p,r]);
e2 = [e1.m,e1.p,e1.r];
e3 = e2(3,:);
J(m,p,r) = [diff(goodwin,m),diff(goodwin,p),diff(goodwin,r)];
E = eig(J(0,0,e3(3)));
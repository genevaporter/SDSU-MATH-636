clear
clc

syms m p r k
b1 = 1;
b2 = 0.1;
b3 = 0.5;
dm = 1/(1+r^4)-b1*m;
dp = m-b2*p;
dr = p-b3*r;

goodwin = [dm;dp;dr];

e1 = vpasolve(goodwin==[0;0;0],[m,p,r]);
e2 = [e1.m,e1.p,e1.r];
e3 = e2(3,:);
J(m,p,r) = [diff(goodwin,m),diff(goodwin,p),diff(goodwin,r)];
E = eig(J(0,0,e3(3)));

% Linearization with delay%

J0 = J(0,0,e3(3));
J1 = zeros(3,3);
J1(1,3)=J0(1,3);
J0(1,3) = 0;

syms lambda w

L = lambda*eye(3,3);
char(lambda,k) = J0+exp(-lambda*k)*J1-L;
char(lambda,k) = simplify(vpa(det(char)));


r = 1i*w;
char2 = expand(char(r,k));


syms w k
cReal = 1.6*w^2- 0.05- 0.18213194724013168079856939129968*cos(k*w);
cImag = - w*0.65+ w^3 + 0.18213194724013168079856939129968*sin(k*w);
F(w,k) = [cReal;cImag];

w0 = 0.01;
k0 = 3;















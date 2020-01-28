clear
clc

syms w k
cReal = 1.6*w^2- 0.05- 0.18213194724013168079856939129968*cos(k*w);
cImag = - w*0.65+ w^3 + 0.18213194724013168079856939129968*sin(k*w);
F(w,k) = [cReal;cImag];

w0 = 0.01;
k0 = 3;

sol=vpasolve(F(w,k)==[0;0],[w0,k0]);
solW = sol.w
solK = sol.k
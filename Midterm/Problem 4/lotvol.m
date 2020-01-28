function dydt = lotvol(t,y,a3,b3)
% Predator and Prey Model 
%   y = [x0 y0]

global rxb mxb ryb myb;
rx = rxb;
mx = mxb;
ry = ryb;
my = myb;

tmp1 = rx*y(1)*(1-y(1)/mx)-y(1)*y(2)/a3;
tmp2 = ry*y(2)*(1-y(2)/my)-y(1)*y(2)/b3;
dydt = [tmp1; tmp2];
end


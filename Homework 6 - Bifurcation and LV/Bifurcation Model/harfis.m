function dydt = harfis(t,y,r,M,h)
% Predator and Prey Model 
tmp1 = r*y(1)*(1-y(1)/M)-y(1)*h/(1+.02*y(1));
dydt = tmp1;
end


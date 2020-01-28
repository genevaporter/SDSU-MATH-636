function dydt = compet(t,y,a1,a2,a3,b1,b2,b3)
% Competition Model for Two Species
tmp1 = a1*y(1) - a2*y(1)^2 - a3*y(1)*y(2); 
tmp2 = b1*y(2) - b2*y(2)^2 - b3*y(1)*y(2); 
dydt = [tmp1; tmp2];
end

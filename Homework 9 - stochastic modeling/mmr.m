function dydt = mmr(t,y,vm,km)
% E.Coli Model, simplified
tmp1 = -(vm*y(1))/(km+y(1));
tmp2 = (vm*y(1))/(km+y(1));
dydt = [tmp1; tmp2];
end


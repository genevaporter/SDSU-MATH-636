function dydt = ecoli(t,y,c1, c2, c3)
% E.Coli Model
tmp1 = -y(1)*y(2)*c1+y(3)*c2;
tmp2 = -y(1)*y(2)*c1+y(3)*c2+y(3)*c3;
tmp3 = y(1)*y(2)*c1-y(3)*c2-y(3)*c3;
tmp4 = y(3)*c3;
dydt = [tmp1; tmp2; tmp3; tmp4];
end


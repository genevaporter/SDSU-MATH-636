function dt = ddefile( t,y )
%DDEFILE 
b1 = 1;
b2 = 0.1;
b3 = 0.5;
tmp1 = 1/(1+y(3)^4)-b1*y(1);
tmp2 = y(1)-b2*y(2);
tmp3 = y(2)-b3*y(3);

dt = [tmp1;tmp2;tmp3];
end


function v = lags( t,y,Z )

b1 = 1;
b2 = 0.1;
b3 = 0.5;

ylag1 = Z(:,1);

v = zeros(3,1);
v(1) = 1/(1+ylag1(1)^4)-b1*y(1);
v(2) = y(1)-b2*y(2);
v(3) = y(2)-b3*y(3);

end











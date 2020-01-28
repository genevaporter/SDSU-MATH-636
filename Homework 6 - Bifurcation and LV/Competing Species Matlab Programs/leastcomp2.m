function J = leastcomp2( p,tdata,xdata,ydata )
%LEASTCOMP2 Summary of this function goes here
%   Detailed explanation goes here

global A1 A2 B1 B2
A1=0.02304; A2=0.0444/337.5869;
B1=0.05444; B2=0.05444/288.9964;
[td,M] = reduct(tdata);
n1 = length(td);


[t,y] = ode23(@compet,td,[p(1),p(2)],[],A1,A2,p(3),B1,B2,p(4));
xd = [xdata(1:M),xdata(M+2:n1+1)];
yd = [ydata(1:M),ydata(M+2:n1+1)];
errx = y(:,1)-xd(1:n1)';
erry = y(:,2)-yd(1:n1)';
J = errx'*errx + erry'*erry;
J = J + (y(M,1)-xdata(M+1))^2 + (y(M,2)-ydata(M+1))^2;

end


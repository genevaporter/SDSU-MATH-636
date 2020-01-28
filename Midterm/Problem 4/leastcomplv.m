function J = leastcomplv(p,tdata,xdata,ydata)
%Create the least squares error function to be minimized.
[t,y] = ode23(@lotvol,tdata,[p(1),p(2)],[],...
        p(3),p(4)); 
errx = y(:,1)-xdata';
erry = y(:,2)-ydata';
J = errx'*errx + erry'*erry;
end


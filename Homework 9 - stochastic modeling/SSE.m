function J = SSE(p,tdata,y1data,y2data)
% Create the least squares error function to be minimized.
% p = [s1 s4 vm km]
[~,Y2] = ode23(@mmr, tdata, [p(1) p(2)],[],p(3),p(4));

err1 = Y2(:,1)-y1data;
err2 = Y2(:,2)-y2data;

J = sum(err1.^2+err2.^2);

end


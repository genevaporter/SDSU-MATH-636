function J = yst_lst( p,tdata,pdata )
%YST_LST Summary 

N = length(tdata);
yst = (p(1)*p(2))./(p(1)+(p(2)-p(1))*exp(-p(3)*tdata));
err = pdata - yst;
J = sum(sum(err.^2)); % Sum of square errors



end


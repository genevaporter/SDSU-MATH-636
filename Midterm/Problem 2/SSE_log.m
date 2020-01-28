function J = SSE_log(p0,tdata,pdata)
% Least Squares fit to Logistic Growth
% p0 = [P(0), a, b]

p = p0(1);
psim = p0(1);

%for i = 2:16  % Logistic iteration
%    p = p + p0(2)*p*(1 - p/(p0(3)));
%    psim = [psim, p];
%end

for i=2:31 %Hassell's model
    p = p*p0(2)/(1+p/p0(3))^1.8;
    psim = [psim, p];
end

pop = psim(tdata+1);
err = pop-pdata;

J = err*err'; % Sum of square errors
end


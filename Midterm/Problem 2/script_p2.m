clear
clc

% input data
tdata = [0 2 5 8 10 12 15 20 25 30];
pdata = [5 16 39 94 132 163 217 273 321 330];
pndata = pdata(1:end-1);
pn1data = pdata(2:end);
x = 0:.1:1.5*max(pdata);

% PART A
% Discrete logistic growth model (updating)
%CHANGE TO HASSELL'S

% initial guesses for p0 = [P(0), r, M]
P0a = pdata(1);
a = 1; % growth rate
b = max(pdata); % largest population
c = 1.8;
p0a = [P0a a b];

% lease squares best fit
pa = fminsearch(@SSE_log,p0a,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
P0_log = pa(1)
a = pa(2)
b = pa(3)
SSEa = SSE_log(pa,tdata,pdata)


%PART B

%find equilibria and stability
syms L(n) dL(n)
H(n) = a*n/(1+n/b)^c;
dH(n) = vpa(diff(H,n))
e_1b = vpa(solve(H-n))
stab_1b = vpa(dH(e_1b))



%PART E

% sketch graph for models
figure(2)
title('Problem 2')
grid on
hold on
scatter(pndata,pn1data)
plot(x,x,'k--')
plot(x,H(x),'r')

legend('Data','Identity','Hassell')

% max growth rate
xm1 = vpa(solve(dH));
Max_growth_log = [xm1 vpa(H(xm1))]


% long term behavior
negative_pop_hass = vpa(max(solve(H)))
asymptote_hass = limit(H(n),n,inf)





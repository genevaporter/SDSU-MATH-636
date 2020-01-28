clear

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
r = 1; % growth rate
M = max(pdata); % largest population
p0a = [P0a r M];

% lease squares best fit
pa = fminsearch(@SSE_log,p0a,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
pa = fminsearch(@SSE_log,pa,[],tdata,pdata);
P0_log = pa(1)
r = pa(2)
M = pa(3)
SSEa = SSE_log(pa,tdata,pdata)


%PART B

%find equilibria and stability
syms L(n) dL(n)
L(n) = n + r*n*(1-n/M);
dL(n) = vpa(diff(L,n))
e_1b = vpa(solve(L-n))
stab_1b = vpa(dL(e_1b))

%PART C

% guess initial values
P0c = pdata(1);
a = 1 + r;
b = 1/M;
p0c = [P0c a b];

%least squares best fit
pc = fminsearch(@SSE_rick,p0c,[],pdata,tdata);
pc = fminsearch(@SSE_rick,pc,[],pdata,tdata);
pc = fminsearch(@SSE_rick,pc,[],pdata,tdata);
pc = fminsearch(@SSE_rick,pc,[],pdata,tdata);
pc = fminsearch(@SSE_rick,pc,[],pdata,tdata);
pc = fminsearch(@SSE_rick,pc,[],pdata,tdata);
P0_rick = pc(1)
a = pc(2)
b = pc(3)
SSEc = SSE_rick(pc,pdata,tdata)

%PART D

% find equilibria
syms R(n) dR(n)
R(n) = a*n*exp(-b*n);
dR(n) = vpa(diff(R,n))
e_1b = vpa(solve(R-n))
stab_1b = vpa(dR(e_1b))

%PART E

% sketch graph for both models
figure(2)
title('Problem 2')
grid on
hold on
scatter(pndata,pn1data)
plot(x,x,'k--')
plot(x,L(x),'r')
plot(x,R(x),'b')
legend('Data','Identity','Logistic','Rickers')

% max growth rate
xm1 = vpa(solve(dL));
Max_growth_log = [xm1 vpa(L(xm1))]
xm2 = vpa(solve(dR));
Max_growth_rick = [xm2 vpa(R(xm2))]

% long term behavior
negative_pop_log = vpa(max(solve(L)))
asymptote_rick = limit(R(n),n,inf)





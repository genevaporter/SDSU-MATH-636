clear
clc

% input data
tdata = 0:1:5;
pdata = [0 4.38 6.36 7.28 8.16 8.47];

% PART A

% initial conditions
c0a = pdata(1);
beta = pdata(3)/2;
u = pdata(2);
p0a = [c0a beta u];

% Best fit
pa = fminsearch(@SSE_lin,p0a,[],pdata);
pa = fminsearch(@SSE_lin,pa,[],pdata);
pa = fminsearch(@SSE_lin,pa,[],pdata);
pa = fminsearch(@SSE_lin,pa,[],pdata);
pa = fminsearch(@SSE_lin,pa,[],pdata);
pa = fminsearch(@SSE_lin,pa,[],pdata);
c0a = pa(1)
beta = pa(2)
u = pa(3)
SSE_3a = SSE_lin(pa,pdata)

% percent error
pn = c0a;
psim = pn;
for i=2:length(pdata)
    pn = pn-beta*pn+u;
    psim = [psim, pn];
end
concentration_at_t2 = psim(3)
percent_error_at_t2 = (psim(3)-pdata(3))/pdata(3)*100
concentration_at_t5 = psim(6)
percent_error_at_t5 = (psim(6)-pdata(6))/pdata(6)*100

% equilibrium
syms Ce(n)
Ce(n) = n-beta*n+u
ea = vpa(solve(Ce-n))

% PART B

% solve differential
syms dC C(t) b c0 ci
dC = diff(C(t),t)==b*(ci-C(t));
initial = C(0)==c0;
C(t) = dsolve(dC, initial)

%find best parameters
c0b = pdata(1);
ci = pdata(2);
b = 1;
p0b = [c0b ci b];
pb = fminsearch(@SSE_diff,p0b,[],pdata,tdata);
pb = fminsearch(@SSE_diff,pb,[],pdata,tdata);
pb = fminsearch(@SSE_diff,pb,[],pdata,tdata);
pb = fminsearch(@SSE_diff,pb,[],pdata,tdata);
pb = fminsearch(@SSE_diff,pb,[],pdata,tdata);
pb = fminsearch(@SSE_diff,pb,[],pdata,tdata);
c0b = pb(1)
ci = pb(2)
b = pb(3)
SSEb = SSE_diff(pb,pdata,tdata)

% find percent error
syms funC(x)
funC(x) = ci+(c0b-ci)*exp(-b*x);
concentration_at_t2 = vpa(funC(2))
percent_error_at_t2 = vpa((funC(2)-pdata(3))/pdata(3)*100)
concentration_at_t5 = vpa(funC(5))
percent_error_at_t5 = vpa((funC(5)-pdata(6))/pdata(6)*100)

% find equilibrium
syms dfunC(x)
dfunC(x) = b*(ci-x);
eb = vpa(solve(dfunC))








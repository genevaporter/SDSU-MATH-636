clear
clc

% PART A

% RUN THIS INDEPENDENTLY FIRST, COPY DIFF EQUATION SOLUTION INTO SSE_dual
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input data
tdata = 0:10:80;
xdata = [0.48 1.65 3.96 8.42 12.14 14.1 14.53 14.87 15.02];
ydata = [0.78 1.38 2.95 5.42 8.77 11.93 14.61 16.04 17.36];

% solve differential equation
syms dPdt(t) o r m P(t)
dPdt(t) = diff(P(t),t) == r*P(t)*(1-P(t)/m);
initial = P(0) == o;
P(t) = dsolve(dPdt(t),initial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best parameters for X
x0a = xdata(1);
rxa = 1;
mxa = max(xdata);
p0ax = [x0a rxa mxa];
pax = fminsearch(@SSE_dual,p0ax,[],tdata,xdata);
pax = fminsearch(@SSE_dual,pax,[],tdata,xdata);
pax = fminsearch(@SSE_dual,pax,[],tdata,xdata);
pax = fminsearch(@SSE_dual,pax,[],tdata,xdata);
pax = fminsearch(@SSE_dual,pax,[],tdata,xdata);
pax = fminsearch(@SSE_dual,pax,[],tdata,xdata);
x0a = pax(1)
rxa = pax(2)
mxa = pax(3)
SSExa = SSE_dual(pax,tdata,xdata)

% best parameters for Y
y0a = ydata(1);
rya = 1;
mya = max(ydata);
p0ay = [y0a rya mya];
pay = fminsearch(@SSE_dual,p0ay,[],tdata,ydata);
pay = fminsearch(@SSE_dual,pay,[],tdata,ydata);
pay = fminsearch(@SSE_dual,pay,[],tdata,ydata);
pay = fminsearch(@SSE_dual,pay,[],tdata,ydata);
pay = fminsearch(@SSE_dual,pay,[],tdata,ydata);
pay = fminsearch(@SSE_dual,pay,[],tdata,ydata);
y0a = pay(1)
rya = pay(2)
mya = pay(3)
SSEya = SSE_dual(pay,tdata,ydata)

% PART B

% new data
xbdata = [0.42 1.25 3.01 6.27 9.41 11.21 12.16 12.62 12.9];
ybdata = [0.32 0.72 1.32 2.12 2.44 2.53 2.31 2.14 1.91];

% initial guesses
global rxb mxb ryb myb;
x0b = xbdata(1);
rxb = rxa;
mxb = mxa;
a3 = 100*max(xbdata);
y0b = ybdata(1);
ryb = rya;
myb = mya;
b3 = 100*max(ybdata);

% fit parameters
p0b = [x0b y0b a3 b3];
pb = fminsearch(@leastcomplv,p0b,[],tdata,xbdata,ybdata);
pb = fminsearch(@leastcomplv,pb,[],tdata,xbdata,ybdata);
pb = fminsearch(@leastcomplv,pb,[],tdata,xbdata,ybdata);
pb = fminsearch(@leastcomplv,pb,[],tdata,xbdata,ybdata);
pb = fminsearch(@leastcomplv,pb,[],tdata,xbdata,ybdata);
pb = fminsearch(@leastcomplv,pb,[],tdata,xbdata,ybdata);
x0b = pb(1)
y0b = pb(2)
a3 = pb(3)
b3 = pb(4)
SSEb = leastcomplv(pb,tdata,xbdata,ybdata)

% PART C

% equilibria
syms X(x,y) Y(x,y) F(x,y) eX(y) eY(y) J(x,y)
X(x,y) = rxb*x*(1-x/mxb)-x*y/a3;
Y(x,y) = ryb*y*(1-y/myb)-x*y/b3;
F(x,y) = [X(x,y);Y(x,y)];
eX(y)=vpa(solve(X/x,x));
eY(y)=vpa(solve(Y/x,x));

e1=[0 0]
e2=[vpa(solve(F(x,0)/x,x)) 0]
e3=[0 vpa(solve(F(0,y)/y,y))]
e4=[eX(solve(eX==eY,y)) solve(eX==eY,y)]

% jacobian matrix

J(x,y) = [vpa(diff(X,x)) vpa(diff(X,y)); vpa(diff(Y,x)) vpa(diff(Y,y))]
L1 = vpa(eig(J(0,0)))
V1 = J(0,0);
V1 = [V1(:,1)/V1(1,1) V1(:,2)/V1(2,2)]
L2 = vpa(eig(J(e2(1),e2(2))))
V2 = J(e2(1),e2(2));
V2 = [V2(:,1)/V2(1,1) V2(:,2)/V2(2,2)]
L3 = vpa(eig(J(e3(1),e3(2))))
V3 = J(e3(1),e3(2));
V3 = [V3(:,1)/V3(1,1) V3(:,2)/V3(2,2)]
L4 = vpa(eig(J(e4(1),e4(2))))
V4 = J(e4(1),e4(2));
V4 = [V4(:,1)/V4(1,1) V4(:,2)/V4(2,2)]

% PART D (only graphing model from part b-c)

% phase portrait
figure(3)
title('Problem 4')
grid on
hold on
maximum = [max(xdata) max(ydata)];
maximum = 1.1*max(maximum);
[t,S] = ode23(@lotvol,[0:0.1:maximum],[pb(1);pb(2)],[],pb(3),pb(4));
plot(S(:,1),S(:,2),'m-','LineWidth',1.5);                         
plot(xdata,ydata,'mo','Markersize',7);
plot(e4(1),e4(2),'o','color',[0,0.6,0],'Markersize',7,'MarkerFaceColor',[0,0.6,0]);


% pphase plane
figure(4)
title('Problem 4')
grid on
hold on
[x1,y1] = meshgrid(0:maximum/50:maximum,0:maximum/50:maximum);
xdot = rxb*x1.*(1-x1./mxb)-x1.*y1./a3;
ydot = ryb*y1.*(1-y1./myb)-x1.*y1./b3;
u = sqrt(xdot.^2+ydot.^2);
quiver(x1,y1,xdot./(2*u),ydot./(2*u));
scatter([e1(1) e2(1) e3(1) e4(1)],[e1(2) e2(2) e3(2) e4(2)]);

% nullclines
figure(4)
syms N1(x) N2(x)
N1(x) = solve(X,y);
N2(y) = solve(Y,x);
temp = 0:.1:maximum;
plot(temp,N1(temp),N2(temp),temp);
xlim([0 maximum]);
ylim([0 maximum]);


















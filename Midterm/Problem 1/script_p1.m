clear
clc

% Input data points
xdata = [51 63 73 77 98 100 104];
xlog = log(xdata);
ydata=[3450 5390 5830 10170 17450 25140 25790];
ylog = log(ydata);

% PART A
% alometric model from log of data log(V) = a*log(d)+log(k)
pa = polyfit(xlog,ylog,1);
aa = pa(1)
ka = exp(pa(2))
erra = [ka*xdata.^aa-ydata];
SSEa = erra*erra'
f100a = ka*100^aa
pe100a = -(f100a-ydata(6))/f100a*100
g12730 = (12730/ka)^(1/aa)


% PART B
% fit directly to exponential form
fitType = ('k*x^a');
fitobject = fit(xdata',ydata',fitType);
pb = coeffvalues(fitobject);
ab = pb(1)
kb = pb(2)
errb = [kb*xdata.^ab-ydata];
SSEb = errb*errb'
f100b = kb*100^ab
pe100b = -(f100b-ydata(6))/f100b*100
g12730 = (12730/kb)^(1/ab)

% PART C
% round a from part b and replace exponent; only change k
ac = double(round(ab))
equation = fittype('k*x^a','problem','a');
values = fit(xdata',ydata',equation,'problem',ac);
kc = coeffvalues(values)
errc = kc*xdata.^ac-ydata;
SSEc = errc*errc'
f100c = kc*100^ac
pe100c = -(f100c-ydata(6))/f100c*100
g12730 = (12730/kc)^(1/ac)

% EXTRA
% sketch both figures
% sketch graph for both models
figure(1)
title('Problem 1')
grid on
hold on
scatter(xdata,ydata)
x = 0:.1:1.1*max(xdata);
plot(x,ka*x.^aa,'k')
plot(x,kb*x.^ab,'r')
plot(x,kc*x.^ac,'b')
legend('Data','Allometric','Power','Fixed a')


























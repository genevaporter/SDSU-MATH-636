clear
clc

load problem1

% p = [G0, a, A, w, d]

p1 = fminsearch(@SSE_diabetes,p1guess,[],tdata,p1data)

SSE1 = SSE_diabetes(p1,tdata,p1data)
omega1 = sqrt(p1(4)^2+p1(2)^2)
T1 = 2*pi/omega1

p2 = fminsearch(@SSE_diabetes,p2guess,[],tdata,p2data)

SSE2 = SSE_diabetes(p2,tdata,p2data)
omega2 = sqrt(p2(4)^2+p2(2)^2)
T2 = 2*pi/omega2

figure (1)

hold off
plot(0,0);
hold on
grid on

mytitle = 'Blood Glucose Levels for 2 Patients'; 
xlab = '$t$ (hours)'; 	
ylab = 'Blood Glucose ($mg/dl$)'; 
set(gca,'FontSize',12);
fontlabs = 'Times New Roman';

title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
xlim([0 tmodel(end)]);
ylim([0 1.5*max(p1data./2+p2data./2)]);

plot(tdata,p1data,'ro','Markersize',7);
plot(tmodel, G(tmodel,p1(1),p1(2),p1(3),p1(4),p1(5)),'r');

plot(tdata,p2data,'bo','Markersize',7);
plot(tmodel, G(tmodel,p2(1),p2(2),p2(3),p2(4),p2(5)),'b');

legend('Patient 1 Data','Predictive Model','Patient 2 Data','Predictive Model'); 




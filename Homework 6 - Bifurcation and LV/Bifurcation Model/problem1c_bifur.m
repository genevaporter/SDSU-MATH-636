clear
clc

t=0:.01:20;

figure(6)
fontlabs = 'Times New Roman'; 
xmin=-5;
xmax=10;
ymin=-5;
ymax=5;

subplot(1,2,2)
syms x y1 y2
y1(x)=sqrt(x);
y2(x)=-sqrt(x);
hold off
plot(t,y1(t),'k');
hold on
plot(t,y2(t),'k');
xlab = '$\mu$'; 	
ylab = '$y$';
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');
xlim([xmin xmax])
ylim([ymin ymax])
set(gca,'FontSize',12)
grid
mytitle = 'Saddle Node Bifurcation at $h = 0.225$'; 
title(mytitle,'FontSize',14,'FontName','Times New Roman','interpreter','latex');

subplot(1,2,1)
hold off
plot([-20 0],[0 0],'k' );
hold on
plot([0 20],[0 0],'k');
plot([-20 0],[-20 0],'k');
plot([0 20],[0 20],'k');
xlab = '$\mu$'; 	
ylab = '$y$';
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');
xlim([xmin xmax])
ylim([ymin ymax])
set(gca,'FontSize',12)
grid
mytitle = 'Transcritical Bifurcation at $h = 0.2$'; 
title(mytitle,'FontSize',14,'FontName','Times New Roman','interpreter','latex');



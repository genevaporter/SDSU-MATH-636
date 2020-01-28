mytitle = 'Predator-Prey'; 
xlab = '$t$ (Years after 1900)'; 	
ylab = 'Pelts ($\times 1000$)'; 


p = [28.4220202188350,8.22865555460437,0.681798878974927,0.0285916435296974,0.622080583100580,0.0217227314262872,1.83302937424735e-12];

[t,Y] = ode23(@lotvol,[0:0.1:30],[p(1);p(2)],[],p(3),p(4),p(5),p(6),p(7));	

figure(8)
plot(t,Y(:,1),'r-','LineWidth',1.5);  
hold on                           
plot(t,Y(:,2),'b-','LineWidth',1.5);
plot(td,hare,'ro','Markersize',7);
plot(td,lynx,'bo','Markersize',7);

grid      
legend('Hare Model','Lynx Model','Hare Data','Lynx Data','Location','Northeast'); 
xlim([0 30]);
ylim([0 80]);

fontlabs = 'Times New Roman'; 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);         
	

figure(9);

mytitle = 'Predator Prey - Phase Portrait';
xlab = 'Hare Pelts ($\times 1000$)'; 
ylab = 'Lynx Pelts ($\times 1000$)';

plot(Y(:,1),Y(:,2),'m-','LineWidth',1.5);  
hold on                           
plot(hare,lynx,'mo','Markersize',7);
plot(28.6373095042938,  23.8460890960168,'o','color',[0,0.6,0],'Markersize',7,'MarkerFaceColor',[0,0.6,0]);

grid      
legend('Model','Data','Equilibrium','Location','Northeast'); 
xlim([0 80]);
ylim([0 70]);

fontlabs = 'Times New Roman'; 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);  
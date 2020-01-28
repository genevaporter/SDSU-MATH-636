 %--Fig (1) : Plots soultion to diff. Equation as Population vs. time
 %--Fig (2) : Plots diff. Equation dP vs. Population
 %--Fig (3) : Plots Phase portrait

p0 = 2;
r = 0.2;
M = 100;
h = 0.225;

syms dP x
dP(x)=harfis(0,x,r,M,h);

p = [p0 r M h];
P = [-20:.01:120];

[t,Y] = ode23(@harfis,P,p(1),[],p(2),p(3),p(4));	

figure(1)

hold off
plot(t,Y(:,1),'r-','LineWidth',1.5);  
hold on                           

grid      
%legend('Fish Population','Location','Northeast'); 
xlim([0 80]);
ylim([0 M*1.3]);

fontlabs = 'Times New Roman'; 
mytitle = 'Population Model for Fishing: $h=0$'; 
xlab = '$t$'; 	
ylab = 'Population $F$';

xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12); 


figure(2)

hold off
plot(P,dP(P),'r-','LineWidth',1.5);  
hold on                           

grid      
xlim([0 120]);
ylim([0 6]);

fontlabs = 'Times New Roman'; 
mytitle = 'Growth Rate Model for Fishing: $h=0$'; 
xlab = 'Population $F$'; 	
ylab = 'Growth Rate $dF$';

xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);


figure(3)
max=100;


plot([-1*max 2*max],[0 0]);


grid      
xlim([-1*max 2*max]);
ylim([-1*max 2*max]);

fontlabs = 'Times New Roman'; 
mytitle = 'Growth Rate Phase Portrait for Fishing: $h=0$'; 
xlab = 'Population $F$'; 	
ylab = 'Growth Rate $dF$';

xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);







	
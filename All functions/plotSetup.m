function plotSetup( mytitle,xlab,ylab )
%PLOTSETUP Summary 

hold on
grid
box
set(gca,'FontSize',12); 
fontlabs = 'Times New Roman'; 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 

end


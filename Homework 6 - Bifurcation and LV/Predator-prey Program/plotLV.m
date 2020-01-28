mytitle = 'Lotka-Volterra Contour';
xlab = 'Hare Pelts, $H(t)$'; 
ylab = 'Lynx Pelts, $L(t)$';

x = linspace(3,100,151);
y = linspace(1,80,151);
[X,Y] = meshgrid(x,y);
Z = 0.9272*log(X)-0.02756*X+0.4807*log(Y)-0.02482*Y;

figure(1)
contour(X,Y,Z)

fontlabs = 'Times New Roman';  
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);      

mytitle = 'Lotka-Volterra Surface';

figure(2)
surf(X,Y,Z);
shading interp
colormap(jet)
view([-10 20])

fontlabs = 'Times New Roman';  
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
%xh = get(gca,'XLabel'); % Handle of the x label
%set(xh, 'Units', 'Normalized')
%pos = get(xh, 'Position');
%set(xh, 'Position',pos.*[1,1,1],'Rotation',2)
yh = get(gca,'YLabel'); % Handle of the y label
set(yh, 'Units', 'Normalized')
pos = get(yh, 'Position');
set(yh, 'Position',pos.*[1,1,1],'Rotation',-55)
set(gca,'FontSize',12);  
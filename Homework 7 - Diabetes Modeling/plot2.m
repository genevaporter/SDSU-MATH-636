

% Initial conditions [A M E]
time = 0:.01:100;
x = .001;

a01 = abs(E1(1)+x);
m01 = abs(E1(2)+x);
e01 = abs(E1(3)+x);
p1 = [double(a01) double(m01) double(e01)];

a02 = abs(E2(1)+x);
m02 = abs(E2(2)+x);
e02 = abs(E2(3)+x);
p2 = [double(a02) double(m02) double(e02)];

a03 = abs(E3(1)+x);
m03 = abs(E3(2)+x);
e03 = abs(E3(3)+x);
p3 = [double(a03) double(m03) double(e03)];



figure(4)

[t,Y] = ode23(@diabetes,time,[p1(1);p1(2);p1(3)],[]);
%subplot(3,1,1);                                  hold off;
%mytitle = 'Diabetes Model with $\delta_p=1$, Initial Conditions $e_1 + \Delta$'; 
%xlab = 'time $t$'; 	
%ylab = '$A(t)$, $M(t)$, $E(t)$'; 
plot(t,Y(:,1),'b-','LineWidth',2);
hold on                           
plot(t,Y(:,2),'g-','LineWidth',2);
plot(t,Y(:,3),'r-','LineWidth',2);
grid on     
legend('{\itA(t)}','{\itM(t)}','{\itE(t)}','Location','eastoutside'); 
fontlabs = 'Times New Roman'; 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);         
	

[t,Y] = ode23(@diabetes,time,[p2(1);p2(2);p2(3)],[]);
%subplot(3,1,2);                                  
%mytitle = 'Diabetes Model with $\delta_p=1$, Initial Conditions $e_2 + \Delta$'; 
%xlab = 'time $t$'; 	
%ylab = '$A(t)$, $M(t)$, $E(t)$'; 
%hold off;
plot(t,Y(:,1),'b-','LineWidth',2);  
hold on                           
plot(t,Y(:,2),'g-','LineWidth',2);
plot(t,Y(:,3),'r-','LineWidth',2);
grid on    
legend('{\itA(t)}','{\itM(t)}','{\itE(t)}','Location','eastoutside'); 
fontlabs = 'Times New Roman'; 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);


[t,Y] = ode23(@diabetes,time,[p3(1);p3(2);p3(3)],[]);
%subplot(3,1,3);                                  hold off;
%mytitle = 'Diabetes Model with $\delta_p=1$, Initial Conditions $e_3 + \Delta$'; 
%xlab = 'time $t$'; 	
%ylab = '$A(t)$, $M(t)$, $E(t)$'; 
plot(t,Y(:,1),'b-','LineWidth',2);  
hold on                           
plot(t,Y(:,2),'g-','LineWidth',2);
plot(t,Y(:,3),'r-','LineWidth',2);
grid on    
legend('{\itA(t)}','{\itM(t)}','{\itE(t)}','Location','eastoutside'); 
fontlabs = 'Times New Roman'; 
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
set(gca,'FontSize',12);




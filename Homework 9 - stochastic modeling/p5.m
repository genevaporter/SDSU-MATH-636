% % Gillespie algorithm
% 
% % Declare gains and losses of each substance
% V = [-1 1 0;-1 1 1;1 -1 -1;0 0 1]; 
% 
% % Declare starting values of substrate and enzyme
% X = zeros(4,1); X(1) = 500; X(2) = 50;
% 
% % For storing values of each substance at each iteration of algorithm
% Y1(1) = X(1); Y2(1) = X(2); Y3(1) = X(3); Y4(1) = X(4);
% 
% % Declare rate constants
% c(1) = 0.002; c(2) = 6*10^(-5); c(3) = 0.08;
% 
% % Set up time step values
% t = 0; tfinal = 200; T(1) = t; i = 0;

% Implement algorithm
% while t < tfinal
%     a(1) = X(1)*X(2)*c(1); % Quantity of S3
%     a(2) = X(3)*c(2); % Quantity of S1+S2
%     a(3) = X(3)*c(3); % Quantity of S2+S4
%     asum = sum(a); % total number of molecules
%     j = find(rand<cumsum(a/asum),1); 
%     tau = log(1/rand)/asum; t = t+tau; % waiting time
%     X = X+V(:,j); % adjust molecular populations
%     if t > tfinal % to prevent error of t jumping to infinity
%         break
%     end
%     i = i+1; % Reaction counter
%     T(i) = t; % Store time
%     Y1(i) = X(1); Y2(i) = X(2); Y3(i) = X(3); Y4(i) = X(4); % Store values
% end
    
% Plot results
% plot(T,Y1,'b-',T,Y2,'r-',T,Y3,'g-',T,Y4,'k','Linewidth',2);grid;
% xlim([0,200]);
% fontlabs = 'Times New Roman'; % Font type used in labels
% xlabel('$t$','FontSize',14,'FontName',fontlabs,...
%     'interpreter','latex');  
% ylabel('Molecules','FontSize',14,'FontName',fontlabs);  
% set(gca,'FontSize',12);
% title('Gillespie Algorithm Simulation no.1','FontName',fontlabs,'FontSize',16);
% legend('S_1: Substrate','S_2: Enzyme','S_3: Complex','S_4: Product','Location','East');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hold on
% p = [X(1) X(2) X(3) X(4) c(1) c(2) c(3)];
% [t,Y] = ode23(@ecoli,[0:0.1:200],[p(1),p(2),p(3),p(4)],[],p(5),p(6),p(7));	
% plot(t,Y(:,1),'b-',t,Y(:,2),'r-',t,Y(:,3),'g-',t,Y(:,4),'k-','Linewidth',2);
% legend('S_1: Substrate','S_2: Enzyme','S_3: Complex','S_4: Product','Location','East')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

p0 = [500 50 0 0 0.002 6*10^(-5) 0.08];
tdata = 10:10:200;
[t,Y] = ode23(@ecoli,tdata,[p0(1),p0(2),p0(3),p0(4)],[],p0(5),p0(6),p0(7));

p = [500 0 4 50];
options = optimset('MaxFunEvals',50000);
p1 = fminsearch(@SSE,p,[],tdata,Y(:,1),Y(:,4));
square = SSE(p1,tdata,Y(:,1),Y(:,4));

[t,Y] = ode23(@ecoli,(0:.10:200),[p0(1),p0(2),p0(3),p0(4)],[],p0(5),p0(6),p0(7));
[t2,Y2] = ode23(@mmr,(0:.10:200),[p1(1) p1(2)],[],p1(3),p1(4));

hold on
plot(t2,Y2(:,1),'b-',t,Y(:,1),'b--',t2,Y2(:,2),'r-',t,Y(:,4),'r--','Linewidth',2);
legend('Simple S_1','Full S_1','Simple S_4','Full S_4','Location','East');
xlim([0,200]);
fontlabs = 'Times New Roman'; % Font type used in labels
xlabel('$t$','FontSize',14,'FontName',fontlabs, 'interpreter','latex');  
ylabel('Molecules','FontSize',14,'FontName',fontlabs);  
set(gca,'FontSize',14);
title('Full and Simplified Model Comparison','FontName',fontlabs,'FontSize',16);










clear
clc

syms dF F h d2F H e1 e2 e3

T=-49:.01:200;
dF(F,h)=0.2*F*(1-F/100)-h*F/(1+.02*F);

E=solve(dF==0,F); 
%some function of h that represents an equilibrium point
e1(h)=E(1)
e2(h)=E(2)
e3(h)=E(3)

d2F(F,h)=simplify(diff(dF,F))
%derivative: we want to plug in an equilibrium point into the deravitive
%and get zero

ge1=d2F(e1,h)
ge2=simplify(d2F(e2,h))
ge3=simplify(d2F(e3,h))
%derivative evaluated at equilibria


h1=double(vpa(simplify(solve(ge1,h))))
h2=double(vpa(simplify(solve(ge2,h))))
h3=double(vpa(simplify(solve(ge3,h))))
%h=solving for h when the derivative at equilibria equals zero

solveh = h3;
%BIFURCATION VALUE 

%Equilibrium at each case:
delta=0.01; 

%for h1-delta
e11_stab=[double(e1(solveh-delta)) double(d2F(e1(solveh-delta),h1))]
e21_stab=[double(e2(solveh-delta)) double(d2F(e2(solveh-delta),h1))]
e31_stab=[double(e3(solveh-delta)) double(d2F(e3(solveh-delta),h1))]

%for h1
e12_stab=[double(e1(solveh)) double(d2F(e1(solveh),solveh))]
e22_stab=[double(e2(solveh)) double(d2F(e2(solveh),solveh))]
e32_stab=[double(e3(solveh)) double(d2F(e3(solveh),solveh))]

%for h1+delta
e13_stab=[double(e1(solveh+delta)) double(d2F(e1(solveh+delta),solveh))]
e23_stab=[double(e2(solveh+delta)) double(d2F(e2(solveh+delta),solveh))]
e33_stab=[double(e3(solveh+delta)) double(d2F(e3(solveh+delta),solveh))]


figure(5) %bifurcation point for h1
%CHANGE TO FIGURE 5 WHEN CHANGING BIFURCATION POINTS
      
fontlabs = 'Times New Roman'; 
xmin = -20;
xmax = 60;
ymin=-.1;
ymax=.2;

subplot(1,3,1)
hold off
plot([xmin xmax],[0 0],'color','k')
hold on
plot(T,dF(T,solveh-delta),'color','r')
%%%%%%
if e11_stab(2)<=0
    plot(e11_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6)
else
    plot([e11_stab(1) e11_stab(1)],[-1 1],'LineStyle','--','Color',[.5 .5 .5])
    plot(e11_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
%%%%%%
if e21_stab(2)<0
    plot(e21_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6)
else
    plot([e21_stab(1) e21_stab(1)],[-1 1],'LineStyle','--','Color',[.5 .5 .5])
    plot(e21_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
%%%%%%
if e31_stab(2)<0
    plot(e31_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',6)
else
    plot([e31_stab(1) e31_stab(1)],[-1 1],'LineStyle','--','Color',[.5 .5 .5])
    plot(e31_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
xlab = '$h - \delta$'; 	
ylab = 'Growth Rate $dF$';
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
ylabel(ylab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');
xlim([xmin xmax])
ylim([ymin ymax])
set(gca,'FontSize',12)
grid

subplot(1,3,2)
hold off
plot([xmin xmax],[0 0],'color','k')
hold on
plot(T,dF(T,solveh),'color','b')
plot([e12_stab(1) e22_stab(1) e32_stab(1)],[0 0 0],'color','k')
%%%%%%
if e12_stab(2)<0
    plot(e12_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6)
else
    plot([e12_stab(1) e12_stab(1)],[-1 1],'--','Color',[.5 .5 .5])
    plot(e12_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
%%%%%%
if e22_stab(2)<0
    plot(e22_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6)
else
    plot([e22_stab(1) e22_stab(1)],[-1 1],'--','Color',[.5 .5 .5])
    plot(e22_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
%%%%%%
if e32_stab(2)<0
    plot(e32_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',6)
else
    plot([e32_stab(1) e32_stab(1)],[-1 1],'--','Color',[.5 .5 .5])
    plot(e32_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
mytitle = 'Model Comparison Near $h$ = 0.2'; 
title(mytitle,'FontSize',16,'FontName','Times New Roman','interpreter','latex'); 
xlab = 'Population $F$'; 	
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex'); 
xlim([xmin xmax])
ylim([ymin ymax])
set(gca,'FontSize',12)
grid

subplot(1,3,3)
hold off
plot([xmin xmax],[0 0],'color','k')
hold on
plot(T,dF(T,solveh+delta),'color','g')
plot([e13_stab(1) e23_stab(1) e33_stab(1)],[0 0 0],'color','k')
%%%%%%
if e13_stab(2)<0
    plot(e13_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6)
else
    plot([e13_stab(1) e13_stab(1)],[-1 1],'--','Color',[.5 .5 .5])
    plot(e13_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
%%%%%%
if e23_stab(2)<0
    plot(e23_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6)
else
    plot([e23_stab(1) e23_stab(1)],[-1 1],'--','Color',[.5 .5 .5])
    plot(e23_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
%%%%%%
if e33_stab(2)<0
    plot(e33_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',6)
else
    plot([e33_stab(1) e33_stab(1)],[-1 1],'--','Color',[.5 .5 .5])
    plot(e33_stab(1),0,'o','MarkerEdgeColor','k','MarkerFaceColor','w','MarkerSize',6)
end
%%%%%%
xlab = '$h + \delta$';
xlabel(xlab,'FontSize',14,'FontName',fontlabs,'interpreter','latex');  
xlim([xmin xmax])
ylim([ymin ymax])
set(gca,'FontSize',12)
grid




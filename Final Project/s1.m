% EPITHELIA DOMAIN

clear
clc

syms S P F

rhoS = 1600;
rhoP = 0; 
rhoF = 0;
deltaS = 0.2; 
deltaP = 0; 
deltaF = 5;
deltaC = 1.6; 
n = 2;
v = 0; 

syms deltaS deltaF deltaC rhoS

dS(S,P,F) = rhoS*(F^n)/(F^n+1) - deltaS*S - deltaC*P^2*S;
dP(S,P,F) = rhoP - deltaP*P + (v-2*deltaC)*P^2*S;
dF(S,P,F) = rhoF*(1)/((P^2*S)^n+1)-deltaF*F;
dydt(S,P,F) = [dS; dP; dF];

sol = vpasolve(dydt==[0;0;0],[S,P,F]);
equ = [double(sol.S),double(sol.P),double(sol.F)];
J(S,P,F) = [diff(dydt,S),diff(dydt,P),diff(dydt,F)];
[E,V] = eig(J);
V(S,P,F) = V;

simplify(vpa(equ))
simplify(vpa(J))
J(equ(1),equ(2),equ(3))
simplify(vpa(V(equ(1),equ(2),equ(3))))


Equilibrium:  
[ 0, 0, 0]
 
 
Jacobian:  
[ - deltaC*P^2 - deltaS, -2.0*P*S*deltaC, (2.0*F*rhoS)/(F^2 + 1.0)^2]
[       -2.0*P^2*deltaC, -4.0*P*S*deltaC,                          0]
[                     0,               0,                -1.0*deltaF]
 
 
Jacobian at equilibrium:  
[ -deltaS, 0,       0]
[       0, 0,       0]
[       0, 0, -deltaF]
 
 
Eigenvalues at equilibrium:
[ -1.0*deltaF,                                   0,                                 0]
[           0, - 0.5*deltaS - 0.5*(deltaS^2)^(1/2),                                 0]
[           0,                                   0, 0.5*(deltaS^2)^(1/2) - 0.5*deltaS]

p0 = [0.1,0.1,0.1];
[t,Y] = ode23s(@lung,0:.1:100,p0,[]);

figure(4)
hold off

subplot(1,3,1)
plot(Y(:,1),Y(:,2))

subplot(1,3,2)
plot(Y(:,1),Y(:,3))

subplot(1,3,3)
plot(Y(:,2),Y(:,3))


p0 = [0.01,0.01,0.01];
[t,Y] = ode23s(@lung,0:.01:10,p0,[]);

figure(1)
clf
hold on

plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))

figure(4)

subplot(1,2,1)
hold on
plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))

subplot(1,2,2)
hold on
plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))





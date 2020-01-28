% CAVITIES DOMAIN

clear
clc

syms S P F rhoS

rhoS = 0;
rhoP = 0; 
rhoF = 0;
deltaS = 0.2; 
deltaP = 0; 
deltaF = 5;
deltaC = 0; 
n = 2;
v = 0; 

syms deltaS deltaF

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

% Equilibrium:  
% [ 0, 0, 0]
%  
%  
% Jacobian:  
% [ -1.0*deltaS, 0,           0]
% [           0, 0,           0]
% [           0, 0, -1.0*deltaF]
%  
%  
% Jacobian at equilibrium:  
% [ -deltaS, 0,       0]
% [       0, 0,       0]
% [       0, 0, -deltaF]
%  
%  
% Eigenvalues at equilibrium:
% [ 0,           0,           0]
% [ 0, -1.0*deltaF,           0]
% [ 0,           0, -1.0*deltaS]

p0 = [0.1,0,0.1];
[t,Y] = ode23s(@lung,0:.1:1000,p0,[]);

% figure(5)
% hold off

subplot(1,3,1)
plot(Y(:,1),Y(:,2))

subplot(1,3,2)
plot(Y(:,1),Y(:,3))

subplot(1,3,3)
plot(Y(:,2),Y(:,3))


p0 = [0.01,0,0.01];
[t,Y] = ode23s(@lung,0:.1:10,p0,[]);

figure(3)
clf
hold on

plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))

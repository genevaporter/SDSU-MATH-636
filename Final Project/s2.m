% MESENCHYME DOMAIN

clear
clc

syms S P F 

rhoS= 0;
rhoP = 0.6; 
rhoF = 3.5;
deltaS = 0.2; 
deltaP = 1; 
deltaF = 5;
deltaC = 1.6; 
n = 2;
v = 5; 

syms rhoP rhoF deltaS deltaP deltaF deltaC v

dS(S,P,F) = rhoS*(F^n)/(F^n+1) - deltaS*S - deltaC*P^2*S;
dP(S,P,F) = rhoP - deltaP*P + (v-2*deltaC)*P^2*S;
dF(S,P,F) = rhoF*(1)/((P^2*S)^n+1)-deltaF*F;
dydt(S,P,F) = [dS; dP; dF];

sol = solve(dydt==[0;0;0],rhoP>=0,rhoF>=0,deltaS>=0,deltaP>=0,deltaF>=0,deltaC>=0,v>=0,[S,P,F],'Real',true);
equ = [vpa(sol.S),vpa(sol.P),vpa(sol.F)];
J(S,P,F) = [diff(dydt,S),diff(dydt,P),diff(dydt,F)];
[E,V] = eig(J);
V(S,P,F) = V;

simplify(vpa(equ))
simplify(vpa(J))
J(equ(1),equ(2),equ(3))
simplify(vpa(V(equ(1),equ(2),equ(3))))




% Equilibrium:  
% [ 0, rhoP/deltaP, rhoF/deltaF]
%  
%  
% Jacobian:  
% [               - deltaC*P^2 - deltaS,                             -2.0*P*S*deltaC,           0]
% [       -1.0*P^2*(2.0*deltaC - 1.0*v), - 1.0*deltaP - 2.0*P*S*(2.0*deltaC - 1.0*v),           0]
% [ -(2.0*P^4*S*rhoF)/(P^4*S^2 + 1.0)^2,       -(4.0*P^3*S^2*rhoF)/(P^4*S^2 + 1.0)^2, -1.0*deltaF]
%  
%  
% Jacobian at equilibrium:  
% [ - deltaS - (deltaC*rhoP^2)/deltaP^2,       0,       0]
% [   -(rhoP^2*(2*deltaC - v))/deltaP^2, -deltaP,       0]
% [                                   0,       0, -deltaF]
%  
%  
% Eigenvalues at equilibrium:
% [ -1.0*deltaF,                                                                                                                                    0,                                                                                                                                  0]
% [           0, - 0.5*deltaP - 0.5*deltaS - 0.5*((- 1.0*deltaP^3 + deltaS*deltaP^2 + deltaC*rhoP^2)^2/deltaP^4)^(1/2) - (0.5*deltaC*rhoP^2)/deltaP^2,                                                                                                                                  0]
% [           0,                                                                                                                                    0, 0.5*((- 1.0*deltaP^3 + deltaS*deltaP^2 + deltaC*rhoP^2)^2/deltaP^4)^(1/2) - 0.5*deltaS - 0.5*deltaP - (0.5*deltaC*rhoP^2)/deltaP^2]
% 


p0 = [0,0,0];
[t,Y] = ode23s(@lung,0:.1:10,p0,[]);

figure(2)
clf
hold on

plot(t,Y(:,1))
plot(t,Y(:,2))
plot(t,Y(:,3))


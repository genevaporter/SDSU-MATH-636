function dydt = lung(t,y)

% % Epithelia domain parameters (1)
% rhoS = 1600;
% rhoP = 0; 
% rhoF = 0;
% deltaS = 0.2; 
% deltaP = 0; 
% deltaF = 5;
% deltaC = 1.6; 
% n = 2;
% v = 0; 

% Mesenchyme domain parameters (2)
rhoS= 0;
rhoP = 0.6*0.7; 
rhoF = 3.5*0.7;
deltaS = 0.2*1.5; 
deltaP = 1*1.5; 
deltaF = 5*1.5;
deltaC = 1.6*1.5; 
n = 2;
v = 5*2; 


% % Cavity domain parameters (3)
% rhoS = 0;
% rhoP = 0; 
% rhoF = 0;
% deltaS = 0.2; 
% deltaP = 0; 
% deltaF = 5;
% deltaC = 0; 
% n = 2;
% v = 0; 

tmp1 = rhoS*(y(3)^n)/(y(3)^n+1) - deltaS*y(1) - deltaC*y(2)^2*y(1);
tmp2 = rhoP - deltaP*y(2) + (v-2*deltaC)*y(2)^2*y(1);
tmp3 = rhoF*(1)/((y(2)^2*y(1))^n+1)-deltaF*y(3);
dydt = [tmp1; tmp2; tmp3];

end

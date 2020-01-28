function dJ = J(t,y)
%J Summary(2) of this function goes here
%   Detailed ey(2)(1)planation goes here
rhoS = 1600; 
rhoP = 0.65; 
rhoF = 3.5;
deltaS = 0.2; 
deltaP = 1; 
deltaF = 5;
deltaC = 1.6; 
v = 5; 
n = 2;

dx = [-deltaS-deltaC*y(2)^2, -2*deltaC*y(2)*y(1), rhoS*(n*y(3)^(n-1))/(y(3)^n+1)^2];
dy = [(v-2*deltaC)*y(2)^2, -deltaP+2*(v-2*deltaC)*y(2)*y(1),0];
dz = [rhoF*n*(y(2)^2*y(1))^n*y(1)^(-1)/((y(2)^2*y(1))^n+1)^2, rhoF*2*n*(y(2)^2*y(1))^n*y(2)^(-1)/((y(2)^2*y(1))^n+1)^2,-deltaF];

dJ = [dx; dy; dz];


end


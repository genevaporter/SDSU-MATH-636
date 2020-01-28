clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART A - DON'T RUN ALL AT ONCE, STOP AT EACH BAR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms x1 x2 x3

a1 = 1; a2 = 1; a3 = 1;
b1 = 0.5; b2 = 0.5; b3 = 0.5;
k1 = 1; k2 = 1;

dx1 = a1/(1+k1*x3^2)-b1*x1;
dx2 = a2*x1^2/(1+k2*x1^2)-b2*x2;
dx3 = a3*x2-b3*x3;
dxdt = [dx1;dx2;dx3];

equ = vpasolve(dxdt==[0;0;0],[x1,x2,x3]);
equ = [vpa(equ.x1), vpa(equ.x2), vpa(equ.x3)];
j(x1,x2,x3) = [diff(dxdt,x1),diff(dxdt,x2), diff(dxdt,x3)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FOR REAL EQUILIBRIUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

e1 = equ(3,:); % only third equilibrium was real
j1 = j(e1(1),e1(2),e1(3));
ev1 = eig(j1);

% AS NEEDED

% e2 = equ(2,:);
% j2 = j(e2(1),e2(2),e2(3));
% ev2 = eig(j2);
% 
% e3 = equ(3,:);
% j3 = j(e3(1),e3(2),e3(3));
% ev3 = eig(j3);
% 
% e4 = equ(4,:);
% j4 = j(e4(1),e4(2),e4(3));
% ev4 = eig(j4);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms r lambda

j_delay = j1;
j_delay(1,3) = j_delay(1,3)*exp(-lambda*r); % location of delay term in jacobian matrix
char = j_delay-eye(3,3)*lambda; 
chareq(lambda)= char(1,1)*(char(2,2)*char(3,3) - char(2,3)*char(3,2)) - ...
                char(1,2)*(char(2,1)*char(3,3) - char(2,3)*char(3,1)) + ...
                char(1,3)*(char(2,1)*char(3,2) - char(2,2)*char(3,1));
chareq(lambda) = simplify(vpa(chareq)); % characteristic equation

syms X Y
trans(X,Y) = chareq(X+1i*Y);
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRANSFER trans INTO rectangleIW FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% slow way 
% a = 3.0*X*Y^2 - 0.75*X - 1.5*X^2 - 1.0*X^3 + 1.5*Y^2 - 0.21373622457047016016942537342938*exp(-1.0*X*r)*cos(-Y*r) - 0.125;
% b =  - Y*0.75i - X*Y*3.0i - X^2*Y*3.0i + Y^3*1.0i - 0.21373622457047016016942537342938*exp(-1.0*X*r)*sin(-Y*r);

% for case r = 1
figure(1)
rectangleIW(1,4,3)

% for case r = 5
figure(2)
rectangleIW(5,4,3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% lambda = iw

syms w
hopf(lambda) = chareq;
hopfB = hopf(w*1i);

% separate into real and imaginary values

rH = real(hopfB);
iH = imag(hopfB);

H = [rH;iH];
bifurcation = vpasolve(H,1);
r_w = [bifurcation.r bifurcation.w];













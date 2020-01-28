function rectangleIW(r,p,q)

% Maps a rectangle bound by the lines  x = [0,p] and y = [-q,q]
% k = time delay value
% p = x_max
% q = y_max

h=p/100;
l=q/50;

x(1) = 0;
y(1) = q;

syms X Y
hopf(X,Y) = - 0.21373622457047016016942537342938*exp(-1.0*r*(X + Y*1i)) - 1.0*(X + 0.5 + Y*1i)^3;
a(1) = real(hopf(x(1),y(1)));
b(1) = imag(hopf(x(1),y(1)));

% slow way 
% a = 3.0*X*Y^2 - 0.75*X - 1.5*X^2 - 1.0*X^3 + 1.5*Y^2 - 0.21373622457047016016942537342938*exp(-1.0*X*r)*cos(-Y*r) - 0.125;
% b =  - Y*0.75i - X*Y*3.0i - X^2*Y*3.0i + Y^3*1.0i - 0.21373622457047016016942537342938*exp(-1.0*X*r)*sin(-Y*r);

for i=2:401 % from upper left to lower left corner
    
    if i < 102
        x(i) = 0;
        y(i) = y(i-1)-l;
    elseif i < 202
        x(i) = x(i-1)+h;
        y(i) = -q;    
    elseif i < 302
        x(i) = p;
        y(i) = y(i-1)+l;
    elseif i < 402
        x(i) = x(i-1)-h;
        y(i) = q;
    end
    a(i) = real(hopf(x(i),y(i)));
    b(i) = imag(hopf(x(i),y(i)));
%     a(i) = - 2.9599812658372417083981159125666*x(i) - 0.50090497222634999511060444065122*exp(-r*x(i))*cos(r*y(i)) + ...
%         1.4419027612506852474450335260828*x(i)*exp(-r*x(i))*cos(r*y(i))- 0.19621028573455131226327780231299 + ...
%         y(i)*exp(-r*x(i))*1.4419027612506852474450335260828*sin(r*y(i));
% 
%     b(i)  = - y(i)*2.9599812658372417083981159125666 + 0.50090497222634999511060444065122*exp(-r*x(i))*sin(r*y(i)) - ...
%         1.4419027612506852474450335260828*x(i)*exp(-1.0*r*x(i))*sin(r*y(i)) + y(i)*exp(-r*x(i))*1.4419027612506852474450335260828*cos(r*y(i));
end
hold on
grid on
plot(a(1:101),b(1:101));
plot(a(101:201),b(101:201));
plot(a(201:301),b(201:301));
plot(a(301:401),b(301:401));




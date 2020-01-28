function delay_rec(k,p,q)

% Maps a rectangle bound by the lines  x = [0,p] and y = [-q,q]
% k = time delay value
% p = x_max
% q = y_max

h=p/100;
l=q/50;

x(1) = 0;
y(1) = q;
a(1) = 3.0*x(1)*y(1)^2+-0.182131947240132*exp(-k*x(1))*(cos(-y(1)*k))- 0.65*x(1) - 1.6*x(1)^2 - 1.0*x(1)^3 + 1.6*y(1)^2- 0.05;
b(1) = - y(1)*0.65 - x(1)*y(1)*3.2  +-0.182131947240132*exp(-k*x(1))*sin(-y(1)*k) - x(1)^2*y(1)*3.0  + y(1)^3*1.0;
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
    a(i) = 3.0*x(i)*y(i)^2+-0.182131947240132*exp(-k*x(i))*(cos(-y(i)*k))- 0.65*x(i) - 1.6*x(i)^2 - 1.0*x(i)^3 + 1.6*y(i)^2- 0.05;
    b(i) = - y(i)*0.65 - x(i)*y(i)*3.2  +-0.182131947240132*exp(-k*x(i))*sin(-y(i)*k) - x(i)^2*y(i)*3.0  + y(i)^3*1.0;
end
hold on
grid on
plot(a(1:101),b(1:101));
plot(a(101:201),b(101:201));
plot(a(201:301),b(201:301));
plot(a(301:401),b(301:401));



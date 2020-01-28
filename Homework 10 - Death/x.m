% Delay Differential Equation Solutions for Goodwin Model

history = [double(e3(1));double(e3(2));double(e3(3))];

figure(1)

subplot(1,2,1)
k=double(solK);
sol = dde23('lags',k,history,[0,10]);
plot(sol.x,sol.y)
grid on
legend('{\itm(t)}','{\itp(t)}','{\itr(t)}');
title('{\itk = 1}');
xlabel('{\itt}');
ylabel('{\itm(t)}, {\itp(t)}, {\itr(t)}');

subplot(1,2,2)
k=4;
sol = dde23('lags',k,history,[0,10]);
plot(sol.x,sol.y)
grid on
legend('{\itm(t)}','{\itp(t)}','{\itr(t)}');
title('{\itk = 4}');
xlabel('{\itt}');
ylabel('{\itm(t)}, {\itp(t)}, {\itr(t)}');






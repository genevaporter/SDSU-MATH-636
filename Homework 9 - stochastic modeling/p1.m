clear
clc

% squirrel transition matrix
%   [ red    gray   both  neither ]
T = [0.8797 0.0382 0.0527 0.0008  % red
     0.0212 0.8002 0.0041 0.0143  % gray
     0.0981 0.0273 0.8802 0.0527  % both
     0.0010 0.1343 0.0630 0.9322];% neither
 
 % equilibrium distribution
[vector,value] = eig(T^5);
[row,column] = find(round(value,1)==1);
prob = vector(:,column)/(sum(vector(:,column)));

% % Gerschgorin circles
% for i=1:4
%     r(i)=sum(T(i,:))-T(i,i);
%     c(i) = T(i,i);
% end
% figure(1)
% clf
% hold on
% for i=1:4
%     f = @(x) sqrt(-(x-c(i)).^2+(r(i)).^2);
%     t = [linspace(c(i)-r(i),c(i)+r(i),1000)]';
%     plot(t,f(t));
%     plot(t,-f(t));
% end
%  
 
 
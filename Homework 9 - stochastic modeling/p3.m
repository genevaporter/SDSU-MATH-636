clear
clc

format short g

% age           0-1     1-2     2-3     3-4
% birth rate    0       1.5     2.2     3.4
% survival      0.4     0.7     0.75    0

L = [  0    1.5  2.2  3.4
      0.4    0    0    0
       0    0.7   0    0
       0     0   0.75  0  ];
   
[E,V] = eig(L);
[i,j] = find(max(V,[],'all'));
growthRate = V(i,j);
popDist = abs(E(:,j)/sum(E(:,j)));

p0 = round(100*popDist)';
pop = sum(p0);
years = 0;
while pop < 200
    p0 = L.*p0;
    pop = sum(p0);
    years = years+1;
end
years;

syms x r
L2(x) =[  0    1.5    2.2  3.4
         0.4    0      0    0
          0   0.7*x    0    0
          0     0   0.75*x  0  ];
[E2,V2] = eig(L2);

lambda1(r) = root(r^4-.6*r^2-.616*x*r-.714*x^2,r,1);

X=solve(lambda1(r)==1,x);
alpha = max(double(X));
E3 = E2(alpha);
popD = vpa(round(10000000*E3(:,4)/sum(E3(:,4))))/10000000;
total = vpa(solve(550==popD(4)*x,x));
population = total.*popD;
harvest = sum(L*population-L2(alpha)*population);

    
    
    
    
    
    
    
    




  

clear
clc
 
survival = [175 237 258 311
            42  59  89  92
            97  104 128 145]; 
syms x
for i=1:2
    if i==1
        for j = 1:3
            a(i,j) = (survival(i+1,j+1))/survival(i,j);
        end
    else
        for j = 1:3
            a(i,j) = solve((survival(i,j)*x+survival(i+1,j)*x)==survival(i+1,j+1));
        end
    end
end
sRates = mean(a,2);
     
nesting = [38  47  66  74
           199 211 245 293];
for i=1:2
    for j=1:4
        b(i,j) = nesting(i,j)/survival(i+1,j);
    end
end
nRates = mean(b,2);

b2 = nRates(1);
b3 = nRates(2);
s12 = sRates(1);
s33 = sRates(2);
syms p1 p2 p3
L = [ 0   b2  b3
      s12 0   0
      0   s33 s33];
Lx(p1,p2,p3) = L*[p1;p2;p3];
p0 = zeros(3,4);
p0(:,1) = [311 92 145]';
for i=1:3
    p0(:,i+1) = Lx(p0(1,i),p0(2,i),p0(3,i));
end
 
[E,V]=eig(L);
E = real(E);
V = real(V);
growth = max(V,[],'all');
[i,j]=find(V==growth);
popD = E(:,j)/sum(E(:,j));

popT = 100*popD;
years = 0;
while popT<200
    years = years + 1;
    popT = sum(Lx(p0(1),p0(2),p0(3)));
end

L
p0
V
E
popD
years

     
     
     
     
     
     
clear
clc

syms dA dM dE f1 f2 A M E

a = 0.8;
alpha1 = 20;
alpha2 = 2;

B = 1;
beta1 = 1;
beta2 = 0.1;
beta_delta = 1;

deltaM = 0.01;
deltaE = 0.3;
deltap = 1.5;

k1 = 2;
k2 = 1;

m = 3;
n = 2;
R = 50;

sigma = 0.02;
epsilon = 1;

p = R*B*E/deltap;
f1 = p^n/(k1^n+p^n);
f2 = a*k2^m/(k2^m+p^m);

dA(A,M,E) = simplify((sigma+alpha1*M)*f1-beta_delta*A-epsilon*A^2);
dM(A,M,E) = simplify(beta1*f2*A-f1*alpha2*M-deltaM*M);
dE(A,M,E) = simplify(beta2*(1-f2)*A-deltaE*E);


S = vpasolve(dA==0,dM==0,dE==0);
EQ = zeros(15,3);
Equilibria = zeros(2,3);

for i=1:15
    if isreal(S.A(i))&& isreal(S.M(i)) && isreal(S.E(i)) 
        EQ(i,:)=[S.A(i),S.M(i),S.E(i)];
    end
end

x = 1;

for i=1:length(EQ(:,1))
    if EQ(i,1)>0 && EQ(i,2)>0  && EQ(i,3)>0
        Equilibria(x,:) = EQ(i,:);
        x = x+1;
    end
end
        

syms systemD EV j
systemD(A,M,E) = [dA;dM;dE];

J = [diff(dA,A),diff(dA,M),diff(dA,E);
    diff(dM,A),diff(dM,M),diff(dM,E);
    diff(dE,A),diff(dE,M),diff(dE,E)];

E1 = [0 0 0]
EV1 = sort(vpa(eig(J(0,0,0))))

E2 = vpa(Equilibria(1,:))
EV2 = sort(vpa(eig(J(Equilibria(1,1),Equilibria(1,2),Equilibria(1,3)))))

E3 = vpa(Equilibria(2,:))
EV3 = vpa(eig(J(Equilibria(2,1),Equilibria(2,2),Equilibria(2,3))))


























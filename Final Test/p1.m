clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART A - find populatino over 100 days

%parameters
b1 = 15;
cea = 0.002;
cel = 0.005;
cpa = 0.03;
sa = 0.5;
sl = 0.4;

p0 = [0 0 2]; % initial conditions
p = zeros(10,3); % for storing population values

for i = 1:100 % iterating function for population
    tmp1 = b1*p0(3)/(1+cea*p0(3)+cel*p0(1))^4;
    tmp2 = sl*p0(1);
    tmp3 = p0(2)/(1+cpa*p0(3))^4+sa*p0(3);
    p0 = [tmp1 tmp2 tmp3];
    p(i,:) = p0;
end

figure(1) % time series plot
clf
t = 0:1:100; 
plot(t,[0;p(:,1)],t,[0;p(:,2)],t,[2;p(:,3)]);

n = 10:10:100; % times
p = p(n,:)'; % population at time n
n = [n;p(1,:);p(2,:);p(3,:)]' % population at times



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART B - stability analysis

syms L P A
Ln1 = b1*A/(1+cea*A+cel*L)^4;
Pn1 = sl*L;
An1 = P/(1+cpa*A)^4+sa*A;
dt = [Ln1;Pn1;An1];

sol = solve(dt==[L;P;A],[L,P,A]); % equilibria
e15 = [double(sol.L),double(sol.P),double(sol.A)]; % extracted equilibria

j(L,P,A) = [diff(dt,L),diff(dt,P),diff(dt,A)]; % jacobian

len = length(e15(:,1)); % number of equilibria
ev15 = zeros(3,1,len);
for i=1:len % eigenvalues for each equilibria
    je = j(e15(i,1),e15(i,2),e15(i,3));
    ev15(:,:,i) = eig(je);
end

% limiting age structure
for i=1:len
    pop15(i,:) = e15(i,:)/sum(e15(i,:)); % normalize population equilibria
end

pop15
e15
ev15


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART C

b2 = 28.180075;
Ln1(L,P,A)= b2*A/(1+cea*A+cel*L)^4;
dt = [Ln1;Pn1;An1];

p0 = [0 0 2]; % initial conditions
p = zeros(10,3); % for storing population values

for i = 1:100 % iterating function
    tmp1 = b2*p0(3)/(1+cea*p0(3)+cel*p0(1))^4;
    tmp2 = sl*p0(1);
    tmp3 = p0(2)/(1+cpa*p0(3))^4+sa*p0(3);
    p0 = [tmp1 tmp2 tmp3];
    p(i,:) = p0;
end

figure(2)
clf
t = 0:1:100;
plot(t,[0;p(:,1)],t,[0;p(:,2)],t,[2;p(:,3)]);

n = 10:10:100; % times
p = p(n,:)';
n = [n;p(1,:);p(2,:);p(3,:)]' % population at times

sol = solve(dt==[L;P;A],[L,P,A]); % equilibrium
e30 = [double(sol.L),double(sol.P),double(sol.A)]; %extracted equilibria
j(L,P,A) = [diff(dt,L),diff(dt,P),diff(dt,A)]; % jacobian

len = length(e30(:,1));
ev30 = zeros(3,1,len);
for i=1:len % eigenvalues for each equilibria
    je = j(e30(i,1),e30(i,2),e30(i,3));
    ev30(:,:,i) = eig(je);
end

for i=1:len
    pop30(i,:) = e30(i,:)/sum(e30(i,:));
end

pop30
e30
ev30

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART D
% 
% FIND JACOBIAN AS EVAL FUNCTION
% use midpoint method to find b


% for i = 1:100 % find b that makes eigenvalue 1 (bisection method)
%     bval = (b1+b2)/2; %
%     Ln1(L,P,A)= bval*A/(1+cea*A+cel*L)^4; %
%     dt = [Ln1;Pn1;An1]; %
%     sol = solve(dt==[L;P;A],[L,P,A]); %
%     eb = [(vpa(sol.L)),(vpa(sol.P)),(vpa(sol.A))]; %
%     j(L,P,A) = [diff(dt,L),diff(dt,P),diff(dt,A)];
%     je = j(eb(1,1),eb(1,2),eb(1,3));
%     eval = eig(je); % check to make sure 3rd eigenvalue is going toward 1
%     if abs(eval(3)) < 1
%         b1 = bval;
%     elseif abs(eval(3)) > 1
%         b2 = bval;
%     else
%         break
%     end
% end
% 
% bval















% ANSWERS

% n =
% 
%                         10          53.1899003114143          46.0491208489375          13.3144625067948
%                         20          54.9978837291345           28.770467870899           12.328706302448
%                         30          58.2155563393439          26.5804762478807          12.7603942380866
%                         40          59.9511121615258          25.6041668025958            12.96564274384
%                         50           60.879797279135          25.1441041641502           13.057731565416
%                         60          61.3664744280768          24.9269749933328          13.0969801182445
%                         70          61.6160526554595          24.8257356606611          13.1127316078393
%                         80          61.7414884888383          24.7793912730041          13.1185367718279
%                         90          61.8033439053964          24.7586665443409          13.1203721324698
%                        100          61.8332820367822          24.7496677952685           13.120753358974
% 
% 
% pop15 =
% 
%          0.620310429988512         0.248124171995405         0.131565398016083
%                        NaN                       NaN                       NaN
% 
% 
% e15 =
% 
%           61.8593732140893          24.7437492856357          13.1201293166839
%                          0                         0                         0
% 
% 
% ev15(:,:,1) =
% 
%           0.530787728623983 +                     0i
%          -0.761009581269247 +     0.537427454368604i
%          -0.761009581269247 -     0.537427454368604i
% 
% 
% ev15(:,:,2) =
% 
%                           2 +                     0i
%                       -0.75 -       1.5612494995996i
%                       -0.75 +       1.5612494995996i
% 
% 
% n =
% 
%                         10          158.191452570935          25.1712495799581          20.5044735628368
%                         20          69.2270863617425          49.3285117731788          14.2043815212403
%                         30          107.690430037791          30.4336624992012          18.6528440155836
%                         40          100.908669624374          38.5762213505966          15.0344453962744
%                         50          76.8429116187478          43.5429111711265          15.2489409889802
%                         60          110.057130790495          30.7489384919367          17.8342714351436
%                         70          93.0960830385674          40.9791214627565          14.7602182818483
%                         80           81.803969239483          40.6608432396487          15.9084493315998
%                         90          110.714862419355          31.4124593613709          17.2477276130293
%                        100          87.8548277867785          42.5026747760788          14.6319615431486
% 
% 
% pop30 =
% 
%          0.637371766844143         0.254948706737657           0.1076795264182
%                        NaN                       NaN                       NaN
% 
% 
% e30 =
% 
%           93.7503712906908          37.5001485162763          15.8384730972569
%                          0                         0                         0
% 
% 
% ev30(:,:,1) =
% 
%           0.451612448429158 +                     0i
%          -0.922734845896031 +     0.402751284289493i
%          -0.922734845896031 -     0.402751284289493i
% 
% 
% ev30(:,:,2) =
% 
%            2.46881367529028 +                     0i
%          -0.984406837645138 +      1.97270811415491i
%          -0.984406837645138 -      1.97270811415491i




















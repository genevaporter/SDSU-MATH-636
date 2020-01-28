clear
clc

%      r1   r2   r3   r4
T = [ 0.42 0.16 0.19 0.16   % r1
      0.07 0.38 0.24 0.13   % r2
      0.34 0.19 0.51 0.27   % r3
      0.17 0.27 0.06 0.44 ];% r4
syms x1 x2 x3 x4
f(x1,x2,x3,x4) = T*[x1;x2;x3;x4];

% expected distribution over n number of days
p0 = [100 0 0 0];
n = 10;
d = zeros(4,n);
for i = 1:n
    p0 = double(f(p0(1),p0(2),p0(3),p0(4)));
    d(:,i) = p0;
end
day1 = d(:,1)'
day2 = d(:,2)'
day5 = d(:,5)'
day10 = d(:,10)'

% distribution over a long period of time
[e,v] = eig(T^5);
[~,j] = find(round(v,1)==1);
edist = abs(e(:,j)/(sum(e(:,j))))

% Monte Carlo simulation

s = 1000; % number of simulations
A = zeros(10,5,s); % for storing values of each simulation
for i = 1:s
    change = zeros(10,5); % population in each region each day
    p0 = [100 0 0 0]; % starting populations 
    for j = 1:10 % for 10 days
        temp = zeros(1,4); % stores values for day 'j'
        for k = 1:4 % for each region 'k'
            [B,I] = sort(T(:,k));
            for m = 1:p0(k) % each individual 'm' in region 'k'
                r = rand; % determines where an individual will move
                if r <= B(1) % assigns individual to a region
                    temp(I(1)) = temp(I(1))+1;
                elseif r <= B(2)+B(1)
                    temp(I(2)) = temp(I(2))+1;
                elseif r <= B(3)+B(2)+B(1)
                    temp(I(3)) = temp(I(3))+1;
                else
                    temp(I(4)) = temp(I(4))+1;
                end
            end              
        end 
        p0 = temp; % new population for next day
        change(j,:) = [j,p0];
    end 
    A(:,:,i) = change;  
end
A = cat(1,A(1:2,:,:),A(5,:,:),A(10,:,:));
meanA = mean(A,3)
stdA = std(A,0,3)




















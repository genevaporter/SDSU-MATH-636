clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% die weightes toward 6
syms w
p = solve(4*w+2*w+.5*w==1,w); % solve for probability distribution
d1 = [ .5*p p p p p 2*p]; % probability of die 1 landing on [ 1 2 3 4 5 6]
d2 = fliplr(d1); % probability of die 2 landing on [ 1 2 3 4 5 6]
a = 0;

% analytical results
roll_light = vpa(0.5*p) % roll a off-weighted side
roll_weight = vpa(2*p) % roll a weighted side
roll_7_fair = vpa(6/36) % roll a 7 with fair die
roll_7_weighted = vpa(d1(1)^2+d1(2)^2*4+d1(6)^2) % roll a 7 with weighted die


sims = 3; % nuber of simulations to run
sevens = zeros(sims,1);

for simulations = 1:sims
    for n = 1:10000

        roll1 = rand;
        roll2 = rand;

        if roll1 <= p*(0.5)
            r1 = 1;
        elseif roll1 <= p*(1.5)
            r1 = 2;
        elseif roll1 <= p*(2.5)
            r1 = 3;
        elseif roll1 <= p*(3.5)
            r1 = 4;
        elseif roll1 <= p*(4.5)
            r1 = 5;
        else
            r1 = 6;
        end

        if roll2 <= p*(2)
            r2 = 1;
        elseif roll2 <= p*(3)
            r2 = 2;
        elseif roll2 <= p*(4)
            r2 = 3;
        elseif roll2 <= p*(5)
            r2 = 4;
        elseif roll2 <= p*(6)
            r2 = 5;
        else
            r2 = 6;
        end

        if r1+r2 == 7
            a = a+1;
        end
    end
    sevens(simulations) = a;
    a = 0;
end

simulated_7 = vpa(sevens/n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

number_of_simulations = 3;
number_of_rolls = 10000;
stats = zeros(10000,3);
for i = 1:number_of_simulations
    for j = 1:number_of_rolls
        sums = 0;
        for k = 1:2 % roll each dice twice
            roll1 = rand;
            roll2 = rand;
            if roll1 <= p*(0.5)
                r1 = 1;
            elseif roll1 <= p*(1.5)
                r1 = 2;
            elseif roll1 <= p*(2.5)
                r1 = 3;
            elseif roll1 <= p*(3.5)
                r1 = 4;
            elseif roll1 <= p*(4.5)
                r1 = 5;
            else
                r1 = 6;
            end
            if roll2 <= p*(2)
                r2 = 1;
            elseif roll2 <= p*(3)
                r2 = 2;
            elseif roll2 <= p*(4)
                r2 = 3;
            elseif roll2 <= p*(5)
                r2 = 4;
            elseif roll2 <= p*(6)
                r2 = 5;
            else
                r2 = 6;
            end
            sums = sums + r1 + r2;
        end
        stats(j,i) = sums;
    end
end

W_average_sum = [mean(stats(:,1));mean(stats(:,2));mean(stats(:,3))]
W_std_sum = [std(stats(:,1));std(stats(:,2));std(stats(:,3))]

number_of_simulations = 3;
number_of_rolls = 10000;
stats = zeros(10000,3);
x = vpa(1/6)
for i = 1:number_of_simulations
    for j = 1:number_of_rolls
        sums = 0;
        for k = 1:4 % roll one die 4 times
            roll1 = rand;
            if roll1 <= x
                r1 = 1;
            elseif roll1 <= x*2
                r1 = 2;
            elseif roll1 <= x*3
                r1 = 3;
            elseif roll1 <= x*4
                r1 = 4;
            elseif roll1 <= x*5
                r1 = 5;
            else
                r1 = 6;
            end            
            sums = sums + r1;
        end
        stats(j,i) = sums;
    end
end

F_average_sum = [mean(stats(:,1));mean(stats(:,2));mean(stats(:,3))]
F_std_sum = [std(stats(:,1));std(stats(:,2));std(stats(:,3))]







% ANSWERS

% roll_light =
%  
% 0.076923076923076923076923076923077
%  
%  
% roll_weight =
%  
% 0.30769230769230769230769230769231
%  
%  
% roll_7_fair =
%  
% 0.16666666666666666666666666666667
%  
%  
% roll_7_weighted =
%  
% 0.19526627218934911242603550295858
%  
%  
% simulated_7 =
%  
%  0.1916
%  0.1958
%  0.1948
%  
% 
% W_average_sum =
% 
%                    13.9642
%                    14.0083
%                    14.0035
% 
% 
% W_std_sum =
% 
%           3.35720798351017
%           3.35936893567298
%           3.42427515191632
% 
%  
% x =
%  
% 0.16666666666666666666666666666667
%  
% 
% F_average_sum =
% 
%                    14.0321
%                    14.0017
%                    14.0209
% 
% 
% F_std_sum =
% 
%           3.39464607171278
%           3.40964216245156
%           3.42222651988959











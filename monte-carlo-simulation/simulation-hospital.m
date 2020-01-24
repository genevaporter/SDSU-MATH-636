% Author: Geneva Porter
% V1 Date: 21 November 2018
% Language: MATLAB
%
% This script was created to solve the classic hospital expansion problem
% put forth by Schmitz ans Kwak in their 1971 paper "Monte Carlo 
% Simulation of Operating-Room and Recovery-Room Usage." In this paper, 
% they outline a simulation based on the number of operating rooms and 
% recovery rooms planned for a new hospital wing ICU.

p = input('\n Number of Patients per Day: ');
o = input(' Number of Operating Rooms Available: ');
s = input(' Number of Simulations to Run: ');

A = zeros(s,6); % for storing values from simulations

for x = 1:s
    
    M = zeros(p,12); % time table for surgeries and recovery
    M(:,1) = (1:1:p)'; % patient number
    M(:,2) = round(1000*rand(p,1)); % assigned surgery
    
%     M(:,3) = length of operation
%     M(:,4) = operation begins
%     M(:,5) = operation ends
%     M(:,6) = operating room number
%     M(:,7) = operating room is available for next patient
%     M(:,8) = recovery time needed
%     M(:,9) = recovery Begins
%     M(:,10) = recovery Ends
%     M(:,11) = recovery room number
%     M(:,12) = recovery room is available for next patient

    for i=1:p
        if M(i,2) < 158 % probability distribution for surgery type
            M(i,3) = 0.5; M(i,8) = 1.5; % operation / recovery  time 
        elseif M(i,2) < 242
            M(i,3) = 0.5; M(i,8) = 1.5;
        elseif M(i,2) < 327
            M(i,3) = 0.5; M(i,8) = 0;
        elseif M(i,2) < 385
            M(i,3) = 0.5; M(i,8) = 0;
        elseif M(i,2) < 621
            M(i,3) = 0.75; M(i,8) = 3;
        elseif M(i,2) < 767
            M(i,3) = 1.25; M(i,8) = 3;
        elseif M(i,2) < 857
            M(i,3) = 1.75; M(i,8) = 3;
        elseif M(i,2) < 912
            M(i,3) = 2.25; M(i,8) = 3;
        elseif M(i,2) < 946
            M(i,3) = 2.75; M(i,8) = 3;
        elseif M(i,2) < 967
            M(i,3) = 3.25; M(i,8) = 3;
        elseif M(i,2) < 980
            M(i,3) = 3.75; M(i,8) = 3;
        else
            M(i,3) = 4; M(i,8) = 3;
        end
    end

    for i=1:o % operations when OR first opens
        M(i,4) = 7.5; % operation begins
        M(i,5) = M(i,4)+ M(i,3); % operation ends
        M(i,6) = i; % OR number
        M(i,7) = M(i,5) + .25; % OR is available for next patient
    end
    
    for i = o+1:p % subsequent operations 
        [time0,index0] = min(M(1:i-1,7),[],1); % next operation room ready
        M(i,4) = time0; % operation begins
        M(i,5) = time0 + M(i,3); % operation ends
        M(i,6) = M(index0,6); % OR number
        M(i,7) = M(i,5) + .25; % OR is available for next patient
        M(index0,7) = inf; % available OR time will not repeat
    end

    M(:,9) = M(:,5) + .08*ones(p,1); % Recovery Begins
    M(:,10) = M(:,9) + M(:,8); % Recovery Ends
    M(:,12) = M(:,10) + .25*ones(p,1); % RR is available for next patient
    
    n = inf; % used to weed out patients with no recovery
    
    for i = 1:p
        if M(i,8) == 0 % eliminating patients who don't use a recovery bed
            M(i,9) = n;
            M(i,10) = 0;
            M(i,11) = 0;
            M(i,12) = n;            
        end
    end
    
    rm = 0; % number of recovery rooms needed
    for i = 1:p
        if M(i,8) > 0
            [time1,index1] = min(M(:,9),[],1); % next recovery patient 
            [time2,index2] = min(M(:,12),[],1); % next recovery room 
            if time1 < time2 % there is no used bed available
                rm = rm+1; % new bed is used
                M(index1,11) = rm; % patient is added to new bed
                M(index1,9) = n; % patient will not repeat
            elseif time1 < n % there is a used bed available
                M(index1,11) = M(index2,11); % patient assigned used bed
                M(index1,9) = n; % patient will not repeat
                M(index2,12) = n; % RR ready time will not repeat
            end
        end
    end
    
    % Subbing back values that were previously changed for convenience
    M(:,7) = M(:,5) + .25*ones(p,1);
    M(:,9) = M(:,5) + .08*ones(p,1);
    M(:,12) = M(:,10) + .25*ones(p,1);
    for i = 1:p
        if M(i,8) == 0 
            M(i,9) = 0;
            M(i,12) = 0;
        end
    end

open = ceil(max(M(:,10))); % max nurse shift
T = [(8:1:open-1); (9:1:open); zeros(1,open-8)]'; %patients by hour

for i = 1:length(T) % for each hour that the recovery room is open
    for j = 1:p % for each patient
        if floor(M(j,9)) == T(i,1) % in recovery during ith hour
            T(i,3) = T(i,3)+1/3; % nurse can take 3 patients
            if M(j,8) == 3 % recovery time is 3 hours
                T(i+1:i+2,3) = T(i+1:i+2,3) +[1/3;1/3]; % add next hours
            elseif M(j,8) == 1.5 % recovery time is 1.5 hours
                T(i+1,3) = T(i+1,3) + 1/3; % add next hour
                if floor(M(j,10)) == T(i+2,1) % recovery starts after .5 hrs
                    T(i+2,3) = T(i+2,3) + 1/3; % add next hour
                end
            end
        end
    end
end

T(:,3)=ceil(T(:,3)); % must have an integer number of nurses
for i = 1:length(T) % recovery room must be staffed by at least 2 nurses
    if T(i,3) < 2
        T(i,3) = 2;
    end
end

A(x,1) = max(M(:,5)); % latest time OR is open
A(x,2) = mean(M(:,3)); % average time OR is used
A(x,3) = max(M(:,10)); % latest time recovery room is open
A(x,4) = max(M(:,11)); % recovery beds used
A(x,5) = sum(T(:,3)); % staff hours needed
A(x,6) = max(T(:,3)); % nurses needed at peak times

end

r1 = mean(A(:,1)); std1 = std(A(:,1));
r2 = mean(A(:,2)); std2 = std(A(:,2));
r3 = mean(A(:,3)); std3 = std(A(:,3));
r4 = mean(A(:,4)); std4 = std(A(:,4));
r5 = mean(A(:,5)); std5 = std(A(:,5));
r6 = mean(A(:,6)); std6 = std(A(:,6));

fprintf('\n This hospital sees %d surgical patients per day\n',p);
fprintf(' and uses %d operating rooms. The following are the\n',o);
fprintf(' result of %d simulations: \n\n',s);
fprintf(' The average operating room closure is at %.4f hours, \n',r1);
fprintf(' with a standard deviation of %.4f.\n',std1)
fprintf(' Each operating room is used an average of %.4f hours, \n',r2);
fprintf(' with a standard deviation of %.4f.\n',std2);
fprintf(' The average recovery room closure is at %.4f hours, \n',r3);
fprintf(' with a standard deviation of %.4f.\n', std3);
fprintf(' An average of %.4f beds are used for recovery per day, \n',r4);
fprintf(' with a standard deviation of %.4f.\n', std4);
fprintf(' It takes an average of %.4f staf hours for this ICU, \n',r5);
fprintf(' with a standard deviation of %.4f.\n', std5);
fprintf(' An average of %.4f nurses are needed for peak hours, \n',r6);
fprintf(' with a standard deviation of %.4f.\n', std6);

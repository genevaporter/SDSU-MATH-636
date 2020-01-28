% Author: Geneva Porter
% V1 Date: 21 November 2018
%
% This script was created to solve the classic hospital expansion problem
% put forth by Schmitz ans Kwak in their 1971 paper "Monte Carlo 
% Simulation of Operating-Room and Recovery-Room Usage." In this paper, 
% they outline a simulation based on the number of operating rooms and 
% recovery rooms planned for a new hospital wing ICU.
% 
% Column Explanation:
% Column 1: Patient number
% Column 2: Random number correalting to surgery type
% Column 3: Length of operating 
% Column 4: Time operation begins
% Column 5: Time operation ends 
% Column 6: Operating room number assigned 
% Column 7: Time operating room is available for next patient
% Column 8: Time needed for recovery
% Column 9: Time recovery begins
% Column 10: Time recovery ends
% Column 11: Recovery room number assigned
% Column 12: Time recovery room is available for next patient

of = 4; % lower number of operating rooms available
oc = 5; % high number of operating rooms available

p = 32; % number of patients per day
s = 100; % number of simulations to run
T = zeros(2,16,oc-of+1); % for storing staffing times
A = zeros(s,6,oc-of+1); % for storing values from simulations
M = zeros(p,12,oc-of+1); % time table for surgeries and recovery

% THIS LOOP REPEATS THE SIMULATIONS WITH RANDOM SURGERY TYPES
for x = 1:s  
    rand = round(1000*rand(p,1)); % surgery types for current simulation
    
    % THIS LOOP REPEATS THE SIMULATION FOR DIFFERENT NUMBERS OF OPERATING
    % ROOMS USING THE SAME RANDOM SURGERY TYPES
    for y = 1:oc-of+1
        o = y + of-1;
        M(:,1,y) = (1:1:p)'; % patient number
        M(:,2,y) = rand; % surgery type

        % THIS LOOP ASSIGNS TIME FOR RECOVERY AND SURGERY LENGTH
        for i=1:p
            if M(i,2,y) < 158 
                M(i,3,y) = 0.5; M(i,8,y) = 1.5; 
            elseif M(i,2,y) < 242
                M(i,3,y) = 0.5; M(i,8,y) = 1.5;
            elseif M(i,2,y) < 327
                M(i,3,y) = 0.5; M(i,8,y) = 0;
            elseif M(i,2,y) < 385
                M(i,3,y) = 0.5; M(i,8,y) = 0;
            elseif M(i,2,y) < 621
                M(i,3,y) = 0.75; M(i,8,y) = 3;
            elseif M(i,2,y) < 767
                M(i,3,y) = 1.25; M(i,8,y) = 3;
            elseif M(i,2,y) < 857
                M(i,3,y) = 1.75; M(i,8,y) = 3;
            elseif M(i,2,y) < 912
                M(i,3,y) = 2.25; M(i,8,y) = 3;
            elseif M(i,2,y) < 946
                M(i,3,y) = 2.75; M(i,8,y) = 3;
            elseif M(i,2,y) < 967
                M(i,3,y) = 3.25; M(i,8,y) = 3;
            elseif M(i,2,y) < 980
                M(i,3,y) = 3.75; M(i,8,y) = 3;
            else
                M(i,3,y) = 4; M(i,8,y) = 3;
            end
        end
        
        % THIS LOOP ASSIGNS OPERATING ROOM NUMBERS
        for i = o:p % operating room assignments 
            if i <=o
                M(i,4,y) = 7.5; % operation begins
                M(i,5,y) = M(i,4,y)+ M(i,3,y); % operation ends
                M(i,6,y) = i; % OR number
                M(i,7,y) = M(i,5,y) + .25; % OR is available  
            else
            [time0,index0] = min(M(1:i-1,7,y),[],1); % next OR ready
            M(i,4,y) = time0; % operation begins
            M(i,5,y) = time0 + M(i,3,y); % operation ends
            M(i,6,y) = M(index0,6,y); % OR number
            M(i,7,y) = M(i,5,y) + .25; % OR is available for next patient
            M(index0,7,y) = inf; % available OR time will not repeat
            end
        end

        % THIS LOOP ASSIGNS RECOVERY ROOM NUMBERS
        rm = 0; % number of recovery rooms needed
        for i = 1:p            
            if M(i,8,y) == 0 % eliminating patients with no recovery
                M(i,9,y) = inf;
                M(i,12,y) = inf;            
            elseif M(i,8,y) > 0
                M(i,9,y) = M(i,5,y) + .08; % Recovery Begins
                M(i,10,y) = M(i,9,y) + M(i,8,y); % Recovery Ends
                M(i,12,y) = M(i,10,y) + .25; % RR is available
                [time1,index1] = min(M(:,9,y),[],1); % next RR patient 
                [time2,index2] = min(M(:,12,y),[],1); % next RR 
                if time1 < time2 % there is no used bed available
                    rm = rm+1; % new bed is used
                    M(index1,11,y) = rm; % patient is added to new bed
                    M(index1,9,y) = inf; % patient will not repeat
                elseif time1 < n % there is a used bed available
                    M(index1,11,y) = M(index2,11,y); % patient to used bed
                    M(index1,9,y) = inf; % patient will not repeat
                    M(index2,12,y) = inf; % RR ready time will not repeat
                end
            end
        end
    
        % Subbing back values that were previously changed for convenience
        M(:,7,y) = M(:,5,y) + .25*ones(p,1,y);
        M(:,9,y) = M(:,5,y) + .08*ones(p,1,y);
        M(:,12,y) = M(:,10,y) + .25*ones(p,1,y);
        for i = 1:p
            if M(i,8,y) == 0 
                M(i,9,y) = 0;
                M(i,12,y) = 0;
            end
        end
        
        % THIS LOOP ASSIGNS STAFFING HOURS
        T(1:2,:,y) = [(8:1:23); zeros(1,24-8)]'; %patients by hour
        for i = 1:16 % for each hour that the recovery room is open
            for j = 1:p % for each patient
                if floor(M(j,9,y)) == T(i,1,y) % RR start time
                    T(i,2,y) = T(i,2,y)+1/3; % nurse can take 3 patients
                    if M(j,8,y) == 3 % recovery time is 3 hours
                        T(i+1:i+2,2,y) = T(i+1:i+2,2,y) +[1/3;1/3]; 
                    elseif M(j,8,y) == 1.5 % recovery time is 1.5 hours
                        T(i+1,2,y) = T(i+1,2,y) + 1/3; 
                        if floor(M(j,10,y)) == T(i+2,1,y) 
                            T(i+2,2,y) = T(i+2,2,y) + 1/3; 
                        end
                    end
                end
            end
            T(i,2,y)=ceil(T(i,2,y)); % must have an integer # of nurses
            for j = 1:16 % RR must be staffed by at least 2 nurses
                if T(j,3,y) < 2 && T(j,3,y) > 0
                    T(j,3,y) = 2;
                end
            end 
        end

        A(x,1,y) = max(M(:,5,y)); % latest time OR is open
        A(x,2,y) = mean(M(:,3,y)); % average time OR is used
        A(x,3,y) = max(M(:,10,y)); % latest time recovery room is open
        A(x,4,y) = max(M(:,11,y)); % recovery beds used
        A(x,5,y) = sum(T(:,3,y)); % staff hours needed
        A(x,6,y) = max(T(:,3,y)); % nurses needed at peak times

    end
end

% unfinished, need to account for 3rd dimension
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

function [td,i] = reduct(tdata)
% Data reduction - Repeat t-values
% Finds index and removes time for ODE23
n = length(tdata);
temp = sort(tdata);
td = [temp(1)]; i = [];
for k = 1:n-1
    if (temp(k)==temp(k+1))
        i = [i,k];
    else
        td = [td,temp(k+1)];
     end
 end
 end



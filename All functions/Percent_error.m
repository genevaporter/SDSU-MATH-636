function [PE] = Percent_error(worstdata,bestdata)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    PE = [];
    N = length(worstdata);
    for i=1:N
        perror = (worstdata(i)-bestdata(i))/bestdata(i)*100;
        PE = [PE, perror];
    end
end


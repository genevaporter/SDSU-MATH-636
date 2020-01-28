function [ Rate_List ] = Growth_Rate( population_matrix )
%GROWTH_RATE Summary of this function goes here
%   Detailed explanation goes here

Length=length(population_matrix)-1;
Rate_List=[];

for i=1:Length
   rate=population_matrix(i+1)/population_matrix(i)-1;
   Rate_List=cat(1,Rate_List,rate);
end

end


function [pValues] = Model_Updating_Linear( Updating_Function, p0, iterations )
%MODEL_UPDATING_LINEAR Summary of this function goes here
%   Detailed explanation goes here

pValues=[p0];
i=0;

while i<iterations
    p0=Updating_Function(p0);
    pValues=cat(1,pValues,p0);
    i=i+1;
end

end


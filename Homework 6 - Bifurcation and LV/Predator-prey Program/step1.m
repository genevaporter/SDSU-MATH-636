
% Provides data (td,hare,lynx) and initial parameters (p0)
options = optimset('MaxFunEvals',5000);
[p,fval,exitflag] = fminsearch(@leastcomplv,p0,[],td,hare,lynx);
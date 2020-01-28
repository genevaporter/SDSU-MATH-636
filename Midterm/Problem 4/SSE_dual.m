function J = SSE_dual( p0,tdata,pdata )
%SSE_DUAL Summary of this function goes here
%   p0 = [P(0) r M]

% SOLVE DIFF EQUATION FIRST, PASTE IN

o = p0(1);
r = p0(2);
m = p0(3);

psim = o;

for i=2:length(tdata)
    t = tdata(i);
    pnew = -m/(exp(m*(log(1 - m/o)/m - (r*t)/m)) - 1);
    psim = [psim pnew];
end

err = psim-pdata;
J = err*err';


end


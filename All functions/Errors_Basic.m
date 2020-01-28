function Errors_Basic(xData,yData,yValues,Evaluation_Point)
%ERRORS_BASIC Summary
%   Prints SSE actual error, absolute error, relative error, and percent error

SSE=[];
for i=1:length(yData)
    se=(yData(i)-yValues(i))^2;
    SSE=cat(1,SSE,se);
end

best=yData(Evaluation_Point+1);
worst=yValues(Evaluation_Point+1);

SSE=vpa(sum(SSE),6);
Actual_Error=vpa(worst-best,10);
Absolute_Error=vpa(abs(Actual_Error),6);
Percent_Error=vpa((worst-best)/best*100,6);
Relative_Error=vpa(Percent_Error/100,6);

SSE
Actual_Error
Absolute_Error
Relative_Error
Percent_Error

end


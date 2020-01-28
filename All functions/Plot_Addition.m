function Plot_Addition(Number_Of_Addition_To_Legend_List,Model_Function, xValues,pValues,xLetter,yLetter)
%PLOT_ADDITION 
%   add plot to figure without messing up anything

hold on;
Model_Function=char(vpa(Model_Function,3));

switch Number_Of_Addition_To_Legend_List
    case 1
        plot(xValues,pValues,'--','Color',[0,0,0],'DisplayName',[ yLetter '(' xLetter ') = ' Model_Function]);%first line added to plot
    case 2
        plot(xValues,pValues,':','LineWidth',1,'Color',[0,0,0],'DisplayName',[ yLetter '(' xLetter ') = ' Model_Function]);%second line added to plot
end



end


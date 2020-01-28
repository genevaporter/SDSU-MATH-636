function Plot_Pretty(Title)
%PLOT_PRETTY Summary 
%   Plots scatter of data with best fit line

hold on

t=title(Title);%title of graph
t.FontSize=14;
t.FontWeight='bold';


set(gca,'FontSize',12);
grid on;
box on;


end


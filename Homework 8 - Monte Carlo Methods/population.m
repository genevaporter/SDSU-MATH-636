function stats = population()
%POPULATION 

time = 10;
number = 10000;

growth = zeros(time,2);

simulations = zeros(number,1);

for k = 1:number
    pop = 50;
    for i = 1:time
        for j = 1:pop
            x = rand(1,1);
            if x <= 0.04
                pop = pop+1;
            end
        end
        growth(i,:)=[i pop];
    end
    simulations(k,1) = growth(time,2);
end
        
meanPopulation = mean(simulations(:,1));
stdPopulation = std(simulations(:,1));

stats = [meanPopulation stdPopulation];


end






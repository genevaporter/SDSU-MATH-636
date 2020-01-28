function output = darts(n)
%DARTS Summary
% x =   1. bullseye x <= .5     50
%       2. bullseye ring x <= 1 25
%       3. inner ring x <= 5    *1
%       4. inner edge x <= 5.5  *3
%       5. outer ring x <= 8.5  *1
%       6. outer edge x <= 9    *2
%       7. dead space x <= 12   *0

regions = [.5 1 5 5.5 8.5 9 12];

score = zeros(n+1,4);

for i = 1:n
    
    for j = 1:3
        x = 12*rand(1,1);
        y = 12*rand(1,1);
        radius = sqrt(x^2+y^2);
        
        while radius > 12
            x = 12*rand(1,1);
            y = 12*rand(1,1);
            radius = sqrt(x^2+y^2);
        end
            
        if radius <= regions(1)
            score(i,j) = 50;
        elseif radius <= regions(2)
            score(i,j) = 25;
        elseif radius <= regions(3)
            number = ceil(20*rand(1,1));
            score(i,j) = number;
        elseif radius <= regions(4)
            number = 3*ceil(20*rand(1,1));
            score(i,j) = number;
        elseif radius <= regions(5)
            number = ceil(20*rand(1,1));
            score(i,j) = number;
        elseif radius <= regions(6)
            number = 2*ceil(20*rand(1,1));
            score(i,j) = number;
        end
        score(i,4) = sum(score(i,1:3));
    end
    
meanScore = mean(score(:,4));
stdScore = std(score(:,4));

score(n+1,2) = meanScore;

score(n+1,4) = stdScore;

            
output = [meanScore stdScore];

end


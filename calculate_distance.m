function distance = calculate_distance(x,y)
%CALCULATE_DISTANCE Calculate distance between two 3d points
%  formula is sqrt(sum((y_i - x_i)^2)
sum = 0;
for i = 1:size(x,1)
    step1 = y(i) - x(i);
    step2 = step1*step1;
    sum = sum + step2;
end

distance = sqrt(sum);


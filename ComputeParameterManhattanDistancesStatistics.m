function parameter_manhattan_distances_statistics = ComputeParameterManhattanDistancesStatistics(parameter_responses)

parameter_manhattan_distances_statistics = zeros(82,4);

for i=1:82
    
    parameter_manhattan_distances = zeros([1,100]);
    
    for j=1:9
        absolute_single_parameter_responses(:) = abs(parameter_responses(i,:,j));
        parameter_manhattan_distances = parameter_manhattan_distances + absolute_single_parameter_responses;
    end
    
    parameter_manhattan_distances_statistics(i,1) = mean(parameter_manhattan_distances);
    parameter_manhattan_distances_statistics(i,2) = std(parameter_manhattan_distances);
    parameter_manhattan_distances_statistics(i,3) = quantile(parameter_manhattan_distances,0.25);
    parameter_manhattan_distances_statistics(i,4) = quantile(parameter_manhattan_distances,0.75);
    
end

end
function response_statistics = ComputeResponseStatistics(parameter_responses)

response_statistics = zeros(82,9,3);

for i=1:82
    for j=1:9
        dist(:) = parameter_responses(i,:,j);
        response_statistics(i,j,1) = mean(dist);
        response_statistics(i,j,2) = std(dist);
        response_statistics(i,j,3) = quantile(dist,0.25);
        response_statistics(i,j,4) = quantile(dist,0.75);
    end
end

end
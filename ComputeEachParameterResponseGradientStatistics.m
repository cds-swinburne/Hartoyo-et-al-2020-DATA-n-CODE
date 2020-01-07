function [parameter_response_gradient_statistics] = ComputeEachParameterResponseGradientStatistics(response_statistics, JSDs, order)

parameter_response_gradient_statistics = zeros([9,2]);

for i=1:9
    statistics(:,:) = response_statistics(:,i,1:2);
    [mn, sd] = ComputeGradientStatistics(statistics, JSDs, order);
    parameter_response_gradient_statistics(i,1) = mn;
    parameter_response_gradient_statistics(i,2) = sd;
end

end
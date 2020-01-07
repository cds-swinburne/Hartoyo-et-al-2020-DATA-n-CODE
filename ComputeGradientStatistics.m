function [mn, sd] = ComputeGradientStatistics(statistics, JSDs, order)
    rng(2020);
    num_of_samples = 1e3;
    
    grads = zeros([num_of_samples,1]);
    parfor i=1:num_of_samples
        samples = zeros([82,1]);
        for j=1:82
           samples(j) = statistics(j,2).*randn(1,1) + statistics(j,1); 
        end

        m = ComputeGradient(JSDs(order), samples(order))

        grads(i) = m;
    end
    mn = mean(grads);
    sd = std(grads);
end
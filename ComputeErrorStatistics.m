function error_statistics = ComputeErrorStatistics(unregularized_fitting_errors, regularized_fitting_errors)

error_statistics = zeros([20,3]);

flattened_unregularized_fitting_errors = reshape(unregularized_fitting_errors, [1, 8200]);
error_statistics(1,1) = quantile(flattened_unregularized_fitting_errors,0.16);
error_statistics(1,2) = quantile(flattened_unregularized_fitting_errors,0.50);
error_statistics(1,3) = quantile(flattened_unregularized_fitting_errors,0.84);

for i=2:20
    regularized_fitting_errors_per_lambda(:) = regularized_fitting_errors(:,i-1);
    error_statistics(i,1) = quantile(regularized_fitting_errors_per_lambda,0.16);
    error_statistics(i,2) = quantile(regularized_fitting_errors_per_lambda,0.50);
    error_statistics(i,3) = quantile(regularized_fitting_errors_per_lambda,0.84);
end

end
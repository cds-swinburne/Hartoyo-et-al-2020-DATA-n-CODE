function regularized_fitting_errors = ComputeRegularizedFittingErrors(regularized_best_paramsets, EC_experimental_spectra, EO_experimental_spectra)

regularized_fitting_errors = zeros([82,19]);

for i=1:82
    for j=1:19
        EC_experimental_spectrum(:) = [zeros(1,8) EC_experimental_spectra(i,:)];
        EO_experimental_spectrum(:) = [zeros(1,8) EO_experimental_spectra(i,:)];
        
        paramset(:) = regularized_best_paramsets(i,j,1,:);
        
        [regularized_EC_spectrum, regularized_EO_spectrum] = ForwardMap(paramset, EC_experimental_spectrum(9:end), EO_experimental_spectrum(9:end));        
        
        %--- compute combined squared error
        fitting_error = 0;
        for k=9:81
            fitting_error = fitting_error + 0.5*(regularized_EC_spectrum(k) - EC_experimental_spectrum(k))^2 + 0.5*(regularized_EO_spectrum(k) - EO_experimental_spectrum(k))^2;
        end
        
        regularized_fitting_errors(i,j) = fitting_error;
    end
end

end
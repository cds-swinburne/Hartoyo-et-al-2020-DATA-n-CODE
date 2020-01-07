function unregularized_fitting_errors = ComputeUnregularizedFittingErrors(unregularized_best_paramsets, EC_experimental_spectra, EO_experimental_spectra)

unregularized_fitting_errors = zeros([82,100]);

for i=1:82
    for j=1:100
        EC_experimental_spectrum(:) = [zeros(1,8) EC_experimental_spectra(i,:)];
        EO_experimental_spectrum(:) = [zeros(1,8) EO_experimental_spectra(i,:)];
        
        paramset(:) = unregularized_best_paramsets(i,j,:);
        
        [unregularized_EC_spectrum, unregularized_EO_spectrum] = ForwardMap(paramset, EC_experimental_spectrum(9:end), EO_experimental_spectrum(9:end));
        
        %--- compute combined squared error
        fitting_error = 0;
        for k=9:81
            fitting_error = fitting_error + 0.5*(unregularized_EC_spectrum(k) - EC_experimental_spectrum(k))^2 + 0.5*(unregularized_EO_spectrum(k) - EO_experimental_spectrum(k))^2;
        end
  
        unregularized_fitting_errors(i,j) = fitting_error;
    end
end

end
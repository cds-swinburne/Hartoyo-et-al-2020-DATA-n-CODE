function fparam = DataSetup

file = load('Datasets\82_subject_indices.mat');
fparam.subject_indices = file.indx_a;


file = load('Datasets\82x2x73_alpha_blocking_spectra.mat');
fparam.spectra_pairs = file.spectra_pairs;
fparam.EC_experimental_spectra(:,:) = fparam.spectra_pairs(:,1,:);
fparam.EO_experimental_spectra(:,:) = fparam.spectra_pairs(:,2,:);

JSDs = ComputeSpectraJSDs(fparam.EC_experimental_spectra, fparam.EO_experimental_spectra);
save('spectra_JSDs.mat','JSDs');
fparam.spectra_JSDs = JSDs;
[fparam.sorted_JSDs, fparam.sorted_idx] = SortJSDs(fparam.spectra_JSDs);


file = load('Datasets\82x100x32_unregularized_best_paramsets.mat');
fparam.unregularized_best_paramsets = file.EC_EO_best_paramsets;

fparam.unregularized_normalized_paramsets = NormalizeParamsets(fparam.unregularized_best_paramsets);

fparam.unregularized_parameter_responses = ComputeParameterResponses(fparam.unregularized_normalized_paramsets);

fparam.unregularized_response_statistics = ComputeResponseStatistics(fparam.unregularized_parameter_responses);

[fparam.unregularized_parameter_response_gradient_statistics] = ComputeEachParameterResponseGradientStatistics(fparam.unregularized_response_statistics, fparam.spectra_JSDs, fparam.sorted_idx);


file = load('Datasets\82x100x32_regularized_best_paramsets.mat');
fparam.regularized_best_paramsets = file.EC_EO_best_paramsets;

normalized_paramsets = NormalizeParamsets(fparam.regularized_best_paramsets);
save('regularized_normalized_paramsets.mat','normalized_paramsets');
fparam.regularized_normalized_paramsets = normalized_paramsets;

fparam.regularized_parameter_responses = ComputeParameterResponses(fparam.regularized_normalized_paramsets);

fparam.regularized_response_statistics = ComputeResponseStatistics(fparam.regularized_parameter_responses);

[fparam.regularized_parameter_response_gradient_statistics] = ComputeEachParameterResponseGradientStatistics(fparam.regularized_response_statistics, fparam.spectra_JSDs, fparam.sorted_idx);


fparam.regularized_parameter_manhattan_distances_statistics = ComputeParameterManhattanDistancesStatistics(fparam.regularized_parameter_responses);
[fparam.regularized_parameter_manhattan_distances_gradient_statistics(1), fparam.regularized_parameter_manhattan_distances_gradient_statistics(2)] = ComputeGradientStatistics(fparam.regularized_parameter_manhattan_distances_statistics, fparam.spectra_JSDs, fparam.sorted_idx);


file = load('Datasets\82x19x10x32_best_paramsets_across_regularization_parameters.mat');
fparam.best_paramsets_across_regularization_parameters = file.EC_EO_best_paramsets;

fparam.unregularized_fitting_errors = ComputeUnregularizedFittingErrors(fparam.unregularized_best_paramsets, fparam.EC_experimental_spectra, fparam.EO_experimental_spectra);

fparam.regularized_fitting_errors = ComputeRegularizedFittingErrors(fparam.best_paramsets_across_regularization_parameters, fparam.EC_experimental_spectra, fparam.EO_experimental_spectra);

fparam.error_statistics = ComputeErrorStatistics(fparam.unregularized_fitting_errors, fparam.regularized_fitting_errors);

end
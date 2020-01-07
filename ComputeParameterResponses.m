function parameter_responses = ComputeParameterResponses(normalized_paramsets)

parameter_responses = zeros(82,100,9);

for subj_idx = 1:82
    for sample_idx = 1:100
        best_paramset(:) = normalized_paramsets(subj_idx,sample_idx,:);
        params_ec = best_paramset([1:6,11,12,23]);
        params_eo = best_paramset(24:32);
        parameter_responses(subj_idx, sample_idx, :) = params_eo - params_ec;
    end
end

end
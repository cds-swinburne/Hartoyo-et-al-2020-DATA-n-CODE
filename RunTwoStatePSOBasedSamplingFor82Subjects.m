function EC_EO_best_paramsets = RunTwoStatePSOBasedSamplingFor82Subjects(reg_param)

%
%   Generate samples of parameter estimation solutions for
%   experimental spectra from 82 subjects stored in 82x73_experimental_spectra.mat
%   using PSO and store the drawn samples into 82x100x22_best_paramsets_PSO.mat
%

% load experimental spectra from 83 subjects
file = load('Datasets\82x2x73_alpha_blocking_spectra.mat');
spectra_pairs = file.spectra_pairs;
EC_experimental_spectra(:,:) = spectra_pairs(:,1,:);
EO_experimental_spectra(:,:) = spectra_pairs(:,2,:);

% initialize the variable for stoging the final selected samples
EC_EO_best_paramsets = zeros(82,100,32);

% iterate sampling over 82 experimental spectra
for i=1:82
    EC_experimental_spectrum(:) = EC_experimental_spectra(i,:);
    EO_experimental_spectrum(:) = EO_experimental_spectra(i,:);
    
    best_paramsets_1000 = zeros(1000,33);
    
    disp(['Sampling parameter sets for Subject ', num2str(i), ' :']);
    
    % iterate fitting model to a particular experimental spectra to draw
    % 1000 initial samples
    parfor j=1:1000
        disp(['   Drawing sample ', num2str(j), ' ...']);
        seed = 5000*i + j;
        [best_paramset, cost] = RunPSOJointFitting(EC_experimental_spectrum, EO_experimental_spectrum, reg_param, seed);
        best_paramset = [cost best_paramset];
        best_paramsets_1000(j,:) = best_paramset;
    end
    
    % sort the initial samples by cost function
    best_paramsets_1000 = sortrows(best_paramsets_1000);
    
    % select the 10% best samples
    best_paramsets_100 = best_paramsets_1000(1:100, 2:end);
    
    % add the selected samples for the current subject to the dataset
    EC_EO_best_paramsets(i,:,:) = best_paramsets_100;
    
    disp(['Parameter sampling for Subject ', num2str(i), ' completed.']);
end

end

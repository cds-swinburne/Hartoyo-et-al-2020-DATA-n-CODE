% RunTwoStatePSObasedSamplingFor82Subjects
%
%   Generate samples of parameter estimation solutions for
%   experimental spectra from 82 subjects stored in 82x73_target_spectra.mat 
%   using PSO and store the drawn samples into 82x100x22_best_paramsets_PSO.mat
%

% load experimental spectra from 83 subjects
file = load('Datasets\82x2x73_alpha_blocking_spectra.mat');
target_spectra = file.selected_ec_spectra;

% initialize the variable for stoging the final selected samples
best_paramsets_PSO = zeros(82,100,22);

% iterate sampling over 82 experimental spectra
for i=1:82
    target_spectrum = target_spectra(i,:);
    best_paramsets_1000 = zeros(1000,23);
    
    disp(['Sampling parameter sets for Subject ', num2str(i), ' :']);
    
    % iterate fitting model to a particular experimental spectra to draw
    % 1000 initial samples
    parfor j=1:1000
        disp(['   Drawing sample ', num2str(j), ' ...']);
        seed = 1000*i + 100*j;
        [best_paramset, squared_error] = RunPSO(target_spectrum,seed);
        best_paramset = cat(2, [squared_error],best_paramset);
        best_paramsets_1000(j,:) = best_paramset;
    end
    
    % sort the initial samples by cost function
    best_paramsets_1000 = sortrows(best_paramsets_1000);
    
    % select the 10% best samples
    best_paramsets_100 = best_paramsets_1000(1:100, 2:end);
    
    % add the selected samples for the current subject to the dataset 
    best_paramsets_PSO(i,:,:) = best_paramsets_100;
    
    disp(['Parameter sampling for Subject ', num2str(i), ' completed.']);
end

% save the dataset of all selected samples for all subjects
save('82x100x22_best_paramsets_PSO.mat','best_paramsets_PSO');

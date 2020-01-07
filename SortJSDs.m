function [sorted_JSDs, sorted_idx] = SortJSDs(spectra_JSDs)

JSDs_idx = [spectra_JSDs (1:82)'];
sorted_JSDs_idx = sortrows(JSDs_idx);
sorted_JSDs = sorted_JSDs_idx(:,1)';
sorted_idx = sorted_JSDs_idx(:,2)';

end
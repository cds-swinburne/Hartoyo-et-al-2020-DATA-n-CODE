function spectra_JSDs = ComputeSpectraJSDs(EC_target_spectra, EO_target_spectra)

spectra_JSDs = zeros(82,1);

for i=1:82
    EC_target_spectrum(:) = EC_target_spectra(i,:);
    EO_target_spectrum(:) = EO_target_spectra(i,:);
    
    mid_dist = (EC_target_spectrum + EO_target_spectrum)/2;
    
    KLD_1 = KLDiv(EC_target_spectrum, mid_dist);
    KLD_2 = KLDiv(EO_target_spectrum, mid_dist);
    
    spectra_JSDs(i,:) = (KLD_1 + KLD_2)/2;
end

end
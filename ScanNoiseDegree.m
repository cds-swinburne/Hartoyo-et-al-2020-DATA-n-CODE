function [g, degree] = ScanNoiseDegree(target_spec)

target_part = target_spec;


noise_spectra = zeros(2001,73);
freq = (9:81)'/4;
deg = linspace(0,2,2001);
for i = 1:2001
    noise_spectra(i,:) = 1 ./ (freq.^deg(i));
    %deg(i);
    num = 0;
    for k=1:20
        num = num + noise_spectra(i,k)*target_part(k)*0.25;
    end
    
    for k=60:73
        num = num + noise_spectra(i,k)*target_part(k)*0.25;
    end
    
    den = 0;
    for k=1:20
        den = den + noise_spectra(i,k)*noise_spectra(i,k)*0.25;
    end
    
    for k=54:73
        den = den + noise_spectra(i,k)*noise_spectra(i,k)*0.25;
    end
    
    
    g = num/den;
    
    diff = 0;
    for it=1:20
        diff = diff + abs(g*noise_spectra(i,it) - target_part(it));
    end
    
    for it=54:73
        diff = diff + abs(g*noise_spectra(i,it) - target_part(it));
    end
    
    diff = diff/40
    Diff(i) = diff;
    G(i) = g;
end


[M,I] = min(Diff);

g = G(I)
degree = deg(I)

figure;
plot(freq, target_part, freq, G(I)*noise_spectra(I,:));


end
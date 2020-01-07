function [spec_ec, spec_eo] = ForwardMapWithHighResolution(params, target_spec_ec, target_spec_eo)
% function for computing cost given the parameter set params

params_ec = params(1:22);
params_eo = [params(24:29) params(7:10) params(30:31) params(13:22)];

eta_ec = params(23);
eta_eo = params(32);


%--- check the stability of the solution ---
[jac_ec, fix_point_params_ec] = VerifySolution(params_ec);

[jac_eo, fix_point_params_eo] = VerifySolution(params_eo);


%--- compute the model spectrum
freq = (0:80)'/4;

spec_ec = zeros(81,1);
for k=1:81
    spec_ec(k) = getAmplitude(freq(k), jac_ec);
end

spec_eo = zeros(81,1);
for k=1:81
    spec_eo(k) = getAmplitude(freq(k), jac_eo);
end

spec_ec = spec_ec ./ (freq.^eta_ec);
spec_eo = spec_eo ./ (freq.^eta_eo);



target_spec_ec = [(zeros(8,1))', target_spec_ec];
target_spec_eo = [(zeros(8,1))', target_spec_eo];



%--- compute the normalization/scaling factor
num_ec = 0;
for k=9:81
    num_ec = num_ec + spec_ec(k)*target_spec_ec(k)*0.25;
end

den_ec = 0;
for j=9:81
    den_ec = den_ec + spec_ec(j)*spec_ec(j)*0.25;
end

g_ec = num_ec/den_ec;


%--- compute the normalization/scaling factor
num_eo = 0;
for k=9:81
    num_eo = num_eo + spec_eo(k)*target_spec_eo(k)*0.25;
end

den_eo = 0;
for j=9:81
    den_eo = den_eo + spec_eo(j)*spec_eo(j)*0.25;
end

g_eo = num_eo/den_eo;



%--- compute the model spectrum
freq = (0:800)'/40;

spec_ec = zeros(801,1);
for k=1:801
    spec_ec(k) = getAmplitude(freq(k), jac_ec);
end

spec_eo = zeros(801,1);
for k=1:801
    spec_eo(k) = getAmplitude(freq(k), jac_eo);
end


spec_ec = spec_ec ./ (freq.^eta_ec);
spec_eo = spec_eo ./ (freq.^eta_eo);


spec_ec = g_ec*spec_ec;
spec_eo = g_eo*spec_eo;

    function amplitude = getAmplitude(f, jacobian)
        %function to compute the model power spectrum given the Jacobian matrix and
        %sampling frequency
        
        Jm = jacobian - 0.002i*pi*f*eye(10);
        G = [0 0 0 1 0 0 0 0 0 0]';
        Y = Jm\G;
        amplitude = abs(Y(1,1));
        amplitude = amplitude.^2;
    end

end
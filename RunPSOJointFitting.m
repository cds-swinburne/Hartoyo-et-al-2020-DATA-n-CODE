function [best_paramset, min_cost] = RunPSOJointFitting(EC_target_spectrum, EO_target_spectrum, reg_param, seed)
%
% [best_paramset, err] = RunPSO(target_spec)
%   run particle swarm optimization to jointly fit the model to the experimental spectra 
%   with a random starting point based on the seed given in the arguments
%   return the best parameter set and the error assosiated with it.
%


EC_target_spectrum = [zeros(1,8), EC_target_spectrum];
EO_target_spectrum = [zeros(1,8), EO_target_spectrum];

%--- define the physiological-relevant range of parameters ---
var_min(1) = 5;
var_max(1) = 150;

var_min(2) = 5;
var_max(2) = 150;

var_min(3) = 0.1;
var_max(3) = 1;

var_min(4) = 0.01;
var_max(4) = 0.1;

var_min(5) = 0.1;
var_max(5) = 2;

var_min(6) = 0.1;
var_max(6) = 2;

var_min(7) = 2000;
var_max(7) = 5000;

var_min(8) = 2000;
var_max(8) = 5000;

var_min(9) = 100;
var_max(9) = 1000;

var_min(10) = 100;
var_max(10) = 1000;

var_min(11) = 0;
var_max(11) = 10;

var_min(12) = 0;
var_max(12) = 10;

var_min(13) = -80;
var_max(13) = -60;

var_min(14) = -80;
var_max(14) = -60;

var_min(15) = -20;
var_max(15) = 10;

var_min(16) = -90;
var_max(16) = -65;

var_min(17) = 0.05;
var_max(17) = 0.5;

var_min(18) = 0.05;
var_max(18) = 0.5;

var_min(19) = -55;
var_max(19) = -40;

var_min(20) = -55;
var_max(20) = -40;

var_min(21) = 2;
var_max(21) = 7;

var_min(22) = 2;
var_max(22) = 7;

var_min(23) = 0;
var_max(23) = 2;

var_min(24) = 5;
var_max(24) = 150;

var_min(25) = 5;
var_max(25) = 150;

var_min(26) = 0.1;
var_max(26) = 1;

var_min(27) = 0.01;
var_max(27) = 0.1;

var_min(28) = 0.1;
var_max(28) = 2;

var_min(29) = 0.1;
var_max(29) = 2;

var_min(30) = 0;
var_max(30) = 10;

var_min(31) = 0;
var_max(31) = 10;

var_min(32) = 0;
var_max(32) = 2;


% ---- initial swarm position -----

inertia = 1.2;
max_ind_cor_factor = 2.8; % maximum individual correction factor
max_soc_cor_factor = 1.3; % maximum social correction factor

delta_threshold = 1.0e-10; % idealistic targeted tiny cost

rng(seed)

swarm_size = 111;
swarm = zeros(swarm_size,4,32);

for iter = 1 : 32
    swarm(1:swarm_size, 1, iter) = var_min(iter)+rand(1,swarm_size)*(var_max(iter)-var_min(iter));
end

swarm(:, 4, 1) = 1e18;          % best value so far
swarm(:, 2, :) = 0;             % initial velocity

vbest = 1e18;
stuck = 0;
count = 0;

% Iterations
while (vbest > delta_threshold)
    count = count + 1;
    
    %-- evaluating position & quality ---
    for i = 1 : swarm_size
        
        vars = zeros(32);
        for z = 1 : 32
            vars(z) = swarm(i, 1, z);
        end
        
        val = computeCost(vars);         % fitness evaluation (you may replace this objective function with any function having a global minima)
        
        if val < swarm(i, 4, 1)                 % if new position is better
            
            for z = 1 : 32
                swarm(i, 3, z) = vars(z); % update best x,
            end
            
            swarm(i, 4, 1) = val;               % and best value
        end
        
        for z = 1 : 32
            swarm(i, 1, z) = swarm(i, 1, z) + swarm(i, 2, z)/1.3;     %update x position
        end
    end
    
    prev_vbest = vbest;
    
    [vbest,gbest] = min(swarm(:, 4, 1));        % global best position
    
    %--- stopping condition ---
    if prev_vbest - vbest < vbest/500
        stuck = stuck + 1;
    else
        stuck = 0;
    end
    
    if stuck > 100
        break
    end
    
    %--- updating velocity vectors
    for i = 1 : swarm_size
        for z = 1 : 32
            swarm(i, 2, z) = rand*inertia*swarm(i, 2, z) + max_ind_cor_factor*rand*(swarm(i, 3, z) - swarm(i, 1, z)) + max_soc_cor_factor*rand*(swarm(gbest, 3, z) - swarm(i, 1, z));   %x velocity component
        end
    end
end

best_paramset(:) = swarm(gbest, 3, :);
min_cost = vbest;




    function cost = computeCost(params)
        % function for computing cost given the parameter set params
        
        params_ec = [params(1:22)];
        params_eo = [params(24:29) params(7:10) params(30:31) params(13:22)];
        
        eta_ec = params(23);
        eta_eo = params(32);
        
        %--- check the stability of the solution ---
        [is_fixed_point_found_ec, is_chaotic_ec, jac_ec] = CheckSolution(params_ec);
        
        is_fixed_point_found_eo = 0;
        is_chaotic_eo = 1;
        physiological = 0;
        
        if is_fixed_point_found_ec == 1
            [is_fixed_point_found_eo, is_chaotic_eo, jac_eo] = CheckSolution(params_eo);
            if is_fixed_point_found_eo == 1
                %--- check if all parameters are in physiolocially-relevant range
                physiological = 1;
                for x = 1:32
                    newVal = params(x);
                    if newVal < var_min(x) || newVal > var_max(x)
                        physiological = 0;
                        break;
                    end
                end
            end
        end
        
        
        if (is_fixed_point_found_ec == 0) || (is_fixed_point_found_eo == 0)
            cost = 1e18;  % huge cost in case fixed point not found
        else
            if (is_chaotic_ec == 1) || (is_chaotic_eo == 1)
                cost = 1e17; % huge cost in case fixed of chaotic/unstable solution
            else
                if (physiological == 0)
                    cost = 1e16; % huge cost in case of parameters not in physiological-relevant range
                else
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
                    
                    %--- compute the normalization/scaling factor
                    num_ec = 0;
                    for k=9:81
                        num_ec = num_ec + spec_ec(k)*EC_target_spectrum(k)*0.25;
                    end
                    
                    den_ec = 0;
                    for j=9:81
                        den_ec = den_ec + spec_ec(j)*spec_ec(j)*0.25;
                    end
                    
                    g_ec = num_ec/den_ec;
                    
                    
                    %--- compute the normalization/scaling factor
                    num_eo = 0;
                    for k=9:81
                        num_eo = num_eo + spec_eo(k)*EO_target_spectrum(k)*0.25;
                    end
                    
                    den_eo = 0;
                    for j=9:81
                        den_eo = den_eo + spec_eo(j)*spec_eo(j)*0.25;
                    end
                    
                    g_eo = num_eo/den_eo;
                    
                    
                    spec_ec = g_ec*spec_ec;
                    spec_eo = g_eo*spec_eo;
                    
                    %--- compute regularization term
                    reg = abs(params_eo(1)-params_ec(1))/(var_max(1)-var_min(1)) + abs(params_eo(2)-params_ec(2))/(var_max(2)-var_min(2)) + ...
                        abs(params_eo(3)-params_ec(3))/(var_max(3)-var_min(3)) + abs(params_eo(4)-params_ec(4))/(var_max(4)-var_min(4)) + ...
                        abs(params_eo(5)-params_ec(5))/(var_max(5)-var_min(5)) + abs(params_eo(6)-params_ec(6))/(var_max(6)-var_min(6)) + ...
                        abs(params_eo(11)-params_ec(11))/(var_max(11)-var_min(11)) + abs(params_eo(12)-params_ec(12))/(var_max(12)-var_min(12)) + ...
                        abs(eta_eo - eta_ec)/(var_max(23)-var_min(23));
                    
                    reg = reg/9;
                    
                    %--- compute combined squared error
                    cost = 0;
                    for x=9:81
                        cost = cost + 0.5*(spec_ec(x) - EC_target_spectrum(x))^2 + 0.5*(spec_eo(x) - EO_target_spectrum(x))^2;
                    end
                    
                    %--- compute cost
                    cost = cost + reg_param*reg;
                end
            end
        end
    end

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

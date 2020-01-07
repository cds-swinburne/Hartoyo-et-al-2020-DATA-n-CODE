function [jacobian, fix_point_params] = VerifySolution(params)
%
% [is_fixed_point_found, is_chaotic, jacobian] = CheckSolution(params)
% check if the solution represented by the parameter set is stable or chaotic

Te = params(1);
Ti = params(2);
aee = params(3);
aei = params(3);
bie = params(4);
bii = params(4);
A = params(5);
B = params(6);
Nee = params(7);
Nei = params(8);
Nie = params(9);
Nii = params(10);
Pee = params(11);
Pei = params(12);
Her = params(13);
Hir = params(14);
Heeq = params(15);
Hieq = params(16);
Emax = params(17);
Imax = params(18);
De = params(19);
Di = params(20);
Se = params(21);
Si = params(22);

z = FindSingularPoints(params,0);

is_fixed_point_found = 1;
is_chaotic =1;
jacobian = zeros(10,10);
He = 0;
Hi = 0;
Iee = 0;
Iei = 0;
Iie = 0;
Iii = 0;

if (isempty(z))
    is_fixed_point_found = 0;
else
    found = 0;
    solution_count = 1;
    n = size(z,2);
    is_chaotic = 1;
    while found == 0 && solution_count <= n
        He = z(1,solution_count);
        Hi = z(2,solution_count);
        Iee = z(3,solution_count);
        Iei = z(5,solution_count);
        Iie = z(7,solution_count);
        Iii = z(9,solution_count);
        
        jacobian(1,1) = -(Iee/abs(Heeq - Her) + Iie/abs(Her - Hieq) + 1)/Te;
        jacobian(1,3) = -(He - Heeq)/(Te*abs(Heeq - Her));
        jacobian(1,5) = -(He - Hieq)/(Te*abs(Her - Hieq));
        jacobian(2,2) = -(Iei/abs(Heeq - Hir) + Iii/abs(Hieq - Hir) + 1)/Ti;
        jacobian(2,7) = (Heeq - Hi)/(Ti*abs(Heeq - Hir));
        jacobian(2,9) = -(Hi - Hieq)/(Ti*abs(Hieq - Hir));
        jacobian(3,4) = 1;
        jacobian(4,1) = (A*Emax*Nee*aee*exp(1)*sqrt(2)*exp((sqrt(2)*(De - He))/Se))/(Se*(exp((sqrt(2)*(De - He))/Se) + 1)^2);
        jacobian(4,3) = -aee^2;
        jacobian(4,4) = -2*aee;
        jacobian(5,6) = 1;
        jacobian(6,2) = (B*Imax*Nie*bie*exp(1)*sqrt(2)*exp((sqrt(2)*(Di - Hi))/Si))/(Si*(exp((sqrt(2)*(Di - Hi))/Si) + 1)^2);
        jacobian(6,5) = -bie^2;
        jacobian(6,6) = -2*bie;
        jacobian(7,8) = 1;
        jacobian(8,1) = (A*Emax*aei*Nei*exp(1)*sqrt(2)*exp((sqrt(2)*(De - He))/Se))/(Se*(exp((sqrt(2)*(De - He))/Se) + 1)^2);
        jacobian(8,7) = -aei^2;
        jacobian(8,8) = -2*aei;
        jacobian(9,10) = 1;
        jacobian(10,2) = (B*Imax*Nii*bii*exp(1)*sqrt(2)*exp((sqrt(2)*(Di - Hi))/Si))/(Si*(exp((sqrt(2)*(Di - Hi))/Si) + 1)^2);
        jacobian(10,9) = -bii^2;
        jacobian(10,10) = -2*bii;
        
        
        is_valid = IsValidJacobian(jacobian);
        if is_valid == 0
            is_chaotic = 1;
        else
            [V,D] = eig(jacobian);
            is_chaotic = IsChaoticSolution(D);
        end
        
        if is_chaotic == 0
            found = 1;
        else
            solution_count = solution_count + 1;
        end
        
    end
    
end

fix_point_params = [He Hi Iee Iei Iie Iii];

end

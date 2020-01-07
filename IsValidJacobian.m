function valid = IsValidJacobian(Jac)
%
% valid = IsValidJacobian(Jac)
%   check if the Jacobian given as the argument is valid 
%

    valid = 1;
    
    for i=1:10
        for j=1:10
            if isnan(Jac(i, j)) || isinf(Jac(i,j))
                valid = 0;
                break;
            end
        end
        if valid == 0
            break;
        end
    end
end

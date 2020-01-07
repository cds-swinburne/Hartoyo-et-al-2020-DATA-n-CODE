function chaotic = IsChaoticSolution(D)
%
% chaotic = IsChaoticSolution(D)
%   check if the solution represented by the Eigenvalues D is chaotic
%

chaotic = 0;
idx = 1;

while (chaotic == 0) && (idx<=10)
    val = real(D(idx,idx));
    if val > 0
        chaotic = 1;
    else
        idx = idx + 1;
    end
end

end

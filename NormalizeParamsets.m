function normalized_paramsets = NormalizeParamsets(best_paramsets)

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

var_mid = zeros(32,1);
for i=1:32
    var_mid(i) = (var_max(i) + var_min(i))/2;
end


normalized_paramsets = zeros(82,100,32);


for i=1:82 
    for j=1:100
        
        best_paramset(:) = best_paramsets(i,j,:);
        
        normalized_best_paramset = zeros(32,1);
        
        for k=1:32
            normalized_best_paramset(k)= (best_paramset(k) - var_mid(k)) / (var_max(k) - var_mid(k));
        end
        
        normalized_paramsets(i,j,:) = normalized_best_paramset;
    end
end

end
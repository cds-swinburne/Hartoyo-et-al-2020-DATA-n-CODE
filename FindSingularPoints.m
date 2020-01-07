function z = FindSingularPoints(params,flg)
%
%   z = FindSingularPoints(param,flg)
%
%   Find the spatially homogeneous singular points (z) of the equations
%   and their corresponding Jacobians (Jac) and eigenspectra (lambda)
%   
%   param as defined in findSingularPoints.m
%   flg = 0 (default) to suppress plot
%

param.Tau_e = params(1);
param.Tau_i = params(2);
param.gamma_ee = params(3);
param.gamma_ei = params(3);
param.gamma_ie = params(4);
param.gamma_ii = params(4);
param.Gamma_e = params(5);
param.Gamma_i = params(6);
param.Nee_beta = params(7);
param.Nei_beta = params(8);
param.Nie_beta = params(9);
param.Nii_beta = params(10);
param.pee = params(11);
param.pei = params(12);
param.pie = 0;
param.pii = 0;
param.he_rest = params(13);
param.hi_rest = params(14);
param.he_eq = params(15);
param.hi_eq = params(16);
param.Se_max = params(17);
param.Si_max = params(18);
param.mu_e = params(19);
param.mu_i = params(20);
param.sigma_e = params(21);
param.sigma_i = params(22);


if (nargin < 1)||isempty(param)
    param = MPDParam2();
end
if (nargin < 2)||isempty(flg)
    flg = 0;
end
z = [];
lambda = [];
Jac = [];

% combine parameters
r2 = sqrt(2);
Gege = param.Gamma_e*exp(1)/param.gamma_ee;
Gigi = param.Gamma_i*exp(1)/param.gamma_ii;
Gegi = param.Gamma_e*exp(1)/param.gamma_ei;
Gige = param.Gamma_i*exp(1)/param.gamma_ie;
GNee = Gege*param.Nee_beta;
GNei = Gegi*param.Nei_beta;
GNie = Gige*param.Nie_beta;
GNii = Gigi*param.Nii_beta;

% define initial scan range
he = linspace(-90,0,2000);
Iee = GNee*Se(he) + Gege*param.pee;
Iie = (he - param.he_rest - Psi_ee(he).*Iee)./Psi_ie(he);
Sii = (Iie - Gige*param.pie)/GNie;
indx = find((Sii < param.Si_max)&(Sii > 0));
hi = InvSi(Sii(indx));
he = he(indx);
Iei = GNei*Se(he) + Gegi*param.pei;
Iii = GNii*Si(hi) + Gigi*param.pii;
f = param.hi_rest - hi + Psi_ei(hi).*Iei + Psi_ii(hi).*Iii;

% find the zeros
ff = f(1:end-1).*f(2:end);
indx1 = find(ff <= 0);
if isempty(indx1)
    return;
end
N = length(indx1);
z = zeros(10,N);
z0 = 500; % arbitrary unlikely value
m = 0;
options = optimset('Display','off');
for n = (1:N)
    q = fzero(@zfun,[he(indx1(n)) he(indx1(n)+1)] ,options);
    if (~isnan(q))&&(~isinf(q))&&(q ~= z0)
        m = m+1;
        z0 = q;
        z(1,m) = z0;
        z(2,m) = He2Hi(z0);
        if isnan(z(2,m))
            m = m-1;
        else
            z(3,m) = GNee*Se(z0) + Gege*param.pee;
            z(5,m) = GNei*Se(z0) + Gegi*param.pei;
            z(7,m) = GNie*Si(z(2,m)) + Gige*param.pie;
            z(9,m) = GNii*Si(z(2,m)) + Gigi*param.pii;
        end
    end
end
z = z(:,1:m);

% plot the function f vs he
if flg ~= 0
    figure;
    plot(he,real(f),'r',he,imag(f),'b',[he(1) he(end)],[0 0],'k');
    hold on;
    for n = (1:m)
        if max(real(lambda{n})) < 0
            plot(z(1,n),zfun(z(1,n)),'ob');
        else
            plot(z(1,n),zfun(z(1,n)),'or');
        end
    end
    hold off;
    xlabel('h_e');
    ylabel('f(h_e)');
    fmax = max(real(f));
    x1 = he(1)*85/90;
    x2 = he(1)*55/90;
    zsp = CheckSingPts(z);
    stz = sprintf('dh_e/dt = %5.3g',zsp(1));
    text(x1,0.9*fmax,stz);
    stz = sprintf('dh_i/dt = %5.3g',zsp(2));
    text(x2,0.9*fmax,stz);
    stz = sprintf('dI_e_e/dt = %5.3g',zsp(4));
    text(x1,0.7*fmax,stz);
    stz = sprintf('dI_e_i/dt = %5.3g',zsp(6));
    text(x2,0.7*fmax,stz);
    stz = sprintf('dI_i_e/dt = %5.3g',zsp(8));
    text(x1,0.5*fmax,stz);
    stz = sprintf('dI_i_i/dt = %5.3g',zsp(10));
    text(x2,0.5*fmax,stz);
       
    stz = sprintf('h_e = %5.3g',z(1));
    text(x1,fmax,stz);
    stz = sprintf('h_i = %5.3g',z(2));
    text(x2,fmax,stz);
    stz = sprintf('I_e_e = %5.3g',z(3));
    text(x1,0.8*fmax,stz);
    stz = sprintf('I_e_i = %5.3g',z(5));
    text(x2,0.8*fmax,stz);
    stz = sprintf('I_i_e = %5.3g',z(7));
    text(x1,0.6*fmax,stz);
    stz = sprintf('I_i_i = %5.3g',z(9));
    text(x2,0.6*fmax,stz);
end

    function s = Se(h)
        s = param.Se_max./(1 + exp(-r2*(h - param.mu_e)/param.sigma_e));
    end
    function s = Si(h)
        s = param.Si_max./(1 + exp(-r2*(h - param.mu_i)/param.sigma_i));
    end
    function s = Psi_ee(h)
        s = (param.he_eq - h)/abs(param.he_eq - param.he_rest);
    end
    function s = Psi_ei(h)
        s = (param.he_eq - h)/abs(param.he_eq - param.hi_rest);
    end
    function s = Psi_ie(h)
        s = (param.hi_eq - h)/abs(param.hi_eq - param.he_rest);
    end
    function s = Psi_ii(h)
        s = (param.hi_eq - h)/abs(param.hi_eq - param.hi_rest);
    end
    function s = Psi_ii1(h)
        s = -1/abs(param.hi_eq - param.hi_rest);
    end
    function s = Psi_ee1(h)
        s = -1/abs(param.he_eq - param.he_rest);
    end
    function s = Psi_ei1(h)
        s = -1/abs(param.he_eq - param.hi_rest);
    end
    function s = Psi_ie1(h)
        s = -1/abs(param.hi_eq - param.he_rest);
    end
        
    function s = InvSi(h)
        s = -(param.sigma_i/r2)*log(param.Si_max./h - 1) + param.mu_i;
    end

    function s = Se1(h)
        s = (r2*param.Se_max*exp(-r2*(h - param.mu_e)/param.sigma_e)/param.sigma_e)/((1 + exp(-r2*(h - param.mu_e)/param.sigma_e))^2);
    end
    function s = Si1(h)
        s = (r2*param.Si_max*exp(-r2*(h - param.mu_i)/param.sigma_i)/param.sigma_i)/((1 + exp(-r2*(h - param.mu_i)/param.sigma_i))^2);
    end

    function s = He2Hi(h)  
        iee = GNee*Se(h) + Gege*param.pee;
        iie = (h - param.he_rest - Psi_ee(h).*iee)./Psi_ie(h);
        sx = (iie - Gige*param.pie)/GNie;   
        if (sx <= 0) ||( sx >= param.Si_max)
            s = NaN;
        else
            s = InvSi(sx);
        end
    end

    function s = Jacobian(x)
        s = zeros(10,10);
        s(1,1) = (1/param.Tau_e)*(-1 + Psi_ee1(x(1))*x(3) + Psi_ie1(x(1))*x(7));
        s(1,3) = Psi_ee(x(1))/param.Tau_e;
        s(1,7) = Psi_ie(x(1))/param.Tau_e;
        
        s(2,2) = (1/param.Tau_i)*(-1 +Psi_ei1(x(2))*x(5) + Psi_ii1(x(2))*x(9));
        s(2,5) = Psi_ei(x(2))/param.Tau_i;
        s(2,9) = Psi_ii(x(2))/param.Tau_i;
        
        s(3,4) = 1;
        
        s(4,1) = param.Gamma_e*param.gamma_ee*exp(1)*param.Nee_beta*Se1(x(1));
        s(4,3) = -param.gamma_ee^2;
        s(4,4) = -2*param.gamma_ee;        
        
        s(5,6) = 1;
        
        s(6,1) = param.Gamma_i*param.gamma_ie*exp(1)*param.Nie_beta*Si1(x(2));
        s(6,6) = -2*param.gamma_ie;
        s(6,5) = - param.gamma_ie^2;
        
        s(7,8) = 1;
        
        s(8,2) = param.Gamma_e*param.gamma_ei*exp(1)*param.Nei_beta*Se1(x(1)); 
        s(8,8) = -2*param.gamma_ei;
        s(8,7) = -param.gamma_ei^2;
        
        s(9,10) = 1;
        
        s(10,2) = param.Gamma_i*param.gamma_ii*exp(1)*param.Nii_beta*Si1(x(2));
        s(10,10) = -2*param.gamma_ii;
        s(10,9) = - param.gamma_ii^2;
                       
    end
  
    function s = zfun(h)
        iee = GNee*Se(h) + Gege*param.pee;
        iie = (h - param.he_rest - Psi_ee(h).*iee)./Psi_ie(h);
        sii = (iie - Gige*param.pie)/GNie;
        h_i = InvSi(sii);
        iei = GNei*Se(h) + Gegi*param.pei;
        iii = GNii*Si(h_i) + Gigi*param.pii;
        s = param.hi_rest - h_i + Psi_ei(h_i).*iei + Psi_ii(h_i).*iii;
    end
      
    function s = CheckSingPts(z1)
        s = zeros(size(z1));
        her = param.he_rest
        z1 = z(1,1)
        Pz3 = Psi_ee(z(1,1)).*z(3,1)
        Pz7 = Psi_ie(z(1,1)).*z(7,1)
        s(1) = param.he_rest - z(1,1) + Psi_ee(z(1,1)).*z(3,1) + Psi_ie(z(1,1)).*z(7,1);
        s(2) = param.hi_rest - z(2,1) + Psi_ei(z(2,1)).*z(5,1) + Psi_ii(z(2,1)).*z(9,1);
        s(4) = -param.gamma_ee^2*z(3,1) + param.Gamma_e*param.gamma_ee*exp(1)*(param.Nee_beta*Se(z(1,1)) + param.pee);
        s(6) = -param.gamma_ei^2*z(5,1) + param.Gamma_e*param.gamma_ei*exp(1)*(param.Nei_beta*Se(z(1,1)) + param.pei);
        s(8) = -param.gamma_ie^2*z(7,1) + param.Gamma_i*param.gamma_ie*exp(1)*(param.Nie_beta*Si(z(2,1)) + param.pie);
        s(10) = -param.gamma_ii^2*z(9,1) + param.Gamma_i*param.gamma_ii*exp(1)*(param.Nii_beta*Si(z(2,1)) + param.pii);
    end
end






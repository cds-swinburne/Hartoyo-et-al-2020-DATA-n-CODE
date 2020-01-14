function ShowAlphaRhythmSensitivityToParameters(fparam)

labl = cell(9,1);
labl(1) = {'\tau_{e}'};
labl(2) = {'\tau_{i}'};
labl(3) = {'\gamma_{e}'};
labl(4) = {'\gamma_{i}'};
labl(5) = {'\Gamma_{e}'};
labl(6) = {'\Gamma_{i}'};
labl(7) = {'p_{ee}'};
labl(8) = {'p_{ei}'};
labl(9) = {'\eta'};

param_mapping(1) = 24;
param_mapping(2) = 25;
param_mapping(3) = 26;
param_mapping(4) = 27;
param_mapping(5) = 28;
param_mapping(6) = 29;
param_mapping(7) = 30;
param_mapping(8) = 31;
param_mapping(9) = 32;

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

subjt=20;

figure_label =['Subject ', num2str(subjt), ''];
params(:) = fparam.regularized_best_paramsets(subjt,1,:);


f=figure('Name',figure_label,'NumberTitle','off', 'OuterPosition',[468 53 845 893]);

[ha, pos] = tight_subplot(5,2,[.02 .03],[.06 .02],[.075 .02]);

freq = (0:80)/4;

freq200 = (0:800)'/40;

for i=1:9
    axes(ha(i));
    par = param_mapping(i);
    
    paramset = params;
    param0 = paramset(par);
    param1 = param0 + 0.03*(var_max(par) - var_min(par));
    if param1 > var_max(par)
        param1 = var_max(par);
    end
    param2 = param0 - 0.03*(var_max(par) - var_min(par));
    if param2 < var_min(par)
        param2 = var_min(par);
    end
    
    EC_experimental_spectrum(:) = fparam.EC_experimental_spectra(subjt,:);
    EO_experimental_spectrum(:) = fparam.EO_experimental_spectra(subjt,:);
    
    [EC_model_spectrum_0, EO_model_spectrum_0] = ForwardMapWithHighResolution(paramset, EC_experimental_spectrum, EO_experimental_spectrum);
    EO_model_spectrum_0 = EO_model_spectrum_0(81:end);
    
    paramset(par) = param1;
    [EC_model_spectrum_1, EO_model_spectrum_1] = ForwardMapWithHighResolution(paramset, EC_experimental_spectrum, EO_experimental_spectrum);
    EO_model_spectrum_1 = EO_model_spectrum_1(81:end);
    EO_model_spectrum_1 = EO_model_spectrum_1/sum(EO_model_spectrum_1(1:10:end));
    
    paramset(par) = param2;
    [EC_model_spectrum_2, EO_model_spectrum_2] = ForwardMapWithHighResolution(paramset, EC_experimental_spectrum, EO_experimental_spectrum);
    EO_model_spectrum_2 = EO_model_spectrum_2(81:end);
    EO_model_spectrum_2 = EO_model_spectrum_2/sum(EO_model_spectrum_2(1:10:end));
    
    ym = max([max(EC_experimental_spectrum), max(EO_experimental_spectrum)]);
    
    plot(freq200(81:end), EO_model_spectrum_0, '-g', 'LineWidth',2);
    hold on
    
    plot(freq(9:end), EO_experimental_spectrum, '--', 'color', [0.4118    0.4118    0.4118], 'LineWidth',1);
    hold on
    
    plot(freq200(81:end), EO_model_spectrum_1, 'color', 'red', 'LineWidth',2);
    hold on
    
    plot(freq200(81:end), EO_model_spectrum_2, 'color', [0 0.4470 0.7410], 'LineWidth',2);
    
    
    
    t= text(8.15,0.07, ['\fontsize{12}{\color[rgb]{0.0902 0.4000 0.1725}',labl{i},' \color{red}\fontsize{14}\uparrow\fontsize{14}\color[rgb]{0 0.4470 0.7410}\downarrow}'],'interpreter','tex');
    t.FontWeight = 'bold';

    if mod(i,2)==1
        ylabel('PSD');
        set(gca,'ytick',[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08]);
    else
        set(gca,'ytick',[0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08]);
        set(gca,'yticklabel',{[]});
    end
    
    if i==8 || i==9
        xlabel('Frequency (Hz)');
        set(gca,'xtick',[9,10,11,12]);
    else
        set(gca,'xticklabel',{[]});
    end
    
    ylim([0 0.085])
    xlim([8 13]);
    
    set(gca, 'YGrid', 'on', 'XGrid', 'on');
end

axes(ha(10));
p1 = plot([0 0],[0 0], '--', 'color', [0.4118    0.4118    0.4118], 'LineWidth',1,'DisplayName','Experimental spectrum (EO Subject 25)');
hold on
p2 = plot([0 0],[0 0], '-g', 'LineWidth',2,'DisplayName','Fitted model spectrum: \theta = \theta_{0}');
hold on
p3 = plot([0 0],[0 0], 'color', 'red', 'LineWidth',2,'DisplayName','Perturbed model spectrum: \theta = \theta_{0} + 0.03(\theta_{max} - \theta_{min})');
hold on
p4 = plot([0 0],[0 0], 'color', [0 0.4470 0.7410], 'LineWidth',2,'DisplayName','Perturbed model spectrum: \theta = \theta_{0} - 0.03(\theta_{max} - \theta_{min})');
hold on

set(gca,'xtick',[])
set(gca,'ytick',[])
L=legend([p1 p2 p3 p4], 'location', 'southoutside');
L.FontSize = 10;
legend boxoff
set(gca,'Visible','off')

txt_obj = findall(f,'Type','text');
set(txt_obj,'FontName','Arial','FontSize',11);


end
function ShowDegreeOfAlphaBlockingAcross82Subjects(fparam)

max_JSD = max(fparam.spectra_JSDs);
min_JSD = min(fparam.spectra_JSDs);

cm = colormap;

figure('OuterPosition',[288 35 1281 947]);

[ha, pos] = tight_subplot(6,7,[.007 0],[.12 .007],[.02 .005]);
count = 0;
freq = (0:80)/4;

for i=fparam.sorted_idx(1:41)
    count = count + 1;
    axes(ha(count));
    
    EC_experimental_spectrum(:) = fparam.EC_experimental_spectra(i,:);
    EO_experimental_spectrum(:) = fparam.EO_experimental_spectra(i,:);
    
    ym = max([max(EC_experimental_spectrum), max(EO_experimental_spectrum)]);
    ymax = ym + 0.2*ym;
    ymin = 0;
    
    
    plot(freq(9:end), EC_experimental_spectrum, 'LineWidth',2);
    hold on
    
    plot(freq(9:end), EO_experimental_spectrum, 'LineWidth',2);
    hold on
    
    converted_rho = (fparam.sorted_JSDs(count)-min_JSD)/(max_JSD - min_JSD);
    colorID = max(1, sum(converted_rho > [0:1/length(cm(:,1)):1]));
    myColor = cm(colorID, :);
    
    axis manual;
    
    x = (1.5 : 20.5);
    curve1 = ymax*x.^0;
    curve2 = (ym+0.05*ym)*x.^0;
    
    plot(x, curve1, 'color', myColor);
    hold on;
    
    plot(x, curve2, 'color', myColor);
    x2 = [x, fliplr(x)];
    inBetween = [curve1, fliplr(curve2)];
    fill(x2, inBetween, myColor, 'LineStyle','none');
    grid on;
    
    text(13.5,0.9*ym,['Subj ', num2str(fparam.subject_indices(i))], 'FontSize',12)
    if count <= 35
        set(gca,'xticklabel',{[]})
    else
        xlabel('Frequency (Hz)','FontSize',12);
    end
    
    if (mod(count,7)==1)
        ylabel('PSD');
    end
    set(gca,'ytick',[])
    ylim([ymin ymax]);
    xlim([1.5 20.5]);
    
    set(gca, 'YGrid', 'off', 'XGrid', 'on');
end

axes(ha(42));

c=colorbar('location','North','FontSize',12);
c.Label.String = 'D_{JS}(S^{EC}||S^{EO})';
caxis([min_JSD max_JSD])
x=get(c,'Position');
x(1)=x(1)-0.005;
x(2)=x(2)+0.015;
x(3)=0.135;
x(4)=0.02;
set(c,'Position',x)
set(gca,'Visible','off')
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on

plot([0 0],[0 0], 'color', [0    0.4470    0.7410],'LineWidth',2)
hold on
plot([0 0],[0 0], 'color', [0.8500    0.3250    0.0980], 'LineWidth',2)
L=legend('','', '', sprintf('EC normalized\nexperimental\nspectrum'), sprintf('EO normalized\nexperimental\nspectrum'), 'Location','north');
L.FontSize = 12;
legend boxoff


figure('OuterPosition',[288 35 1281 947]);

[ha, pos] = tight_subplot(6,7,[.007 0],[.12 .007],[.02 .005]);
freq = (0:80)/4;

for i=fparam.sorted_idx(42:82)
    count = count + 1;
    axes(ha(count-41));
    
    EC_experimental_spectrum(:) = fparam.EC_experimental_spectra(i,:);
    EO_experimental_spectrum(:) = fparam.EO_experimental_spectra(i,:);
    
    ym = max([max(EC_experimental_spectrum), max(EO_experimental_spectrum)]);
    ymax = ym + 0.2*ym;
    ymin = 0;
    
    plot(freq(9:end), EC_experimental_spectrum, 'LineWidth',2);
    hold on
    
    plot(freq(9:end), EO_experimental_spectrum, 'LineWidth',2);
    hold on
    
    converted_rho = (fparam.sorted_JSDs(count)-min_JSD)/(max_JSD - min_JSD);
    colorID = max(1, sum(converted_rho > [0:1/length(cm(:,1)):1]));
    myColor = cm(colorID, :);
    
    axis manual;
    
    x = (1.5 : 20.5);
    curve1 = ymax*x.^0;
    curve2 = (ym+0.05*ym)*x.^0;
    
    plot(x, curve1, 'color', myColor);
    hold on;
    plot(x, curve2, 'color', myColor);
    x2 = [x, fliplr(x)];
    inBetween = [curve1, fliplr(curve2)];
    fill(x2, inBetween, myColor, 'LineStyle','none');
    grid on;
    
    text(13.5,0.9*ym,['Subj ', num2str(fparam.subject_indices(i))], 'FontSize',12)
    if count <= 76
        set(gca,'xticklabel',{[]})
    else
        xlabel('Frequency (Hz)','FontSize',12);
    end
    
    if (mod(count+1,7)==1)
        ylabel('PSD');
    end
    set(gca,'ytick',[])
    ylim([ymin ymax]);
    xlim([1.5 20.5]);
    set(gca, 'YGrid', 'off', 'XGrid', 'on');
end

axes(ha(42));

c=colorbar('location','North','FontSize',12);
c.Label.String = 'D_{JS}(S^{EC}||S^{EO})';
caxis([min_JSD max_JSD])
x=get(c,'Position');
x(1)=x(1)-0.005;
x(2)=x(2)+0.015;
x(3)=0.135;
x(4)=0.02;
set(c,'Position',x)
set(gca,'Visible','off')
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on

plot([0 0],[0 0], 'color', [0    0.4470    0.7410],'LineWidth',2)
hold on
plot([0 0],[0 0], 'color', [0.8500    0.3250    0.0980], 'LineWidth',2)
L=legend('','', '', sprintf('EC normalized\nexperimental\nspectrum'), sprintf('EO normalized\nexperimental\nspectrum'), 'Location','north');
L.FontSize = 12;
legend boxoff

end
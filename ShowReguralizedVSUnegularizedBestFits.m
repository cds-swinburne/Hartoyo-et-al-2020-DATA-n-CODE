function ShowReguralizedVSUnegularizedBestFits(fparam)

order = fparam.sorted_idx;
f=figure('OuterPosition',[555 34 710 959]);

[ha, pos] = tight_subplot(6,2,[.01 0],[.1 .005],[.075 .005]);

count = 0;
freq = (0:80)/4;

for i=order([2    17    34    63    76])
    
    EC_experimental_spectrum(:) = fparam.EC_experimental_spectra(i,:);
    EO_experimental_spectrum(:) = fparam.EO_experimental_spectra(i,:);
    
    [unregularized_EC_spectrum, unregularized_EO_spectrum] = ForwardMap(reshape(fparam.unregularized_best_paramsets(i,1,:),[1 32]), EC_experimental_spectrum, EO_experimental_spectrum);
    [regularized_EC_spectrum, regularized_EO_spectrum] = ForwardMap(reshape(fparam.regularized_best_paramsets(i,1,:),[1 32]), EC_experimental_spectrum, EO_experimental_spectrum);
    
    
    count = count + 1;
    axes(ha(count));
    
    
    ym = max(EC_experimental_spectrum);
    ymax = ym + 0.2*ym;
    ymin = 0;
    
    p=plot(freq(9:end), EC_experimental_spectrum, 'LineWidth',2,'DisplayName','Experimental spectrum');
    p.Color(4) = 0.8;
    hold on
    
    p=plot(freq(9:end), unregularized_EC_spectrum(9:end), 'color', 'green','LineWidth',3,'DisplayName','Fitted spectrum 0');
    p.Color(4) = 0.5;
    hold on
    
    p=plot(freq(9:end), regularized_EC_spectrum(9:end), 'color', 'red', 'LineWidth',2,'DisplayName','Fitted spectrum 01');
    p.Color(4) = 0.7;
    hold on
    
    skL = gaminv(0.16,28,unregularized_EC_spectrum/28);
    skU = gaminv(0.84,28,unregularized_EC_spectrum/28);
    
    p=plot(freq(9:end), skL(9:end), 'color', 'black', 'LineWidth',1,'DisplayName','Q16');
    
    p.Color(4) = 0.7;
    hold on
    
    p=plot(freq(9:end), skU(9:end), 'color', 'black', 'LineWidth',1,'DisplayName','Q84');
    
    p.Color(4) = 0.7;
    hold on
    
    grid on;
    
    text(15,0.9*ym,['EC Subj ', num2str(fparam.subject_indices(i))])
    if count <= 1
        set(gca,'xticklabel',{[]})
    else
        xlabel('Frequency (Hz)');
    end
    
    if (mod(count,2)==1)
        ylabel('PSD');
    end
    set(gca,'ytick',[])
    ylim([ymin ymax]);
    xlim([1.5 20.5]);
    
    set(gca, 'YGrid', 'off', 'XGrid', 'off');
    ax=gca;
    ax.GridColor= 'c';
    ax.GridAlpha=0.99;
    
   
    count = count + 1;
    axes(ha(count));
    
    
    ym = max(EO_experimental_spectrum);
    ymax = ym + 0.2*ym;
    ymin = 0;
    
    
    p=plot(freq(9:end), EO_experimental_spectrum, 'LineWidth',2);
    p.Color(4) = 0.8;
    hold on
    
    p=plot(freq(9:end), unregularized_EO_spectrum(9:end), 'color', 'green','LineWidth',2);
    p.Color(4) = 0.8;
    hold on
    
    p=plot(freq(9:end), regularized_EO_spectrum(9:end), 'color', 'red', 'LineWidth',2);
    p.Color(4) = 0.7;
    hold on
    
    skL = gaminv(0.16,28,unregularized_EO_spectrum/28);
    skU = gaminv(0.84,28,unregularized_EO_spectrum/28);
    
    p=plot(freq(9:end), skL(9:end), 'color', 'black', 'LineWidth',1,'DisplayName','Q16');
    p.Color(4) = 0.7;
    hold on
    
    p=plot(freq(9:end), skU(9:end), 'color', 'black', 'LineWidth',1,'DisplayName','Q84');
    p.Color(4) = 0.7;
    hold on
    
    grid on;
    text(15,0.9*ym,['EO Subj ', num2str(fparam.subject_indices(i))]);
    if count <= 1
        set(gca,'xticklabel',{[]})
    else
        xlabel('Frequency (Hz)');
    end
    
    if (mod(count,2)==1)
        ylabel('PSD');
    end
    set(gca,'ytick',[])
    ylim([ymin ymax]);
    xlim([1.5 20.5]);
    set(gca, 'YGrid', 'off', 'XGrid', 'off');
    ax=gca;
    ax.GridColor= 'c';
    ax.GridAlpha=0.99;
end

axes(ha(11));

p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on
p=plot([0 0],[0 0], 'color', 'white','LineWidth',2);
p.Color(4) = 0;
hold on
p=plot([0 0],[0 0], 'color', [0    0.4470    0.7410],'LineWidth',2);
p.Color(4) = 0.8;
hold on
p=plot([0 0],[0 0], 'color', 'green','LineWidth',2);
p.Color(4) = 0.8;
hold on
p=plot([0 0],[0 0], 'color', 'black','LineWidth',1);
p.Color(4) = 0.7;
hold on
p=plot([0 0],[0 0], 'color', 'red','LineWidth',2);
p.Color(4) = 0.7;


L=legend('', '','Experimental spectrum','Unregularized, fitted model spectrum', 'Q16 and Q84 of the gamma distribution for the unregularized fitted spectrum', 'Regularized, fitted model spectrum (\lambda=0.1)', 'location','west');
L.FontSize = 12;
legend boxoff
set(gca,'Visible','off')

axes(ha(12));
set(gca,'Visible','off')

txt_obj = findall(f,'Type','text');
set(txt_obj,'FontName','Arial','FontSize',12);

end
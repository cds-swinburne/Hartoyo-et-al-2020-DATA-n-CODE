function ShowDifferentDegreeOfAlphaBlocking(fparam)

order = fparam.sorted_idx;

f=figure('OuterPosition',[563 118 664 795]);

[ha, pos] = tight_subplot(3,2,[0.02 0],[.1 .007],[.075 .005]);

count = 0;
freq = (0:80)/4;
choice = [2    17    34    63    76];

for i=order(choice)
    count = count + 1;
    axes(ha(count));
    
    experimental_spec_ec(:) = fparam.EC_experimental_spectra(i,:);
    experimental_spec_eo(:) = fparam.EO_experimental_spectra(i,:);
    
    ym = max([max(experimental_spec_ec), max(experimental_spec_eo)]);
    ymax = ym + 0.3*ym;
    ymin = 0;
    
    plot(freq(9:end), experimental_spec_ec, 'LineWidth',2);
    hold on
    
    plot(freq(9:end), experimental_spec_eo, 'LineWidth',2);
    hold on
    
    axis manual;
    
    x = (1.5 : 20.5);
    curve1 = ymax*x.^0;
    curve2 = (ym+0.05*ym)*x.^0;
    
    plot(x, curve1, 'color', 'white');
    hold on;
    plot(x, curve2, 'color', 'white');
    x2 = [x, fliplr(x)];
    inBetween = [curve1, fliplr(curve2)];
    fill(x2, inBetween, 'white');
    grid on;
    
    text(2,ym+0.175*ym,['Subject ', num2str(fparam.subject_indices(i)), ' [D_{JS} = ', num2str(fparam.sorted_JSDs(choice(count)),'%5.4f'),']'])
    if count <= 3
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
    set(gca, 'YGrid', 'off', 'XGrid', 'on');
end

axes(ha(6));

plot([0 0],[0 0], 'LineWidth',2)
hold on

plot([0 0],[0 0], 'LineWidth',2)
L=legend(sprintf('Eyes closed (EC)\nnormalized\nexperimental spectrum'), sprintf('Eyes open (EO)\nnormalized\nexperimental spectrum'), 'Location','south');
L.FontSize = 12;
legend boxoff;
set(gca,'Visible','off');

txt_obj = findall(f,'Type','text');
set(txt_obj,'FontName','Arial','FontSize',12);

end
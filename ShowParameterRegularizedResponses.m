function ShowParameterRegularizedResponses(fparam)

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

f=figure('OuterPosition',[536 9 761 984]);
[ha, pos] = tight_subplot(5,2,[.02 .08],[.07 .03],[.08 .01]);

for j=1:9
    axes(ha(j));

    axis manual
    x = [0 0.32];
    y = 0*x;
    plot(x,y, ':b');
    
    hold on
    axis auto
    
    mns = zeros([82,1]);
    count = 0;
    for i=fparam.sorted_idx
        count = count + 1;
        mn = fparam.regularized_response_statistics(i,j,1);
        mns(count) = mn;
        q1 = fparam.regularized_response_statistics(i,j,3);
        q2 = fparam.regularized_response_statistics(i,j,4);
        plot([fparam.spectra_JSDs(i) fparam.spectra_JSDs(i)], [q1 q2], 'Color',[0.5 0.5 0.5], 'LineWidth', 0.5);
        hold on
    end
    
    
    plot(fparam.spectra_JSDs(fparam.sorted_idx), mns, 'o', 'MarkerSize',2, 'MarkerEdgeColor','black', 'MarkerFaceColor','black', 'DisplayName','Mean sum');
    hold on;
    
    
    plot([0 0.32], [0 fparam.regularized_parameter_response_gradient_statistics(j,1)*0.32], '-b', 'LineWidth', 1.5);
    hold on;
    
    
    ylabel(['\Delta', labl{j}]);
    xlim([0 0.32]);
    if j~=8
        text(0.025, 0.15, ['d', labl{j},'/dD_{JS} = ', num2str(fparam.regularized_parameter_response_gradient_statistics(j,1),2), ' \pm ' , num2str(fparam.regularized_parameter_response_gradient_statistics(j,2),2)]);
        ylim([-0.2 0.2]);
    else 
        text(0.025, 0.25, ['d', labl{j},'/dD_{JS} = ', num2str(fparam.regularized_parameter_response_gradient_statistics(j,1),2), ' \pm ' , num2str(fparam.regularized_parameter_response_gradient_statistics(j,2),2)]);
        ylim([-0.1 0.3])
    end
    
    if j==8 || j==9
        xlabel('D_{JS}');
    else
        set(gca,'xticklabel',{[]})
    end
end

axes(ha(10));

p1 = plot([0 0],[0 0], 'o', 'MarkerSize',2, 'MarkerEdgeColor','black', 'MarkerFaceColor','black', 'DisplayName','Mean response');
hold on

plot([0 0],[0 0], 'o', 'MarkerSize',2, 'MarkerEdgeColor','white', 'MarkerFaceColor','white');
hold on

p2 = plot([0 0],[0 0], 'Color',[0.5 0.5 0.5], 'LineWidth', 0.5 ,'DisplayName','25% to 75% quantile');
hold on

p3 = plot([0 0],[0 0], '-b', 'LineWidth', 1.5, 'DisplayName','Trend line');


set(gca,'xtick',[])
set(gca,'ytick',[])
L=legend([p1 p2 p3], 'location', 'southwest');
L.FontSize = 11;
legend boxoff
set(gca,'Visible','off')

txt_obj = findall(f,'Type','text');
set(txt_obj,'FontName','Arial','FontSize',11);

end
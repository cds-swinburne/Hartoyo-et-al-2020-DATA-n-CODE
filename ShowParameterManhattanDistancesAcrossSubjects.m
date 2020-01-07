function ShowParameterManhattanDistancesAcrossSubjects(fparam)

f=figure('OuterPosition',[456 329 849 498]);


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
    mn = fparam.regularized_parameter_manhattan_distances_statistics(i,1);
    mns(count) = mn;
    q1 = fparam.regularized_parameter_manhattan_distances_statistics(i,3);
    q2 = fparam.regularized_parameter_manhattan_distances_statistics(i,4);
    p1 = plot([fparam.spectra_JSDs(i) fparam.spectra_JSDs(i)], [q1 q2], 'Color',[0.5 0.5 0.5], 'LineWidth', 1, 'DisplayName','25% to 75% quantile');
    hold on
end


p2 = plot(fparam.spectra_JSDs(fparam.sorted_idx), mns, 'o', 'MarkerSize',4, 'MarkerEdgeColor','black', 'MarkerFaceColor','black', 'DisplayName','Mean sum');
hold on;


p3 = plot([0 0.32], [0 fparam.regularized_parameter_manhattan_distances_gradient_statistics(1)*0.32], '-b', 'LineWidth', 2, 'DisplayName','Trend line');
hold on;

text(0.025, 0.45, ['d\Sigma_n|\Delta\theta_n|/dD_{JS} = ', num2str(fparam.regularized_parameter_manhattan_distances_gradient_statistics(1),2), ' \pm ' , num2str(fparam.regularized_parameter_manhattan_distances_gradient_statistics(2),2)])


set(gca,'ytick',[0.1 0.2 0.3 0.4 0.5])

xlim([0 0.32]);


xlabel('D_{JS}');

ylabel(['\Sigma_n|\Delta\theta_n|']);

L=legend([p2 p1 p3], 'location', 'southeast');
L.FontSize = 11;

txt_obj = findall(f,'Type','text');
set(txt_obj,'FontName','Arial','FontSize',12);


end


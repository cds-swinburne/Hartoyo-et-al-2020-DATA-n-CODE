function ShowRegularizedFittingErrorCurve(fparam)

f=figure('OuterPosition',[289 215 1240 648]);

lambdas = [0 1e-5 5e-5 1e-4 5e-4 1e-3 5e-3 1e-2 5e-2 1e-1 5e-1 1 5 10 50 100 500 1000 5000 10000];

s0 = plot(lambdas(2:20), fparam.error_statistics(2:20,2),'-o','DisplayName','Q50 of best fit errors across 82 subjects (regularized)', 'LineWidth',2, 'color', [0 0.4470 0.7410]);
hold on
axis manual
s1= semilogx([1E-6 1E5],[fparam.error_statistics(1,3) fparam.error_statistics(1,3)], '--r','DisplayName','Q84 of best fit errors across 82 subjects (unregularized)', 'LineWidth',2);
hold on
s2 = semilogx([1E-6 1E5],[fparam.error_statistics(1,2) fparam.error_statistics(1,2)], '--g','DisplayName','Q50 of best fit errors across 82 subjects (unregularized)', 'LineWidth',2, 'color', [0.4118    0.4118    0.4118]);
hold on
s3 = semilogx([1E-6 1E5],[fparam.error_statistics(1,1) fparam.error_statistics(1,1)], '--g','DisplayName','Q16 of best fit errors across 82 subjects (unregularized)', 'LineWidth',2);
hold on
plot([1E-1 1E-1],[0.15*fparam.error_statistics(10,2) 0.9625*fparam.error_statistics(10,2)], '--m','DisplayName','Q16 of best fit errors across 82 subjects (unregularized)', 'LineWidth',1.5);
s4 = plot([1E-1 1E-1],[0.15*fparam.error_statistics(10,2) 0.15*fparam.error_statistics(10,2)], 'vm','DisplayName','\lambda of rational choice', 'LineWidth',2);

grid on;

xticks(lambdas(2:2:20));

set(gca,'xscale','log')
xlabel('Regularization parameter, \lambda');
ylabel('Squared error');
ylim([0 7E-3]);
xlim([5E-6 2E4]);
L=legend([s0 s1 s2 s3 s4], 'location', 'northwest');
L.FontSize = 11;

txt_obj = findall(f,'Type','text');
set(txt_obj,'FontName','Arial','FontSize',12);


end
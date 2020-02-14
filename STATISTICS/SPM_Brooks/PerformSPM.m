function [spmi, tempconprobRESPONSE] = PerformSPM_all_only_BETWEEN(SUBJ, A,MATRIXCON, boni, type, plane, joint, conditions, plotall)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

stlye = {'-', '--', '--', '-', '-', '-', '-'};
farbe = {[0 0.4470 0.7410]	, [0.8500 0.3250 0.0980]	, [0.9290 0.6940 0.1250]	 ,[0.4940 0.1840 0.5560]	, [0.4660 0.6740 0.1880]	, [0.3010 0.7450 0.9330],	[0 0 0]};
farbe = {[0 0 0]	, [65 105 225]/255	, [220,20,60]/255	 ,[0.4940 0.1840 0.5560]	, [0.4660 0.6740 0.1880]	, [0.3010 0.7450 0.9330],	[0 0 0]};

cleanconnanes = strrep(conditions, '_', ' ');
%groupmean plot
 Y = MATRIXCON;
 Y= (Y(:,13:188)); % 5% weggeschnitten
Y1         = Y(A==0,:);
Y2         = Y(A==1,:);
Y3         = Y(A==2,:);
%Y4         = Y(A==3,:);
%Y5         = Y(A==4,:);
%Y6         = Y(A==5,:);
% Y7         = Y(A==6,:);
tf = strcmp(type,'ANGLES');
tf2 = strcmp(type,'MOMENTS');
if tf==1
    unit = ('[°]');
elseif tf2==1
    unit = ('[Nm/kg]');
else 
    unit = ('[°/s]');
end
SUBJ = SUBJ(1:300,1);
A = A(1:300,1);
MATRIXCON = MATRIXCON(1:300,:);
%calculate responsness
u=1;
while u <=100
 
    tempprobcon1 = (MATRIXCON(u,:));
 
     tempprobcon2 = (MATRIXCON(u+100,:));
   
    tempprobcon3 =  (MATRIXCON(u+200,:));
    
    
    tempconprob = [tempprobcon1; tempprobcon2; tempprobcon3];
    tempconprobSTD(u,:) = std (tempconprob);
    tempconprobRESPONSE(u,1) = mean (tempconprobSTD(u,:));
    u=u+1;
end
%(1) Conduct SPM analysis:
%spm_bs    = spm1d.stats.anova1(MATRIXCON, A);  %between-subjects model
spm_ws    = spm1d.stats.anova1rm( MATRIXCON, A, SUBJ);  %within-subjects model
spmi.a  = spm_ws.inference(0.05);
%disp(spmi.(jointsandplanes{i, 1}));

if plotall ==1
% % % 
%figure('units','normalized','outerposition',[0 0 1 1])
plot(mean(Y1)','linewidth', 4 ,'LineStyle', (stlye{1, 1}), 'color', (farbe{1, 1}))
hold on
plot(mean(Y2)','linewidth', 4 ,'LineStyle', (stlye{1, 2}), 'color', (farbe{1, 2}))
plot(mean(Y3)','linewidth', 4 ,'LineStyle', (stlye{1, 3}), 'color', (farbe{1, 3}))
% % % sdplus =mean(Y2)+std(Y2);
% % % sdminus =-1*std(Y2)+mean(Y2);
% % % plot (sdplus)
% % % plot (sdminus)
% plot(mean(Y4)','linewidth', 4 ,'LineStyle', (stlye{1, 4}), 'color', (farbe{1, 4}))
% plot(mean(Y5)','linewidth', 4 ,'LineStyle', (stlye{1, 5}), 'color', (farbe{1, 5}))
% plot(mean(Y6)','linewidth', 4 ,'LineStyle', (stlye{1, 6}), 'color', (farbe{1, 6}))
% plot(mean(Y7)','linewidth', 4 ,'LineStyle', (stlye{1, 7}), 'color', (farbe{1, 7}))
set(gca, 'LineWidth', 1.5);
xticks([1 176/4 88 3*176/4 176 ])
xticklabels({'5','25','50','75','95'})
% xticks([1  201/4 2*201/4 3*201/4 201])
% xticklabels({'0','25','50','75', '100'})

% xticks([201/16 201/4 2*201/4 3*201/4 201-201/16])
% xticklabels({'5','25','50','75','95'})
set(gca, 'FontSize', 16);
set(gca, 'Fontname', 'Arial');
xlim([1, 201]);
xlim([1, 180]);
xlabel('[Stance Phase %]');
temptitle =  strrep( type, '_', ' ');
title (temptitle)
tempylabel =  strrep(strcat( joint,'_' ,plane, '_', unit), '_', ' ');
ylabel (tempylabel)
leg = legend (cleanconnanes, 'interpreter', 'none','FontSize',16);
leg = legend ({'Homogeneous Pseudo Posts', 'Medial Pseudo Posts','Lateral Pseudo Post'}, 'interpreter', 'none','FontSize',16);
set (leg, 'Location', 'Best')
legend boxoff
box off
grenzeny= ylim;
try
[cluster] = cluster_extrahieren(Y,spmi);
end
  try
    p1 = patch('vertices', [cluster(1,1), grenzeny(1,1); cluster(1,1), grenzeny(1,2); cluster(1,2),grenzeny(1,2) ;  cluster(1,2), grenzeny(1,1)], ...
        'faces', [1, 2, 3, 4], ...
        'FaceColor', 'k', ...
        'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
    p2 = patch('vertices', [cluster(2,1), grenzeny(1,1); cluster(2,1), grenzeny(1,2); cluster(2,2),grenzeny(1,2) ;  cluster(2,2), grenzeny(1,1)], ...
        'faces', [1, 2, 3, 4], ...
        'FaceColor', 'k', ...
        'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
        p3 = patch('vertices', [cluster(3,1), grenzeny(1,1); cluster(3,1), grenzeny(1,2); cluster(3,2),grenzeny(1,2) ;  cluster(3,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
      
        p4 = patch('vertices', [cluster(4,1), grenzeny(1,1); cluster(4,1), grenzeny(1,2); cluster(4,2),grenzeny(1,2) ;  cluster(4,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
        p5 = patch('vertices', [cluster(5,1), grenzeny(1,1); cluster(5,1), grenzeny(1,2); cluster(5,2),grenzeny(1,2) ;  cluster(5,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
        
        p6 = patch('vertices', [cluster(6,1), grenzeny(1,1); cluster(6,1), grenzeny(1,2); cluster(6,2),grenzeny(1,2) ;  cluster(6,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
        p7 = patch('vertices', [cluster(7,1), grenzeny(1,1); cluster(7,1), grenzeny(1,2); cluster(7,2),grenzeny(1,2) ;  cluster(7,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
        p8 = patch('vertices', [cluster(8,1), grenzeny(1,1); cluster(8,1), grenzeny(1,2); cluster(8,2),grenzeny(1,2) ;  cluster(8,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
  try
        p9 = patch('vertices', [cluster(9,1), grenzeny(1,1); cluster(9,1), grenzeny(1,2); cluster(9,2),grenzeny(1,2) ;  cluster(9,2), grenzeny(1,1)], ...
            'faces', [1, 2, 3, 4], ...
            'FaceColor', 'k', ...
            'FaceAlpha', 0.05, 'LineStyle', 'none');
  end
    

hold off
try
    toptargetfolder= ('SPM_Results');
 mkdir(strcat('C:\Users\maipa\Desktop\', toptargetfolder))
 cd (strcat('C:\Users\maipa\Desktop\', toptargetfolder))


filename =strrep(strcat(temptitle,joint,plane,'.svg'), '_', ' ');
saveas(gcf,filename)
end






%(2) Plot:
figure()
subplot (2,1,1)
title ( (strcat(type, '_',joint,'_',plane)), 'interpreter', 'none')
set(gca,'xtick',[])
hold on
spmi.a.plot(); %within subkect model
spmi.a.plot_threshold_label();
spmi.a.plot_p_values();
hold on
plot(spm_ws.z, 'r')  %within-subjects model
set(gca, 'LineWidth', 1.5);
xticks([1 201/16 201/4 2*201/4 3*201/4 201-201/16 201])
xticklabels({'0','5','25','50','75','95', '100'})
set(gca, 'FontSize', 16);
set(gca, 'Fontname', 'Arial');
xlim([1, 201]);
xlabel('[Stance Phase %]');
hold off
else
end
if boni==1;
    
    
    %%% separate into groups:
    Y1         = Y(A==0,:);
    Y2         = Y(A==1,:);
    Y3         = Y(A==2,:);
    Y4         = Y(A==3,:);
    Y5         = Y(A==4,:);
    Y6         = Y(A==5,:);
    Y7         = Y(A==6,:);
    
    %(1) Conduct SPM analysis:
    t12        = spm1d.stats.ttest2(Y1, Y2);
    t13        = spm1d.stats.ttest2(Y1, Y3);
    t14        = spm1d.stats.ttest2(Y1, Y4);
    t15        = spm1d.stats.ttest2(Y1, Y5);
    t16        = spm1d.stats.ttest2(Y1, Y6);
    t17        = spm1d.stats.ttest2(Y1, Y7);
    
    t23        = spm1d.stats.ttest2(Y2, Y3);
    t24        = spm1d.stats.ttest2(Y2, Y4);
    t25        = spm1d.stats.ttest2(Y2, Y5);
    t26        = spm1d.stats.ttest2(Y2, Y6);
    t27        = spm1d.stats.ttest2(Y2, Y7);
    
    
    t34        = spm1d.stats.ttest2(Y3, Y4);
    t35        = spm1d.stats.ttest2(Y3, Y5);
    t36        = spm1d.stats.ttest2(Y3, Y6);
    t37        = spm1d.stats.ttest2(Y3, Y7);
    
    t45        = spm1d.stats.ttest2(Y4, Y5);
    t46        = spm1d.stats.ttest2(Y4, Y6);
    t47       = spm1d.stats.ttest2(Y4, Y7);
    
    t56        = spm1d.stats.ttest2(Y5, Y6);
    t57        = spm1d.stats.ttest2(Y5, Y7);
    
    t67        = spm1d.stats.ttest2(Y6, Y7);
    
    
    % inference:
    alpha      = 0.05;
    nTests     = 121;
    p_critical = spm1d.util.p_critical_bonf(alpha, nTests);
    t12i       = t12.inference(p_critical, 'two_tailed',true);
    t13i       = t13.inference(p_critical, 'two_tailed',true);
    t14i       = t14.inference(p_critical, 'two_tailed',true);
    t15i       = t15.inference(p_critical, 'two_tailed',true);
    t16i       = t16.inference(p_critical, 'two_tailed',true);
    t17i       = t17.inference(p_critical, 'two_tailed',true);
    
    t23i       = t23.inference(p_critical, 'two_tailed',true);
    t24i       = t24.inference(p_critical, 'two_tailed',true);
    t25i       = t25.inference(p_critical, 'two_tailed',true);
    t26i       = t26.inference(p_critical, 'two_tailed',true);
    t27i       = t27.inference(p_critical, 'two_tailed',true);
    
    t34i       = t34.inference(p_critical, 'two_tailed',true);
    t35i       = t35.inference(p_critical, 'two_tailed',true);
    t36i       = t36.inference(p_critical, 'two_tailed',true);
    t37i       = t37.inference(p_critical, 'two_tailed',true);
    
    t45i       = t45.inference(p_critical, 'two_tailed',true);
    t46i       = t46.inference(p_critical, 'two_tailed',true);
    t47i       = t47.inference(p_critical, 'two_tailed',true);
    
    t56i       = t56.inference(p_critical, 'two_tailed',true);
    t57i       = t57.inference(p_critical, 'two_tailed',true);
    
    t67i       = t67.inference(p_critical, 'two_tailed',true);
    
    %(2) Plot:
    figure()
    subplot(321);  t12i.plot();   title('A - B')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(322);  t13i.plot(); title('A - C')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(323);  t14i.plot();  title('A - D')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(324);  t15i.plot();    title('A - E')
    xlim([1, 201]);
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(325);  t16i.plot(); title('A - F')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(326);  t17i.plot(); title('A - G')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    
    
    
    figure()
    subplot(321);  t23i.plot(); title('B - C')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(322);  t24i.plot();  title('B - D')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(323);  t25i.plot();    title('B - E')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(324);  t26i.plot(); title('B - F')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(325);  t27i.plot(); title('B - G')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    
    figure()
    subplot(221);  t34i.plot();  title('C - D')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(222);  t35i.plot();    title('C - E')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(223);  t36i.plot(); title('C - F')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(224);  t37i.plot(); title('C - G')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    
    figure()
    subplot(221);  t45i.plot();    title('D - E')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(222);  t46i.plot(); title('D - F')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(223);  t47i.plot(); title('D - G')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    
    figure()
    subplot(121); t56i.plot();    title('E - F')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    subplot(122);  t57i.plot(); title('E - G')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    
    
    figure()
    t67i.plot();    title('F - G')
    set(gca, 'XTick', [1:50:201]);
    set(gca, 'XTickLabel', {'0', '25', '50', '75', '100'});
    xlim([1, 201]);
    
    
else
    disp ('no post hoc')
end
end


function [cluster] = cluster_extrahieren(Y,spmi)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here


ncluster = length (spmi.a.clusters);

for i = 1 :ncluster
cluster(i,:)= round (spmi.a.clusters{1, i}.endpoints);

end
end




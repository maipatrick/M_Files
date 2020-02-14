clc
clear
close all
warning off

[FRAMEWORK, n_subjects] = get_file_framework_generell('C:\IBO\Brooks_Tuned_Zones\HMP_Baseline', '*.mat');



plotall = 0;
plotbl = 0;

Groups{1} = [2,4,5,10]; %Walking like
Groups{2} = [1,3,6,7]; %Squat Like
Groups{3} = [8]; %Stairs
Groups{4} = [9]; %Step Up

runo = 1;
for g1 = 1:length(Groups{1})
    for g2 = 1:length(Groups{2})
        corder(runo,:) = [Groups{1}(g1), Groups{2}(g2), 8, 9];
        runo = runo+1;
    end
end


% C = nchoosek([1:10],3);
% C = [1:10]
C = corder;

for c = 1:size(C,1)
    disp(c/24*100)
    for n = 1:n_subjects
        M.X = [];
        M.Y = [];
        M.Z = [];
        %         disp(n)
        for i = C(c,:)%1:length(FRAMEWORK(n).filename)
            name = FRAMEWORK(n).filename{i};
            
            if ~isempty(findstr(name, 'Chair')) || ~isempty(findstr(name, 'Step')) || ~isempty(findstr(name, '_Squat')) || ~isempty(findstr(name, '_Split'))%&& 1 == 2
                load([FRAMEWORK(n).pathname{1}, FRAMEWORK(n).filename{i}], 'WINKEL');
                
                sname = fieldnames(WINKEL);
                
                KNEE.Y= WINKEL.(sname{1, 1}).JOINT.Classic.Right_Knee.grad.Y;
                KNEE.X= WINKEL.(sname{1, 1}).JOINT.Classic.Right_Knee.grad.X;
                KNEE.Z= WINKEL.(sname{1, 1}).JOINT.Classic.Right_Knee.grad.Z;
                
                %max knee flexion angle get the most prominent peaks
                [peakVals,peakLocs]=findpeaks(KNEE.Y, 'MinPeakProminence',20, 'MinPeakHeight', 45, 'MinPeakDistance', 200);%, 'SortStr','descend');
                
                StartFlexFound = zeros(length(peakVals));
                for p = 1:length(peakVals)
                    for pp = peakLocs(p):-1:1
                        if (KNEE.Y(pp) < 61)
                            EndFlex(p) = pp;
                            break
                        end
                    end
                    for pp = peakLocs(p):-1:1
                        if (KNEE.Y(pp) < 5) || (((KNEE.Y(pp) < KNEE.Y(pp-1)) && (KNEE.Y(pp) < KNEE.Y(pp-3)) && (KNEE.Y(pp) < KNEE.Y(pp-30)) && (KNEE.Y(pp) < KNEE.Y(pp-60))) && KNEE.Y(pp) < 61)
                            StartFlexFound(p) = 1;
                            StartFlex(p) = pp;
                            break
                        end
                    end
                end
                if plotall
                    figure
                    plot(KNEE.Y);
                    hold on
                    plot(KNEE.X);
                    plot(peakLocs, peakVals, 'ko');
                    plot(StartFlex, KNEE.Y(StartFlex), 'go');
                    plot(EndFlex, KNEE.Y(EndFlex), 'go');
                end
                for ii = 1:length(StartFlex)
                    INT.KNEE.X(1:56,ii) = NaN;
                    INT.KNEE.Y(1:56,ii) = NaN;
                    INT.KNEE.Z(1:56,ii) = NaN;
                    %                 try
                    INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii) = [round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))];
                    INT.KNEE.X([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii) = interp1(KNEE.Y(StartFlex(ii):EndFlex(ii)), KNEE.X(StartFlex(ii):EndFlex(ii)), INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii));
                    INT.KNEE.Z([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii) = interp1(KNEE.Y(StartFlex(ii):EndFlex(ii)), KNEE.Z(StartFlex(ii):EndFlex(ii)), INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii));
                    %                 catch
                    %                     INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-3,ii) = [round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))];
                    %                     INT.KNEE.X([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-3,ii) = interp1(KNEE.Y(StartFlex(ii):EndFlex(ii)), KNEE.X(StartFlex(ii):EndFlex(ii)), INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-3,ii));
                    %                     INT.KNEE.Z([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-3,ii) = interp1(KNEE.Y(StartFlex(ii):EndFlex(ii)), KNEE.Z(StartFlex(ii):EndFlex(ii)), INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-3,ii));
                    %                 end
                end
                if plotall
                    figure
                    plot(INT.KNEE.Y, INT.KNEE.X);
                end
                M.X = [M.X, INT.KNEE.X(1:56,:)];
                M.Y = [M.Y, INT.KNEE.Y(1:56,:)];
                M.Z = [M.Z, INT.KNEE.Z(1:56,:)];
            end
            
            
            clear INT PF TD StartFlex EndFlex
            
            if ~isempty(findstr(name, 'Forward')) % && 1 == 2
                load([FRAMEWORK(n).pathname{1}, FRAMEWORK(n).filename{i}], 'WINKEL');
                
                sname = fieldnames(WINKEL);
                
                KNEE.Y= WINKEL.(sname{1, 1}).JOINT.Classic.Right_Knee.grad.Y;
                KNEE.X= WINKEL.(sname{1, 1}).JOINT.Classic.Right_Knee.grad.X;
                KNEE.Z= WINKEL.(sname{1, 1}).JOINT.Classic.Right_Knee.grad.Z;
                
                %max knee flexion angle get the most prominent peaks
                [peakVals,peakLocs]=findpeaks(KNEE.Y, 'MinPeakProminence',20, 'MinPeakHeight', 45, 'MinPeakDistance', 500, 'MinPeakWidth', 150 );%, 'SortStr','descend');
                
                StartFlexFound = zeros(length(peakVals));
                for p = 1:length(peakVals)
                    for pp = peakLocs(p):-1:1
                        if (KNEE.Y(pp) < 61)
                            EndFlex(p) = pp;
                            break
                        end
                    end
                    for pp = peakLocs(p):-1:1
                        if (KNEE.Y(pp) < 5) || (((KNEE.Y(pp) < KNEE.Y(pp-1)) && (KNEE.Y(pp) < KNEE.Y(pp-3)) && (KNEE.Y(pp) < KNEE.Y(pp-30)) && (KNEE.Y(pp) < KNEE.Y(pp-60))) && KNEE.Y(pp) < 61)
                            StartFlexFound(p) = 1;
                            StartFlex(p) = pp;
                            break
                        end
                    end
                end
                if plotall
                    figure
                    plot(KNEE.Y);
                    hold on
                    plot(KNEE.X);
                    plot(peakLocs, peakVals, 'ko');
                    plot(StartFlex, KNEE.Y(StartFlex), 'go');
                    plot(EndFlex, KNEE.Y(EndFlex), 'go');
                end
                for ii = 1:length(StartFlex)
                    INT.KNEE.X(1:56,ii) = NaN;
                    INT.KNEE.Y(1:56,ii) = NaN;
                    INT.KNEE.Z(1:56,ii) = NaN;
                    INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii) = [round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))];
                    INT.KNEE.X([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii) = interp1(KNEE.Y(StartFlex(ii):EndFlex(ii)), KNEE.X(StartFlex(ii):EndFlex(ii)), INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii));
                    INT.KNEE.Z([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii) = interp1(KNEE.Y(StartFlex(ii):EndFlex(ii)), KNEE.Z(StartFlex(ii):EndFlex(ii)), INT.KNEE.Y([round(KNEE.Y(StartFlex(ii))):round(KNEE.Y(EndFlex(ii)))]-round(KNEE.Y(StartFlex(ii)))+1,ii));
                end
                if plotall
                    figure
                    plot(INT.KNEE.Y, INT.KNEE.X);
                end
                M.X = [M.X, INT.KNEE.X(1:56,:)];
                M.Y = [M.Y, INT.KNEE.Y(1:56,:)];
                M.Z = [M.Z, INT.KNEE.Z(1:56,:)];
                
                
            end
            
            clear INT PF TD StartFlex EndFlex
            
            if ~isempty(findstr(name, 'Walking')) || ~isempty(findstr(name, 'Ramp')) || ~isempty(findstr(name, 'StairsDown'))
                load([FRAMEWORK(n).pathname{1}, FRAMEWORK(n).filename{i}], 'WINKEL', 'TD', 'PF');
                
                sname = fieldnames(WINKEL);
                
                for s  = 1:length(sname)
                    for t = 1:length(TD.(sname{s}))
                        W = WINKEL.(sname{s}).JOINT.Classic.Right_Knee.grad.Y;
                        for r = TD.(sname{s})(t):TD.(sname{s})(t)+100
                            if (W(r) < 5) && (W(r+1) > 5)
                                TD.(sname{s})(t) = r+1;
                            end
                            if isempty(findstr(name, 'RampDown')) && isempty(findstr(name, 'StairsDown'))
                                if (W(r+1)<W(r)) && (W(r+2)<W(r)) && (W(r+3)<W(r)) && (W(r+4)<W(r)) && (W(r+5)<W(r))
                                    PF.(sname{s})(t) = r;
                                    break
                                end
                            else
                                PF.(sname{s})(t) = round(PF.(sname{s})(t));
                            end
                        end
                        KNEE.Y= WINKEL.(sname{s}).JOINT.Classic.Right_Knee.grad.Y(TD.(sname{s})(t):PF.(sname{s})(t));
                        KNEE.X= WINKEL.(sname{s}).JOINT.Classic.Right_Knee.grad.X(TD.(sname{s})(t):PF.(sname{s})(t));
                        KNEE.Z= WINKEL.(sname{s}).JOINT.Classic.Right_Knee.grad.Z(TD.(sname{s})(t):PF.(sname{s})(t));
                        
                        
                        INT.KNEE.X(1:56,t) = NaN;
                        INT.KNEE.Y(1:56,t) = NaN;
                        INT.KNEE.Z(1:56,t) = NaN;
                        try
                            INT.KNEE.Y([round(KNEE.Y(1)):round(KNEE.Y(end))]-4,t) = [round(KNEE.Y(1)):round(KNEE.Y(end))];
                            INT.KNEE.X([round(KNEE.Y(1)):round(KNEE.Y(end))]-4,t) = interp1(KNEE.Y, KNEE.X, INT.KNEE.Y([round(KNEE.Y(1)):round(KNEE.Y(end))]-4,t));
                            INT.KNEE.Z([round(KNEE.Y(1)):round(KNEE.Y(end))]-4,t) = interp1(KNEE.Y, KNEE.Z, INT.KNEE.Y([round(KNEE.Y(1)):round(KNEE.Y(end))]-4,t));
                        catch
                            INT.KNEE.Y([round(KNEE.Y(1)):round(KNEE.Y(end))]-3,t) = [round(KNEE.Y(1)):round(KNEE.Y(end))];
                            INT.KNEE.X([round(KNEE.Y(1)):round(KNEE.Y(end))]-3,t) = interp1(KNEE.Y, KNEE.X, INT.KNEE.Y([round(KNEE.Y(1)):round(KNEE.Y(end))]-3,t));
                            INT.KNEE.Z([round(KNEE.Y(1)):round(KNEE.Y(end))]-3,t) = interp1(KNEE.Y, KNEE.Z, INT.KNEE.Y([round(KNEE.Y(1)):round(KNEE.Y(end))]-3,t));
                        end
                        
                        
                        
                        
                    end
                    if plotall
                        figure
                        plot(INT.KNEE.Y, INT.KNEE.X);
                    end
                    M.X = [M.X, INT.KNEE.X(1:56,:)];
                    M.Y = [M.Y, INT.KNEE.Y(1:56,:)];
                    M.Z = [M.Z, INT.KNEE.Z(1:56,:)];
                    
                    clear INT
                end
            end
            
            clear TD PF
            
        end
        
        clear P50fit
        
        %% Plot Violin Plot
        % figure
        % XL = {'5','10','15','20','25','30','35','40','45', '50', '55', '60'};
        % set(gca, 'XLim', [0 65]);
        % set(gca, 'Xtick', 5:60);
        % set(gca, 'XtickLabel', XL);
        % NaNcheck = ~(sum(isnan(Knee_X(find(Knee_X(:,1)<5),2:end)),1) == size(Knee_X(find(Knee_X(:,1)<5)),1));
        % NaNcheckRunning = ~(sum(isnan(Knee_X(find(Knee_X(:,1)==5),2:end)),1) == size(Knee_X(find(Knee_X(:,1)==5)),1));
        XP = 1:11;
        if plotbl
            figure
                        [est,HDI,K,XP]=rst_data_plot_sw(M.X(1:5:55,:)','estimator','median')
            
            set(gca, 'XTick', XP)
            set(gca, 'XTickLabel', {'5','10','15','20','25','30','35','40','45','50','55'})
            title('Habitual Motion Path Baseline')
            box off
            set(gca, 'LineWidth', 1.5)
            xlabel('Knee Flexion Angle [°]')
            ylabel('Knee Abduction - Adduction Angle [°]')
            grid off
            
            hold on
        end
        P25 = prctile(M.X(1:5:55,:)',25,1);
        P50 = prctile(M.X(1:5:55,:)',50,1);
        P75 = prctile(M.X(1:5:55,:)',75,1);
        
        P25fitp = polyfit(XP, P25, 3);
        %             P50fitp = polyfit(XP, est, 3);
        P50fitp = polyfit(XP, P50, 3);
        P75fitp = polyfit(XP, P75, 3);
        
        P25fit = polyval(P25fitp, XP);
        P50fit = polyval(P50fitp, XP);
        P75fit = polyval(P75fitp, XP);
        
        
        if plotbl
            set(gcf, 'Position', [10 10 1200 800])
            
            X = [XP fliplr(XP)];
            Y = [P25fit fliplr(P75fit)];
            fill(X,Y,'r', 'FaceAlpha', 0.2, 'LineStyle', 'none');
            
            % plot(XP, P25fit, 'r--');
            L(1) = plot(XP, P50fit, 'r', 'LineWidth', 2);
            % plot(XP, P75fit, 'r--');
            
            set(gca, 'FontSize', 14)
        end
        FinalFit.X{c}(:,n) = P50fit;
        
        
        %%
        ZP = 1:11;
        if plotbl
            figure
                        [est,HDI,K,ZP]=rst_data_plot_sw(M.Z(1:5:55,:)','estimator','median')
            
            set(gca, 'XTick', ZP)
            set(gca, 'XTickLabel', {'5','10','15','20','25','30','35','40','45','50','55'})
            title('Habitual Motion Path Baseline')
            box off
            set(gca, 'LineWidth', 1.5)
            xlabel('Knee Flexion Angle [°]')
            ylabel('Knee External - Internal Rotation Angle [°]')
            grid off
            
            hold on
        end
        P25 = prctile(M.Z(1:5:55,:)',25,1);
        P50 = prctile(M.Z(1:5:55,:)',50,1);
        P75 = prctile(M.Z(1:5:55,:)',75,1);
        
        P25fitp = polyfit(ZP, P25, 3);
        %             P50fitp = polyfit(ZP, est, 3);
        P50fitp = polyfit(ZP, P50, 3);
        P75fitp = polyfit(ZP, P75, 3);
        
        P25fit = polyval(P25fitp, ZP);
        P50fit = polyval(P50fitp, ZP);
        P75fit = polyval(P75fitp, ZP);
        
        
        if plotbl
            set(gcf, 'Position', [10 10 1200 800])
            
            X = [ZP fliplr(ZP)];
            Y = [P25fit fliplr(P75fit)];
            fill(X,Y,'r', 'FaceAlpha', 0.2, 'LineStyle', 'none');
            
            % plot(XP, P25fit, 'r--');
            L(1) = plot(ZP, P50fit, 'r', 'LineWidth', 2);
            % plot(XP, P75fit, 'r--');
            
            set(gca, 'FontSize', 14)
        end
        
        FinalFit.Z{c}(:,n) = P50fit;
        
        %         pause
        
        clear M
    end
%     close all
end

% Find min RSME
run = 1;
for n = 1:3:22
    for c = 1:size(C,1)
       RMSE.X(run,c) = sqrt(mean((FinalFit.X{c}(:,n+1) - FinalFit.X{c}(:,n)).^2));
       RMSE.Z(run,c) = sqrt(mean((FinalFit.Z{c}(:,n+1) - FinalFit.Z{c}(:,n)).^2));
       RMSE.B(run,c) = RMSE.X(run,c) + RMSE.Z(run,c);
    end
    run = run+1;
end

[RMSEmin.X IndRMSEmin.X] = min(RMSE.X,[],2);
[Overall_RMSEmin.X, IndOverall_RSMEmin.X] = min(mean(RMSE.X, 1));
[Overall_RMSEmin.Z, IndOverall_RSMEmin.Z] = min(mean(RMSE.Z, 1));
[Overall_RMSEmin.B, IndOverall_RSMEmin.B] = min(mean(RMSE.B, 1));
%% Plot Variability
ord = [1 9 17,...
    2 10 18,...
    3 11 19,...
    4 12 20,...
    5 13 21,...
    6 14 22,...
    7 15 23,...
    8 16 24];

figure
for n = 1:24
    for c = 1:size(C,1)
        subplot(3,8,ord(n))
        plot(1:11, FinalFit.X{c}(:,n), 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5)
        hold on
        
            
        
        set(gca, 'Ylim', [-15 15])
        box off
        set(gca, 'LineWidth', 1.5)
    end
    
    plot(FinalFit.X{IndOverall_RSMEmin.X}(:,n), 'Color', 'g', 'LineWidth', 1.5)
%     plot(FinalFit.Z{40}(:,n), 'Color', 'b', 'LineWidth', 1.5)
    
    if ord(n) > 16
       set(gca, 'XTick', 1:2:11)
       set(gca, 'XTickLabel', {'5','15','25','35','45','55'})
       xlabel('Knee Flexion Angle [°]')
    else
        set(gca, 'XTick', [])
    end
    if (ord(n) == 1) || (ord(n) == 9) || (ord(n) == 17)
        ylabel('Knee Abduction - Adduction Angle [°]')
    end
end


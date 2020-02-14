clc
clear all
close all

%______________Load the Data_______________________________________________
load('E:\Brooks_TZ\TOE_STRENGTH\Processed_MAT\torques_BMI4_all_P066.mat'); % Loads toe strength data

%torques_BMI2_all.mat
%torques_BMI2_female.mat
%torques_BMI2_male.mat


[length,a]=size(toe_strength);
%length=30;

for i=1:length
   
    currentsubject=char(toe_strength(i,1));
    
    filename='E:\Brooks_TZ\FOOT_PRESSURE\Processed MAT\'; % creats path for foot_pressure
    path=char(cat(2,filename,currentsubject,'.mat'));
    
    foot_pressure=load(path);                             % loads foot_pressure data
    fieldname=fieldnames(foot_pressure.S);               % Reads fieldnames like Contact_area out of foot_pressure data
    fieldname=fieldname(3:5);                           % Reduces fieldnames to fieldnames of interest
    
    footregion=char(foot_pressure.S.Header_Region(2,:));
    footregion=string(footregion(:,5:end));
    % selects foot_pressure data of interest
    
    Contact_Areas.(currentsubject)= mean(foot_pressure.S.Contact_Areas);
    Max_Force.(currentsubject)= mean(foot_pressure.S.Max_Force);
    Peak_Pressure.(currentsubject)= mean(foot_pressure.S.Peak_Pressure);
  %  Max_mean_Pressure.(currentsubject)= mean(foot_pressure.S.Max_mean_Pressure);
end 

%______________Data_processing____________________________________________


data1=zeros(length,11); 
data2=zeros(length,11); 
data3=zeros(length,11); 
data4=zeros(length,11); 


for j=1:length
   
   currentsubject=char(toe_strength(j,1));
    
   data1(j,1)= cell2mat(toe_strength(j,2));
   data1(j,2:end)= Contact_Areas.(currentsubject);
   data1(j,2:end)=data1(j,2:end)/sum(Contact_Areas.(currentsubject))*100; %
   %Normalises Contact_Area to total Contact Area
   %Cont(j,1)=sum(Contact_Areas.(currentsubject))/cell2mat(toe_strength(j,7)) ; % Total contact Area of foot normalised to foot length
   %medial_Cont(j,1)=sum(Contact_Areas.(currentsubject)(1:2:5))/cell2mat(toe_strength(j,7));
    
   data2(j,1)= cell2mat(toe_strength(j,2));
   data2(j,2:end)= Max_Force.(currentsubject);
   data2(j,2:end)=data2(j,2:end)./ sum(Max_Force.(currentsubject))*100;% cell2mat(toe_strength(j,6));
   % Normalises Max_Force to total max force / body weight
   
   data3(j,1)= cell2mat(toe_strength(j,2));
   data3(j,2:end)= Peak_Pressure.(currentsubject);
  data3(j,2:end)=data3(j,2:end)./sum(Peak_Pressure.(currentsubject))*100;%/cell2mat(toe_strength(j,6))%/sum(Contact_Areas.(currentsubject));
  % Normalises Peak_Pressure to body weight & Total Contact Area
   
 %  data4(j,1)= cell2mat(toe_strength(j,2));
 %  data4(j,2:end)= Max_mean_Pressure.(currentsubject);
 % data4(j,2:end)=data4(j,2:end)./sum(Max_mean_Pressure.(currentsubject));%/cell2mat(toe_strength(j,6));
  % Normalises Max_mean_Pressure to body weight
  
end

%% Statistics !!!

    

for e=1:size(fieldname,1)
    
    if e==1
        DAT=data1;
    elseif e==2
        DAT=data2;
    elseif e==3
        DAT=data3;
   % elseif e==4
    %   DAT=data4;
    end
    
    %% Tests for Normility_____________________________
    
  norDAT=(DAT-mean(DAT))./std(DAT);  % Z-Transformation (mean=!0 std)
                                     % %  Shifts distribution around 0 and
                                     % %  normalised to std
               
  N=size(norDAT,1);            % If N> 50 => kstest()
                             % %   If N<50 => swtest() Sharpiro Wilk Test                               
  for v=1:size(DAT,2)-1
       [H,p]=kstest(norDAT(:,v+1));  %Test for normaly distribution h=0 =nomaly distributed
       x=round(skewness(norDAT(:,v+1)),2);    % Tests for SKEWNESS. e.g x=0.05 => positiv => shift to left
       y=round(kurtosis(norDAT(:,v+1)),2);    % Tests for KURTOSIS e.g. 2.7 => positiv => closer together & higher als normaly dis
        
         figure(100+e)
         subplot(2,5,v)
         histogram(norDAT(:,v+1),10)
         hold on
         T1=fieldname(e);
         T2=footregion(v);
         T1=cat(2,T1,T2);
         title(T1,'interpreter','none')
        
        Tx2=cat(2,'skew=',num2str(x),' kur=',num2str(y));
       if H==0
           Tx1=cat(2,'norm. dist',' p = ',num2str(round(p,3))); % norm. dis. = normaly distributed
           xlabel({Tx1,Tx2},'FontSize',6)
       else 
           Tx1=cat(2,'NOT norm. dist',' p = ',num2str(round(p,3)));
           xlabel(string({Tx1,Tx2}),'COLOR','r','FontSize',6)
       end  
  end
  hold off
    

%%  Scatter_Plots and Correlation Coefficient

 data=DAT;
for k=1:10
    
    %% calculation of r^2 and regression
    
    X(:,1)=data(:,1);           % Formation to colum vectors
    Y(:,1)=data(:,k+1);
    
    %PEARSONS COEFFICIENT
    [r,P,RLO,RUP]=corrcoef(X,Y);  % Pearson's r Correlation between two variables is calculated
     r=round(r(1,2),2);          % r=0 => no correlation / r=1 or -1  => max positiv or negativ correlation
     P=round(P(1,2),3);         % p-value: propability to get this r values under the assumption that there is no correlation
     RLO=round(RLO(1,2),2);    % Lower boundary of 95% confidence intervall of r-values
     RUP=round(RUP(1,2),2);    % Upper boundary of 95% conf int. of r-values
                               % 95% of r-values lie between RLO & RUP
     r_sqrt=r^2;               % Coefficient of determination: Amount of variability in Y that can be explained by X                           
     
    %SPEARMAN COEFFICIENT
    [RHO,PVAL] = corr(X,Y,'Type','Spearman');
     
 %Linear Regression    
     MODELSPEC='linear';
     LM = fitlm(X,Y,MODELSPEC); % Calculates linear regression. Y predicted from X 
     
% [R,M,B]=regression(X(1:42)',Y(1:42)');
% start=min(data(1:42,1));
% ende=max(data(1:42,1));
% Xa=linspace(start,ende,size(data(1:42,1),1));
% g=M*Xa+B;
% 
% [r,m,b]=regression(X(43:end)',Y(43:end)');
% start=min(data(43:end,1));
% ende=max(data(43:end,1));
% Xa2=linspace(start,ende,size(data(43:end,1),1));
% G=m*Xa2+b;

[R,M,B]=regression(X',Y');
start=min(data(:,1));
ende=max(data(:,1));
Xa=linspace(start,ende,size(data(:,1),1));
g=M*Xa+B;

    %% Outlier



    %% PLotting Graph
   
        
figure
%plot(data(:,1),data(:,k+1),'ok','MarkerSize',5,'MarkerFaceColor','k')% Scatterplot/ MarkerFaceColor, fills dots
%if k+1==6
  %  scatter(data(:,1),data(:,k+1),25,'k')
%else
% if k+1 == 9
% scatter(data(:,1),data(:,k+1),25,'k','filled','o')
% hold on
% plot(Xa,g,'-k','LineWidth',1)
% elseif k+1 == 10
% scatter(data(:,1),data(:,k+1),25,'k','filled','d')
% hold on
% plot(Xa,g,'-.k','LineWidth',1)
% elseif k+1 == 11
% scatter(data(:,1),data(:,k+1),25,'k')
% hold on
% plot(Xa,g,'--k','LineWidth',1)
%else 
scatter(data(:,1),data(:,k+1),25,'k') %,'filled'
hold on   
plot(Xa,g,'--k','LineWidth',1)
%end
%end 
%scatter(data(1:42,1),data(1:42,k+1),25,'k','filled')
%hold on   
%plot(Xa,g,'--k','LineWidth',1) % Regression Line Plot
%scatter(data(43:end,1),data(43:end,k+1),25,'r','filled')
%plot(Xa2,G,'--r','LineWidth',1) % Regression Line Plot
Corr=cat(2,'r=',num2str(r),'*');
annotation('textbox',[0.2,0.2,0.1,0.1],'String',Corr,'EdgeColor','none')
%plot(LM)                                                    % Scatterplot from fitlm


% Title configuration 
TI=char(foot_pressure.S.Header_Region(2,k));   % Title creation
TI=TI(5:end);


if P < 0.05 % Makes Title red if p-value is significant!
    fab='r';
    if abs(r) >= 0.1 && abs(r) <0.3
        Effect='Small Effect';
        name4=cat(2,'r^2= ',num2str(r_sqrt));
    elseif abs(r) >= 0.3 && abs(r) <0.5
        Effect='Medium Effect';
        name4=cat(2,'r^2= ',num2str(r_sqrt));
    elseif abs(r) >=0.5
        Effect='Large Effect';
        name4=cat(2,'r^2= ',num2str(r_sqrt));
    end
else
    fab='k';
    Effect='';
    name4='';
end

name1=cat(2,'r=', num2str(r) );
name2=cat(2,'p=',num2str(P) );
name3=cat(2,'95% of r: ','[',num2str(RLO),', ',num2str(RUP),']');
NAME=cat(2,Effect,' ','(',name1,'; ',name2,'; ',name3,')');
name5=cat(2,'Spearman:',' r=',num2str(RHO),'; p=',num2str(PVAL));

title({string(fieldname(e)),TI,NAME,name5},'Color',fab,'interpreter','none') % kein latex interpreter unterschrich normal

% Axis Configuration
xlabel('Peak external moment [Nm/kg]')
labelsY=[{'Contact area [%]';'Force_{max} [%]';'Peak pressure [%]';'Max Mean Pressure [kPa/kg]'}] ;%[cm^2]
ylabel(labelsY(e))
xlim([0 0.45])
ylim([0 max(data(:,8))+max(data(:,8))/8]) % data(:,k+1) 
set(gca,'LineWidth', 1.5) %'XTick', 0:100:100, 'YTick', 0:30:180);
set(gcf,'color','w') % Sets the background figure color to w=white
%set(gca, 'FontSize', 11, 'LineWidth', 1.5, 'XTick', 0:100:100, 'YTick', 0:30:180, 'FontName', 'Arial');

end

end

%figure(1000)
%plot(X,Cont,'*k')
%figure(2000)
%plot(X,medial_Cont,'*k')



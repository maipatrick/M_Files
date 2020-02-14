clc
clear all 
close all


%______________Load the Data_______________________________________________
load('E:\Brooks_TZ\TOE_STRENGTH\Processed_MAT\torques_1_100_mean_P066.mat'); % Loads toe strength data
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
    Max_mean_Pressure.(currentsubject)= mean(foot_pressure.S.Max_mean_Pressure);
end 


data1=zeros(length,11); 
data2=zeros(length,11); 
data3=zeros(length,11); 

for j=1:length
   
   currentsubject=char(toe_strength(j,1));
    
   
   data1(j,1)= cell2mat(toe_strength(j,2));
   data1(j,2:end)= Contact_Areas.(currentsubject);
   data1(j,2:end)=data1(j,2:end)/sum(Contact_Areas.(currentsubject)); %
   %Normalises Contact_Area to total Contact Area
   
   data2(j,1)= cell2mat(toe_strength(j,2));
   data2(j,2:end)= Max_Force.(currentsubject);
   data2(j,2:end)=data2(j,2:end)./ sum(Max_Force.(currentsubject));% cell2mat(toe_strength(j,6));
   % Normalises Max_Force to total max force / body weight
   
   data3(j,1)= cell2mat(toe_strength(j,2));
   data3(j,2:end)= Peak_Pressure.(currentsubject);
  data3(j,2:end)=data3(j,2:end)./sum(Peak_Pressure.(currentsubject));%/cell2mat(toe_strength(j,6))%/sum(Contact_Areas.(currentsubject));
   % Normalises Peak_Pressure to body weight & Total Contact Area

end

%% Outlier Controll

%Method='mean';
%Method='grubbs';
Method='gesd';
TOE_strength= data1(:,1);
subject=toe_strength(:,1);
Pos_Out=find(isoutlier(TOE_strength,Method)==1);  %findes outlier in data
Outlier.TOE = subject(Pos_Out);

for z=2:11
   name=strsplit(footregion(z-1),' '); %Splited the names in footregion at the Leertaste ' '. 
    
   Pos_Out_CA= find(isoutlier(data1(:,z),Method)==1);
   Outlier.CA.(name(1))=subject(Pos_Out_CA); % name(1) is the part of the split string befor ' '
   
   Pos_Out_MF= find(isoutlier(data2(:,z),Method)==1);
   Outlier.MF.(name(1))=subject(Pos_Out_MF);
   
   Pos_Out_PP=find(isoutlier(data3(:,z),Method)==1);
   Outlier.PP.(name(1))=subject(Pos_Out_PP); 
   
end

  

save('E:\Brooks_TZ\STATISTICS\outlier.mat','Outlier')
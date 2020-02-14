clc
clear all
close all

%% Findes Data in folder
topfolder = ('E:\Brooks_TZ\TOE_STRENGTH\RAW');
subjects = dir (topfolder); % dir NAME lists the files in a folder
subjects = subjects(arrayfun(@(x) ~strcmp(x.name(1),'.'),subjects)); % remove ghoast files if exist

%% Loads Data out of folder

for i=1:length(subjects)
    %% Goes into each subject folder
    currentsubject=subjects(i).name
    
    subfolder=cat(2,topfolder,'\',currentsubject);
    cd(subfolder);
    trials=dir(subfolder);
    trials = trials(arrayfun(@(x) ~strcmp(x.name(1),'.'),trials)); % remove ghoast files if exist
    
    

    %% Loads each trial 
    offset=zeros(1,3);
    for j= 1: length(trials)
    currenttrial=trials(j).name;
    
    cd(subfolder);
    Data=load(currenttrial);
    data=Data.Rohdaten(:,1);
    
    %% Offset correction
    offset(j)=mean(data(1:100,1));  % Calculation of the offset
    data_corr=data-offset(j);           % Correction for offset
    
    
    %% Maximum Torque calculation

    
    Rohdaten = data_corr;
    GefDaten= Data.GefDaten;
    MaxDrehmoment_ALT=Data.MaxDrehmoment;
    MaxDrehmoment=max(data_corr);
    
    %Datum=Data.Datum;
    
    PI=Data.PI;
    %% Saves new Max Torques
    
    folder=cat(2,'E:\Brooks_TZ\TOE_STRENGTH\RAW offcorr','\',currentsubject);
    cd(folder);
    save(currenttrial,'Rohdaten','MaxDrehmoment','GefDaten','PI','MaxDrehmoment_ALT');%Datum
    
    %% ueberpruefung von der offset correcturs
    Test{1+3*(i-1)+(j-1),1}=currentsubject;
    Test{1+3*(i-1)+(j-1),2}=MaxDrehmoment;
    Test{1+3*(i-1)+(j-1),3}=MaxDrehmoment_ALT;
    Test{1+3*(i-1)+(j-1),4}=offset;
    
    
    %% Data Plotting
%      fab=['b','r','k'];
%      
%      figure(i)
%      plot(data_corr,fab(j))
%      hold on
%      plot(data,'g')
%      title({currentsubject,num2str(MaxDrehmoment),num2str( MaxDrehmoment_ALT)})
%      legend(num2str(offset(1)),num2str(offset(2)),num2str(offset(3)))
%      hold on
    end
    hold off

   
end
 
cd('E:\Brooks_TZ\TOE_STRENGTH');
save('E:\Brooks_TZ\TOE_STRENGTH\offsetcontrol.mat','Test');
clc
clear all
close all

% Load of mass(weight) data of patients for mass correction
cd('E:\Brooks_TZ\TOE_STRENGTH');
[Prob_Data,TXT]=xlsread('Probandendatenbank.xlsx');

%Old_Mass=Prob_Data(:,4);
%New_Mass=Prob_Data(:,6);


topfolder = ('E:\Brooks_TZ\TOE_STRENGTH\RAW offcorr')%
subjects = dir (topfolder); % dir NAME lists the files in a folder
subjects = subjects(arrayfun(@(x) ~strcmp(x.name(1),'.'),subjects)); % remove ghoast files if exist

womans=find(strncmp(TXT(:,4),'f',1))-1;  % findes the womans in the Dataset
mens=find(strncmp(TXT(:,4),'m',1))-1;    % findes the mens in the Dataset

j=1;
k=1;
while  j<=length(subjects)
    
    
 
    currentsubject=subjects(j).name
    loc=find(strncmp(TXT,currentsubject,4)); % Findes location (loc) of currentsubject in exel data
    gender=TXT(loc,4);
    loc=loc-1; % P001 in TXT is at the 2. row, and at the 1. row in Prob_Data. Therefore, always -1!!
    footsize= Prob_Data(loc,8);
    height=Prob_Data(loc,3);
    mass=Prob_Data(loc,6);
    BMI=mass/(height*height);
    
    
  % if  BMI <= 25 && BMI >= 18.5  && string(gender) == 'f' %&& footsize >= 250  %m= male; f=female  % Splits the group into male and female
       
       % (string(gender) == 'm' ||  string(gender) == 'f')
       
       
    Old_Mass_currentsubject=Prob_Data(loc,4); % Gets data out of Prob_Data
    New_Mass_currentsubject=Prob_Data(loc,6);
    Foot_Length_currentsubject=Prob_Data(loc,8)/1000; % Calculate to meter
    
    cd(cat(2,topfolder,'\',currentsubject))
    i=1;
        while i<=3;


            name=cat(2,'TunedZones_Standard_',currentsubject,'_0',num2str(i),'.mat');
            Data = load(name);

            %MAX_TORQUE{i,1}= currentsubject;
            MAX_TORQUE(i,1)=Data.MaxDrehmoment;
            Corrected_MAX_TORQUE(i,1)=MAX_TORQUE(i,1)*Old_Mass_currentsubject/New_Mass_currentsubject;%/Foot_Length_currentsubject;
            % ACHTUNG {} ist der Tipp
            i=i+1;

        end

    
    toe_strength{k,1}=currentsubject;
    
  % [max1,pos1]=max(Corrected_MAX_TORQUE);
   %Corrected_MAX_TORQUE(pos1,1)=0;
   %[max2,pos2]=max(Corrected_MAX_TORQUE);
  %  TOR=[max1,max2];
    
   % toe_strength{k,2}=round(mean(TOR),3);
   
    toe_strength{k,2}=round(max(Corrected_MAX_TORQUE),3);
    toe_strength{k,4}=round(max(MAX_TORQUE),3);
    toe_strength{k,5}=Old_Mass_currentsubject;
    toe_strength{k,6}=New_Mass_currentsubject;
    toe_strength{k,7}=footsize;
    toe_strength{k,8}=BMI;
    k=k+1;
 %end

j=j+1;
end

%%Saves data in folder cd( FILNAME)
cd('E:\Brooks_TZ\TOE_STRENGTH\Processed_MAT');

%xlswrite('torques',toe_strength);

save('torques.mat','toe_strength')





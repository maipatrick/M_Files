clc
clear all
close all

topfolder = ('E:\Brooks_TZ\FOOT_PRESSURE\RAW EMED Evaluation')%
subjects = dir (topfolder); % dir NAME lists the files in a folder
subjects = subjects(arrayfun(@(x) ~strcmp(x.name(1),'.'),subjects)); % remove ghoast files if exist

j=1;
while  j<=length(subjects)
   currentsubject=subjects(j).name
   filename=cat(2,topfolder,'\',currentsubject);
   
   cd('E:\Brooks_TZ\FOOT_PRESSURE');
   data=importfile1(filename,17,166);           % imports the .lst files (subjects)
   trial_names=importfile2(filename,20,22);      % imports the names of the trials.
   
   
   % Reads values out of data matrix
   k=1;
   for i=4:6:106
       Data(k).A=data(i:i+2,4:13);
       k=k+1;
   end 
   
   %Built struct
   Fieldnames=string({'Contact_Areas';'Max_Force';'Peak_Pressure';'Max_mean_Pressure';'Contact_Time_ms';...
                'Contact_Time_per';'Begin_of_Contact';'End_of_Contact';'Pressure_Time_Integrals';...
                'Force_Time_Integrals';'Instant_of_peak_Pressure_ms';'Instant_of_Peak_Pressure_per';...
                'Instant_of_max_Force_ms';'Instant_of_max_Force_per';'Pressure_Time_Integral_Threshold';...
                'Force_Time_Integral_Threshold';'Mean_Force';'Mean_Area'});
            
   S.Header_Region= {'M01','M02', 'M03', 'M04', 'M05', 'M06', 'M07', 'M08','M09', 'M10';...
                'prc_medial_hindfoot','prc_lateral_hindfoot','prc_medial_midfoot','prc_lateral_midfoot',...
                'prc_metatarsal_1','prc_metatarsal_2','prc_metatarsal_345','prc_bigtoe','prc_toe_2','prc_toes_345'};
            
   S.Header_Trial=trial_names;
   
    % Round prackes () allow dynamic struct buildung
 for h=1:18
     S.(Fieldnames(h))=Data(h).A; % Dynamic creation of a structur 
 end
 

  
   
   %Koordinaten vektor 1:18!
  % tempsub=subjects(j).name(1:4);
   %dynamische structs
   %S= struct(Fieldnames(1,:),Data(1).A),
   %H.(tempsub(1,:)) = struct(Fieldnames(1),Data(1).A,Fieldnames(2),Data(2).A)
   
%    ,'Peak_pressure',Data(3).A,'Max_mean_pressure',Data(4).A,...
%    'Contact_time_ms',Data(5).A,'Contact_time_per',Data(6).A,'Begin_of_contact',Data(7).A,'End_of_contact',Data(8).A,...
%    'Pressure_time_integrals',Data(9).A,'Force_time_integrals',Data(10).A,'Instant_of_peak_pressure_ms',Data(11).A,...
%    'Instant_of_peak_pressure_per',Data(12).A,'Instant_of_max_force_ms',Data(13).A,'Instant_of_max_force_per',Data(14).A,...
%    'Pressure_time_integral_Threshold',Data(15).A,'Force_time_integral_Threshold',Data(16).A,...
%    'Mean_force',Data(17).A,'Mean_area',Data(18).A);


%%Saves data in folder cd( FILNAME)
cd('E:\Brooks_TZ\FOOT_PRESSURE\Processed MAT');
save(currentsubject(1:4),'S')

j=j+1;
end


%xlswrite('foot_pressure',values);




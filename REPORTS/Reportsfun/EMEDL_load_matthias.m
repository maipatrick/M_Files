  % Reads values out of data matrix
   k=1;
   for p=4:6:106
       Data(k).A=EMEDLEFT(p:p+2,4:13);
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
            
%    S.Header_Trial=trial_names;
   
    % Round prackes () allow dynamic struct buildung
 for h=1:18
     SL.(Fieldnames(h))=Data(h).A; % Dynamic creation of a structur 
 end
 
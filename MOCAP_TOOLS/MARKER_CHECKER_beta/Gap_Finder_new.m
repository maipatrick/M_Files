clc
clear all
close all
f=1;
pc = computer;
os=strcmp('PCWIN64', pc);
if os == 1
    disp ('win');
    try
        cd ('C:\Users\User\Desktop\')
    end
    slash = '\';
else
    try
        cd('/Users/patrick/Desktop/')
    end
    slash =  '/';
end
f=1;
main = ('C:\Users\maipa\Desktop\HMP\MoTrack')%uigetdir;
cd (main)
%which marker to check

% marker={ 'forfoot_med_right', 'forfoot_lat_right', 'toe_right','calc_med_right','calc_lat_right','calc_back_right', 'mal_lat_right','mal_med_right',...
%     'epi_lat_right','epi_med_right','cluster_femur_right_1', 'cluster_femur_right_2', 'cluster_femur_right_3', 'cluster_femur_right_4', ...
%     'cluster_tibia_right_1','cluster_tibia_right_2','cluster_tibia_right_3','cluster_tibia_right_4',...
%     'SIPS_right','SIPS_left','SIAS_right','SIAS_left'};
marker= {'cluster_tibia_right_1', 'cluster_tibia_right_2', 'cluster_tibia_right_3','cluster_tibia_right_4',...
    'cluster_femur_right_1', 'cluster_femur_right_2', 'cluster_femur_right_3','cluster_femur_right_4',...
    'calc_back_right', 'calc_med_right', 'calc_lat_right'};

% sel=checkbox((1:length(marker)), marker)
folders = dir(main);
% Get a logical vector that tells which is a directory.
dirFlags = [folders.isdir];
% Extract only those that are directories.
con_folder = folders(dirFlags);
%remove hidden objects
con_folder = con_folder(arrayfun(@(x) ~strcmp(x.name(1),'.'),con_folder));
%loop to con folder
i=3;
while i<= 3%length (con_folder)
    temp_subject_folder = strcat (con_folder(i).folder, slash, con_folder(i).name);
    %list folder in temp con folder (subject folders)
    % Get a logical vector that tells which is a directory.
    cd(temp_subject_folder)
    temp_subject_folder= dir (temp_subject_folder);
    dirFlags = [temp_subject_folder.isdir];
    % Extract only those that are directories.
    sub_folder = temp_subject_folder(dirFlags);
    %remove hidden objects
    subject_folders = sub_folder(arrayfun(@(x) ~strcmp(x.name(1),'.'),sub_folder));
    ab=1;
    while ab<= length (subject_folders)
        temp_con_sub_folder =strcat(subject_folders(ab).folder, slash, subject_folders(ab).name);
        datatemp = dir(fullfile(temp_con_sub_folder, '*.c3d'));
        datatemp = datatemp(arrayfun(@(x) ~strcmp(x.name(1),'.'),datatemp));
        
        %load the c3d files
        zz=1;
        while zz<= length (datatemp)
            (strcat (datatemp(zz).folder, slash, datatemp(zz).name))
            acq = btkReadAcquisition(strcat (datatemp(zz).folder, slash, datatemp(zz).name));
            [markers, markersInfo, markersResidual] = btkGetMarkers(acq);
            %             allmarkernames = fieldnames (markers);
            %some additional checks
            %is med y always smaller as lat y
            try
            check1=(markers.calc_med_right(:,2))<=(markers.calc_lat_right(:,2));
            test1=  sum(check1);
            if test1>=1
                f=f+1;
                txt{f,1}=( ((strcat(datatemp(zz).name, 'med is more lat '))));
            else
            end
            check2=(markers.calc_med_right(:,1))<=(markers.calc_back_right(:,1));
            test2=  sum(check2);
            if test2>=1
                f=f+1;
                txt{f,1}=( ((strcat(datatemp(zz).name, 'med is more back '))));
            else
            end
            
            check3=(markers.calc_lat_right(:,1))<=(markers.calc_back_right(:,1));
            test3=  sum(check3);
            if test3>=1
                f=f+1;
                txt{f,1}=( ((strcat(datatemp(zz).name, 'lat is more back '))));
            else
            end
            
            catch
                 f=f+1;
                txt{f,1}=( ((strcat(datatemp(zz).name, 'is missing '))));
            end
            
            t=1;
            while t<= length (marker)
                
                marker{1, t};
                try
                    value = getfield(markers,marker{1, t});
                    
                catch
                    f=f+1;
                    txt{f,1}=( ((strcat(datatemp(zz).name,'_', marker{1, t},'_', 'missing'))));
                end
                
                value = value (:,1);
                value (value==0)=NaN;
                %                 [row, col] = find(value<xplus & value>xminus);
                
                
                TF = isnan(value);
                if sum(TF)>=1
                    f=f+1;
                    txt{f,1}=( ((strcat(datatemp(zz).name,'_', marker{1, t},'_', 'gap'))));
                else
                end
                apfel=2;
                %
                
                %                 f=f+1;
                %                 txt{f,1}=( (strcat (datatemp(zz).name,'_', marker{1, t},'_','missing')));
                
                %                 try
                %                     TF = find(value(row(1,1): row(end,1),:)==0);
                %                     [row, col] = find(TF ==1);
                %                     %             [row] = (value(row(1,1): row(end,1),:) == 0);
                %                 catch
                %                 end
                %                 try
                %                     if isempty (row) == 0
                %                         f=f+1;
                %                         txt{f,1}= (strcat (datatemp(zz).name,'_', marker{1, t},'_','GAP'));
                %                         cell{1,1} = (strcat (datatemp(zz).folder, slash, datatemp(zz).name));
                %                         cell{1,2} = row ;
                %                         cell{1,3} = marker{1, t};
                %                     else
                %                     end
                %                 catch
                %                     f=f+1;
                %                     txt{f,1}= (strcat (datatemp(zz).name,'_', marker{1, t},'_','GAP'));
                %                     cell{1,1} = (strcat (datatemp(zz).folder, slash, datatemp(zz).name));
                %                     %                     cell{1,2} = row ;
                %                     cell{1,3} = marker{1, t};
                %                 end
                t=t+1;
                % %                 clearvars value row col value
            end
            btkCloseAcquisition(acq);
            zz=zz+1;
            
        end
        ab=ab+1;
    end
    i=i+1;
end
cd (main)
% diary on



filePh = fopen('Marker_Error_Log.txt','w');
try
    fprintf(filePh,'%s\n',txt{:});
catch
    disp ('noting saved might be no gaps')
end
fclose(filePh);
try
    if length (txt)>1
        disp (strcat('Marker Error Log saved to', {' '},main, slash, 'Marker_Error_Log.txt'))
    end
catch
    disp ('noting saved might be no gaps')
end
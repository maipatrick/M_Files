clc
clear all
close all
clc
clear all
close all

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
main = ('C:\Users\maipa\Desktop\Alltogether\Cut\')%uigetdir;
cd (main)
f = 1;
%which marker to check
marker={ 'forfoot_med_right', 'forfoot_lat_right', 'toe_right','calc_med_right','calc_lat_right','calc_back_right', 'mal_lat_right','mal_med_right',...
    'epi_lat_right','epi_med_right','cluster_femur_right_1', 'cluster_femur_right_2', 'cluster_femur_right_3', 'cluster_femur_right_4', ...
    'cluster_tibia_right_1','cluster_tibia_right_2','cluster_tibia_right_3','cluster_tibia_right_4',...
    'SIPS_right','SIPS_left','SIAS_right','SIAS_left'};
% marker={'cluster_femur_right_1', 'cluster_femur_right_2', 'cluster_femur_right_3', 'cluster_femur_right_4', ...
%     'cluster_tibia_right_1','cluster_tibia_right_2','cluster_tibia_right_3','cluster_tibia_right_4', 'epi_lat_right','epi_med_right', 'mal_lat_right','mal_med_right' };
% sel=checkbox((1:length(marker)), marker)
folders = dir(main);
% Get a logical vector that tells which is a directory.
dirFlags = [folders.isdir];
% Extract only those that are directories.
con_folder = folders(dirFlags);
%remove hidden objects
con_folder = con_folder(arrayfun(@(x) ~strcmp(x.name(1),'.'),con_folder));
%loop to con folder

i=1;
while i<= length (con_folder)
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
        staticidentifier =  find(contains({datatemp.name},'Static'));
        tempstatic = datatemp(staticidentifier).name
        %load the c3d files
        zz=1;%length (datatemp);
        while zz<= length (datatemp)
            (strcat (datatemp(zz).folder, slash, datatemp(zz).name))
            acq = btkReadAcquisition(strcat (datatemp(zz).folder, slash, datatemp(zz).name));
            [markers, markersInfo, markersResidual] = btkGetMarkers(acq);
            
            
            
            t=1;
            while t<= length (marker)
                
                marker{1, t};
                try
                [ii,jj]=find(~  markers.(marker{1, t}));
                if  isempty(ii) ==1
                    
                else %here the marker will be reconstructed
                
                        gaplength = length (ii);
                        marker{1, t}
                        tempmarker = markers.(marker{1, t});
                        %replace 0 with nan
                        tempmarker(tempmarker==0) = NaN;
                        
                        y = fillgaps(tempmarker); % the filled marker
                        tempplace = strcat ('C:\Users\maipa\Desktop\', datatemp(zz).name);
                        %                markers.(marker{1, t})= y ;
                        allnames = fieldnames (markers);
                        tempmarkerarray =  find(contains(allnames,(marker{1, t})));
                        coordinatesfrommatrix = [tempmarkerarray*3-2, tempmarkerarray*3-1, tempmarkerarray*3];
                        v = btkGetMarkersValues(acq); % the matrix of the markers
                        v(:,[coordinatesfrommatrix]) =y;
                        [points, pointsInfo] = btkSetPoint(acq, tempmarkerarray, y)
                        
                        [points, pointsInfo] = btkSetPoint(acq, (marker{1, t}), y)
                        r = btkGetPointsResiduals(acq)
                        yy = r(:,tempmarkerarray);
                        yy(yy == -1) = NaN;
                        resfilled = fillgaps(yy)
                        btkSetPointResiduals(acq, (marker{1, t}), resfilled)
                        btkSetMarkersValues(acq,v);
                        btkWriteAcquisition(acq, tempplace)
                        cccc= 2;
                    end
                end
                
                try
                    accX =  abs (diff(markers.(marker{1, t})(:,1), 2));
                    accY= abs(diff(markers.(marker{1, t})(:,2), 2));
                    accZ=abs(diff(markers.(marker{1, t})(:,3), 2));
                    
                    
                    threshold = 200;
                    if ( sum((accX>threshold) ) || sum((accY>threshold) ) || sum((accZ>threshold) )  >=1)
                        disp ( strcat ('X',(marker{1, t}), 'springt'))
                        
                        f =f+1;
                        tab{f,:}= ( strcat ((marker{1, t}), 'springt', datatemp(zz).name))
                        %                  elseif ( sum((accY>threshold))>=1)
                        %                      disp ( strcat ('Y',(marker{1, t}), 'springt'))
                        %                       tab{f,:}= ( strcat ('X',(marker{1, t}), 'springt', datatemp(zz).name))
                        %                       f =f+1;
                        %                  elseif ( sum((accZ>threshold))>=1)
                        %                      disp ( strcat ('Z',(marker{1, t}), 'springt'))
                        %                       tab{f,:}= ( strcat ('X',(marker{1, t}), 'springt', datatemp(zz).name))
                        %                       f =f+1;
                    else
                    end
                end
                clearvars accX accY accZ
                t=t+1;
            end
            btkCloseAcquisition(acq);
            zz=zz+1;
            clearvars value row col value
        end
        ab=ab+1;
    end
    i=i+1;
end

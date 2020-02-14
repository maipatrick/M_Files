clc
clear all
close all

%slect the motrack topfolder structure
topfolder = ('C:\Users\maipa\Desktop\Alltogether\Cut')
cd (topfolder)
con = dir(fullfile(topfolder));

con = con(arrayfun(@(x) ~strcmp(x.name(1),'.'),con));


coni=1;
while coni<= length (con)
    tempconfolder = strcat(con(coni).folder, '\', con(coni).name)
    datatemp = dir(fullfile(tempconfolder, '*.mat'));
    i = 1;
    while i <=length (datatemp)
        datatemp(i).name
        
        load ( strcat( tempconfolder,'\',datatemp(i).name));
        trails = fieldnames (CONTACT);
        f=1;
        while f<= length(trails)
            trails{f, 1};
            
            %calculations goes in here
            feqratio =  OPTIONS.freqGRF/OPTIONS.FreqKinematics;

            start =  (round(CONTACT.(trails{f, 1})(1,1)/feqratio));
            ende = (round(CONTACT.(trails{f, 1})(1,end)/feqratio));
            contactmarker = [start:1:ende];
            
            %Knee
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_KNEE.X(:,f) = normalize(JOINT.(trails{f, 1}).Right_Knee.AngV(1,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_KNEE.Y(:,f) = normalize(JOINT.(trails{f, 1}).Right_Knee.AngV(2,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_KNEE.Z(:,f) = normalize(JOINT.(trails{f, 1}).Right_Knee.AngV(3,contactmarker)./pi*180,0.5);
            %Hip
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_HIP.X(:,f) = normalize(JOINT.(trails{f, 1}).Right_Hip.AngV(1,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_HIP.Y(:,f) = normalize(JOINT.(trails{f, 1}).Right_Hip.AngV(2,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_HIP.Z(:,f) = normalize(JOINT.(trails{f, 1}).Right_Hip.AngV(3,contactmarker)./pi*180,0.5);
            %Ankle
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_ANKLE.X(:,f) = normalize(JOINT.(trails{f, 1}).Right_Ankle.AngV(1,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_ANKLE.Y(:,f) = normalize(JOINT.(trails{f, 1}).Right_Ankle.AngV(2,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_ANKLE.Z(:,f) = normalize(JOINT.(trails{f, 1}).Right_Ankle.AngV(3,contactmarker)./pi*180,0.5);
            %MPJ
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_MPJ.X(:,f) = normalize(JOINT.(trails{f, 1}).Right_MPJ.AngV(1,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_MPJ.Y(:,f) = normalize(JOINT.(trails{f, 1}).Right_MPJ.AngV(2,contactmarker)./pi*180,0.5);
            NORMAL.R.ANGULAR_VELOCITY.RIGHT_MPJ.Z(:,f) = normalize(JOINT.(trails{f, 1}).Right_MPJ.AngV(3,contactmarker)./pi*180,0.5);
            
            
            
            f = f+1;
        end
        tempfilename = strcat(datatemp(1).folder, '\',datatemp(i).name);
        save(tempfilename,'NORMAL','-append')
        i = i+1 ;
    end
    coni=coni+1;
end

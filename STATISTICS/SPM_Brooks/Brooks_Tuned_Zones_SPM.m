clc
clear all
close all
warning 'off'
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
  plotall=1;
reprocess= 0;
if reprocess ==1
    [foldselc] = ('C:\Users\maipa\Desktop\Alltogether\Cut')%uigetdir
    foldselc = dir (foldselc);
    dirFlags = [foldselc.isdir];
    foldselc = foldselc(dirFlags);
    %remove goahsts
    foldselc = foldselc(arrayfun(@(x) ~strcmp(x.name(1),'.'),foldselc));
    noconditions = length(foldselc);
    i=1;
    while i<= noconditions
        currentCondition = (foldselc(i).name)
        tempconfolder = dir(strcat(foldselc(i).folder,slash, currentCondition));
        tempfiles = tempconfolder(arrayfun(@(x) ~strcmp(x.name(1),'.'),tempconfolder));
        %     tempfolder = strcat((foldselc{i, 1}), slash ,tempfolder(1).name);
        cd (strcat(foldselc(i).folder,slash, currentCondition));
        
        filestemp = dir(fullfile(strcat(foldselc(i).folder,slash, currentCondition), '*.mat'));
        
        %%%loop in a conndition throuh participants
        a=1;
        while a<= length (filestemp)
            (filestemp(a).name);
            datatemp = load (filestemp(a).name);
            
            
            data.ANGLES.KNEE.X = (datatemp.NORMAL.R.ANGLES.RIGHT_KNEE.X);
            data.ANGLES.KNEE.Y = (datatemp.NORMAL.R.ANGLES.RIGHT_KNEE.Y);
            data.ANGLES.KNEE.Z = (datatemp.NORMAL.R.ANGLES.RIGHT_KNEE.Z);
            
            data.ANGLES.ANKLE.X = (datatemp.NORMAL.R.ANGLES.RIGHT_ANKLE.X);
            data.ANGLES.ANKLE.Y = (datatemp.NORMAL.R.ANGLES.RIGHT_ANKLE.Y);
            data.ANGLES.ANKLE.Z = (datatemp.NORMAL.R.ANGLES.RIGHT_ANKLE.Z);
            
            data.ANGLES.HIP.X = (datatemp.NORMAL.R.ANGLES.RIGHT_HIP.X);
            data.ANGLES.HIP.Y = (datatemp.NORMAL.R.ANGLES.RIGHT_HIP.Y);
            data.ANGLES.HIP.Z = (datatemp.NORMAL.R.ANGLES.RIGHT_HIP.Z);
            
            %momets
            data.MOMENTS.KNEE.X = (datatemp.NORMAL.R.MOMENTS.RIGHT_KNEE.X);
            data.MOMENTS.KNEE.Y = (datatemp.NORMAL.R.MOMENTS.RIGHT_KNEE.Y);
            data.MOMENTS.KNEE.Z = (datatemp.NORMAL.R.MOMENTS.RIGHT_KNEE.Z);
            
            data.MOMENTS.ANKLE.X = (datatemp.NORMAL.R.MOMENTS.RIGHT_ANKLE.X);
            data.MOMENTS.ANKLE.Y = (datatemp.NORMAL.R.MOMENTS.RIGHT_ANKLE.Y);
            data.MOMENTS.ANKLE.Z = (datatemp.NORMAL.R.MOMENTS.RIGHT_ANKLE.Z);
            
            data.MOMENTS.HIP.X = (datatemp.NORMAL.R.MOMENTS.RIGHT_HIP.X);
            data.MOMENTS.HIP.Y = (datatemp.NORMAL.R.MOMENTS.RIGHT_HIP.Y);
            data.MOMENTS.HIP.Z = (datatemp.NORMAL.R.MOMENTS.RIGHT_HIP.Z);
            
            %angular velo
%             datatemp.NORMAL.R.ANGULAR_VELOCITY
            data.ANGULAR_VELOCITY.KNEE.X = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_KNEE.X);
            data.ANGULAR_VELOCITY.KNEE.Y = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_KNEE.Y);
            data.ANGULAR_VELOCITY.KNEE.Z = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_KNEE.Z);
            
            data.ANGULAR_VELOCITY.ANKLE.X = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_ANKLE.X);
            data.ANGULAR_VELOCITY.ANKLE.Y = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_ANKLE.Y);
            data.ANGULAR_VELOCITY.ANKLE.Z = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_ANKLE.Z);
            
            data.ANGULAR_VELOCITY.HIP.X = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_HIP.X);
            data.ANGULAR_VELOCITY.HIP.Y = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_HIP.Y);
            data.ANGULAR_VELOCITY.HIP.Z = (datatemp.NORMAL.R.ANGULAR_VELOCITY.RIGHT_HIP.Z);
            
            
            
            % grf
            dataGRF.X =datatemp.NORMAL.R.GRF.DATA.X;
            dataGRF.Y =datatemp.NORMAL.R.GRF.DATA.Y;
            dataGRF.Z =datatemp.NORMAL.R.GRF.DATA.Z;
            
            %         data = (datatemp.NORMAL.R.(type).(joint).(plane));
            
            
            data.MOMENTS.KNEE.X( :, all(~data.MOMENTS.KNEE.X,1) ) = []; % romoves zeros if exist
            data.MOMENTS.KNEE.Y( :, all(~data.MOMENTS.KNEE.Y,1) ) = []; % romoves zeros if exist
            data.MOMENTS.KNEE.Z( :, all(~data.MOMENTS.KNEE.Z,1) ) = []; % romoves zeros if exist
            
            data.MOMENTS.ANKLE.X( :, all(~data.MOMENTS.ANKLE.X,1) ) = []; % romoves zeros if exist
            data.MOMENTS.ANKLE.Y( :, all(~data.MOMENTS.ANKLE.Y,1) ) = []; % romoves zeros if exist
            data.MOMENTS.ANKLE.Z( :, all(~data.MOMENTS.ANKLE.Z,1) ) = []; % romoves zeros if exist
            
            data.MOMENTS.HIP.X( :, all(~data.MOMENTS.HIP.X,1) ) = []; % romoves zeros if exist
            data.MOMENTS.HIP.Y( :, all(~data.MOMENTS.HIP.Y,1) ) = []; % romoves zeros if exist
            data.MOMENTS.HIP.Z( :, all(~data.MOMENTS.HIP.Z,1) ) = []; % romoves zeros if exist
            
            data.ANGLES.KNEE.X( :, all(~data.ANGLES.KNEE.X,1) ) = []; % romoves zeros if exist
            data.ANGLES.KNEE.Y( :, all(~data.ANGLES.KNEE.Y,1) ) = []; % romoves zeros if exist
            data.ANGLES.KNEE.Z( :, all(~data.ANGLES.KNEE.Z,1) ) = []; % romoves zeros if exist
            
            data.ANGLES.ANKLE.X( :, all(~data.ANGLES.ANKLE.X,1) ) = []; % romoves zeros if exist
            data.ANGLES.ANKLE.Y( :, all(~data.ANGLES.ANKLE.Y,1) ) = []; % romoves zeros if exist
            data.ANGLES.ANKLE.Z( :, all(~data.ANGLES.ANKLE.Z,1) ) = []; % romoves zeros if exist
            
            data.ANGLES.HIP.X( :, all(~data.ANGLES.HIP.X,1) ) = []; % romoves zeros if exist
            data.ANGLES.HIP.Y( :, all(~data.ANGLES.HIP.Y,1) ) = []; % romoves zeros if exist
            data.ANGLES.HIP.Z( :, all(~data.ANGLES.HIP.Z,1) ) = []; % romoves zeros if exist
            
            %ang velo
            data.ANGULAR_VELOCITY.KNEE.X( :, all(~data.ANGULAR_VELOCITY.KNEE.X,1) ) = []; % romoves zeros if exist
            data.ANGULAR_VELOCITY.KNEE.Y( :, all(~data.ANGULAR_VELOCITY.KNEE.Y,1) ) = []; % romoves zeros if exist
            data.ANGULAR_VELOCITY.KNEE.Z( :, all(~data.ANGULAR_VELOCITY.KNEE.Z,1) ) = []; % romoves zeros if exist
            
            data.ANGULAR_VELOCITY.ANKLE.X( :, all(~data.ANGULAR_VELOCITY.ANKLE.X,1) ) = []; % romoves zeros if exist
            data.ANGULAR_VELOCITY.ANKLE.Y( :, all(~data.ANGULAR_VELOCITY.ANKLE.Y,1) ) = []; % romoves zeros if exist
            data.ANGULAR_VELOCITY.ANKLE.Z( :, all(~data.ANGULAR_VELOCITY.ANKLE.Z,1) ) = []; % romoves zeros if exist
            
            data.ANGULAR_VELOCITY.HIP.X( :, all(~data.ANGULAR_VELOCITY.HIP.X,1) ) = []; % romoves zeros if exist
            data.ANGULAR_VELOCITY.HIP.Y( :, all(~data.ANGULAR_VELOCITY.HIP.Y,1) ) = []; % romoves zeros if exist
            data.ANGULAR_VELOCITY.HIP.Z( :, all(~data.ANGULAR_VELOCITY.HIP.Z,1) ) = []; % romoves zeros if exist
            
            
            
            
            %ankle
            
            ProbMeanCurves.(currentCondition).ANGLES.KNEE.X(:,a)=(mean(  data.ANGLES.KNEE.X,2));
            ProbMeanCurves.(currentCondition).ANGLES.KNEE.Y(:,a)=(mean(  data.ANGLES.KNEE.Y,2));
            ProbMeanCurves.(currentCondition).ANGLES.KNEE.Z(:,a)=(mean(  data.ANGLES.KNEE.Z,2));
            
            ProbMeanCurves.(currentCondition).ANGLES.ANKLE.X(:,a)=(mean(  data.ANGLES.ANKLE.X,2));
            ProbMeanCurves.(currentCondition).ANGLES.ANKLE.Y(:,a)=(mean(  data.ANGLES.ANKLE.Y,2));
            ProbMeanCurves.(currentCondition).ANGLES.ANKLE.Z(:,a)=(mean(  data.ANGLES.ANKLE.Z,2));
            
            ProbMeanCurves.(currentCondition).ANGLES.HIP.X(:,a)=(mean(  data.ANGLES.HIP.X,2));
            ProbMeanCurves.(currentCondition).ANGLES.HIP.Y(:,a)=(mean(  data.ANGLES.HIP.Y,2));
            ProbMeanCurves.(currentCondition).ANGLES.HIP.Z(:,a)=(mean(  data.ANGLES.HIP.Z,2));
            
            %moents
            
            ProbMeanCurves.(currentCondition).MOMENTS.KNEE.X(:,a)=(mean(  data.MOMENTS.KNEE.X,2));
            ProbMeanCurves.(currentCondition).MOMENTS.KNEE.Y(:,a)=(mean(  data.MOMENTS.KNEE.Y,2));
            ProbMeanCurves.(currentCondition).MOMENTS.KNEE.Z(:,a)=(mean(  data.MOMENTS.KNEE.Z,2));
            
            ProbMeanCurves.(currentCondition).MOMENTS.ANKLE.X(:,a)=(mean(  data.MOMENTS.ANKLE.X,2));
            ProbMeanCurves.(currentCondition).MOMENTS.ANKLE.Y(:,a)=(mean(  data.MOMENTS.ANKLE.Y,2));
            ProbMeanCurves.(currentCondition).MOMENTS.ANKLE.Z(:,a)=(mean(  data.MOMENTS.ANKLE.Z,2));
            
            ProbMeanCurves.(currentCondition).MOMENTS.HIP.X(:,a)=(mean(  data.MOMENTS.HIP.X,2));
            ProbMeanCurves.(currentCondition).MOMENTS.HIP.Y(:,a)=(mean(  data.MOMENTS.HIP.Y,2));
            ProbMeanCurves.(currentCondition).MOMENTS.HIP.Z(:,a)=(mean(  data.MOMENTS.HIP.Z,2));
            
            %angeo vel
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.KNEE.X(:,a)=(mean(  data.ANGULAR_VELOCITY.KNEE.X,2));
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.KNEE.Y(:,a)=(mean(  data.ANGULAR_VELOCITY.KNEE.Y,2));
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.KNEE.Z(:,a)=(mean(  data.ANGULAR_VELOCITY.KNEE.Z,2));
            
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.ANKLE.X(:,a)=(mean(  data.ANGULAR_VELOCITY.ANKLE.X,2));
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.ANKLE.Y(:,a)=(mean(  data.ANGULAR_VELOCITY.ANKLE.Y,2));
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.ANKLE.Z(:,a)=(mean(  data.ANGULAR_VELOCITY.ANKLE.Z,2));
            
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.HIP.X(:,a)=(mean(  data.ANGULAR_VELOCITY.HIP.X,2));
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.HIP.Y(:,a)=(mean(  data.ANGULAR_VELOCITY.HIP.Y,2));
            ProbMeanCurves.(currentCondition).ANGULAR_VELOCITY.HIP.Z(:,a)=(mean(  data.ANGULAR_VELOCITY.HIP.Z,2));
            
            %grf
            ProbMeanCurvesGRF.(currentCondition).X(:,a)=(mean(  dataGRF.X,2));
            ProbMeanCurvesGRF.(currentCondition).Y(:,a)=(mean(  dataGRF.Y,2));
            ProbMeanCurvesGRF.(currentCondition).Z(:,a)=(mean(  dataGRF.Z,2));
            clearvars datatemp data
            a=a+1;
        end
        
        i=i+1;
    end
    try
    cd ('C:\Users\maipa\Desktop\Alltogether\')
    end
%     try
%        cd('E:\Brooks_Tuned_Zones\') 
%     end
    save('ProbMeanCurves.mat','ProbMeanCurves')
    save('ProbMeanCurvesGRF.mat','ProbMeanCurvesGRF')
else
    try
        load('C:\Users\maipa\Desktop\Alltogether\ProbMeanCurves.mat')
        load('C:\Users\maipa\Desktop\Alltogether\ProbMeanCurvesGRF.mat')
    end
%     try
%         load('E:\Brooks_Tuned_Zones\ProbMeanCurvesGRF.mat')
%         load('E:\Brooks_Tuned_Zones\ProbMeanCurves.mat')
%     end
    
end

noSubjects = length (ProbMeanCurves.Running_Shoe_A.ANGLES.KNEE.X(1,:))
Subtemp = linspace (1, noSubjects,noSubjects);

clearvars temp
SUBJ = [Subtemp, Subtemp, Subtemp, Subtemp, Subtemp, Subtemp, Subtemp]'; % Subject Identifier
SUBJ = int64(SUBJ);
A0=  0.* ones(length(Subtemp),1); % condition 1 Identifier
A1=  1.* ones(length(Subtemp),1); % condition 2 Identifier
A2=  2.* ones(length(Subtemp),1); % condition 3 Identifier
A3=  3.* ones(length(Subtemp),1); % condition 4 Identifier
A4=  4.* ones(length(Subtemp),1); % condition 5 Identifier
A5=  5.* ones(length(Subtemp),1); % condition 6 Identifier
A6=  6.* ones(length(Subtemp),1); % condition 7 Identifier
A =[A0; A1; A2; A3; A4; A5; A6]; % Condition Identifier
A = int64(A);

% matrice reorganize
boni=0; % 1 = yes 0 = no Post-Hoc
clearvars test

conditions = fieldnames (ProbMeanCurves);
% (conditions{lauf, 1})

joints = fieldnames (ProbMeanCurves.Running_Shoe_A.MOMENTS);
% (joints{lauf, 1})

planes = fieldnames (ProbMeanCurves.Running_Shoe_A.MOMENTS.KNEE);
% (planes{lauf, 1})
type = fieldnames (ProbMeanCurves.Running_Shoe_A );
t=1;
while t<= length (type)
    (type{t, 1})
    j=1;
    while j<= length (joints)
        (joints{j, 1})
        p=1;
        while p<= length (planes)
            (planes{p, 1})
          
            MATRIX.(type{t, 1}).(joints{j, 1}).(planes{p, 1})  = [ ProbMeanCurves.Running_Shoe_A.(type{t, 1}).(joints{j, 1}).(planes{p, 1}) ,  ProbMeanCurves.Running_Shoe_B.(type{t, 1}).(joints{j, 1}).(planes{p, 1}),...
                ProbMeanCurves.Running_Shoe_C.(type{t, 1}).(joints{j, 1}).(planes{p, 1}),  ProbMeanCurves.Running_Shoe_D.(type{t, 1}).(joints{j, 1}).(planes{p, 1}),...
                ProbMeanCurves.Running_Shoe_E.(type{t, 1}).(joints{j, 1}).(planes{p, 1}),  ProbMeanCurves.Running_Shoe_F.(type{t, 1}).(joints{j, 1}).(planes{p, 1}),...
                ProbMeanCurves.Running_Shoe_G.(type{t, 1}).(joints{j, 1}).(planes{p, 1})]';
            [spmi, RESPONSE.(type{t, 1}).(joints{j, 1}).(planes{p, 1})] = PerformSPM(SUBJ, A, MATRIX.(type{t, 1}).(joints{j, 1}).(planes{p, 1}) , boni,   (type{t, 1}),  (planes{p, 1}),(joints{j, 1}) ,conditions,plotall);
            p=p+1;
        end
        j=j+1;
    end
    
    t=t+1;
end
% save('RESPONSEmat.mat','RESPONSE')
%%
noSubjects = length (ProbMeanCurvesGRF.Running_Shoe_A.X(1,:))
Subtemp = linspace (1, noSubjects,noSubjects);

SUBJ = [Subtemp, Subtemp, Subtemp, Subtemp, Subtemp, Subtemp, Subtemp]'; % Subject Identifier
SUBJ = int64(SUBJ);
A0=  0.* ones(length(Subtemp),1); % condition 1 Identifier
A1=  1.* ones(length(Subtemp),1); % condition 2 Identifier
A2=  2.* ones(length(Subtemp),1); % condition 3 Identifier
A3=  3.* ones(length(Subtemp),1); % condition 4 Identifier
A4=  4.* ones(length(Subtemp),1); % condition 5 Identifier
A5=  5.* ones(length(Subtemp),1); % condition 6 Identifier
A6=  6.* ones(length(Subtemp),1); % condition 7 Identifier
A =[A0; A1; A2; A3; A4; A5; A6]; % Condition Identifier
A = int64(A);
boni = 0;
conditions = fieldnames (ProbMeanCurvesGRF);
planes = fieldnames (ProbMeanCurvesGRF.Running_Shoe_A);

p=1;
while p<= length (planes)
    (planes{p, 1});
    MATRIXGRF.(planes{p, 1})  = [ ProbMeanCurvesGRF.Running_Shoe_A.(planes{p, 1}) ,  ProbMeanCurvesGRF.Running_Shoe_B.(planes{p, 1}),...
        ProbMeanCurvesGRF.Running_Shoe_C.(planes{p, 1}),  ProbMeanCurvesGRF.Running_Shoe_D.(planes{p, 1}),...
        ProbMeanCurvesGRF.Running_Shoe_E.(planes{p, 1}),  ProbMeanCurvesGRF.Running_Shoe_F.(planes{p, 1}),...
        ProbMeanCurvesGRF.Running_Shoe_G.(planes{p, 1})]';
    [spmi] = PerformSPMGRF(SUBJ, A, MATRIXGRF.(planes{p, 1}) , boni ,conditions,(planes{p, 1}), p, plotall);
    p=p+1;
end




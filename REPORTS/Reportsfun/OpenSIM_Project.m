

clc
clear all
%load C3ds with opensim    %working

c3d = osimC3D('C:\Users\maipa\Desktop\P036\P036_Running_Shoe_A_1.c3d',1); 

  % Get some stats...
    % Get the number of marker trajectories
    data.nTrajectories = c3d.getNumTrajectories();
    % Get the marker data rate
    data.rMarkers = c3d.getRate_marker();
    % Get the number of forces 
    data.nForces = c3d.getNumForces();
    % Get the force data rate
    data.rForces = c3d.getRate_force();
    markerTable = c3d.getTable_markers();
    forceTable = c3d.getTable_forces();
    % Get as Matlab Structures
    [data.markerStruct, data.forceStruct] = c3d.getAsStructs();
    
    
    %load a mot file
    % Define the path to the file

% Use the standard TimeSeriesTable to read the data file.
import org.opensim.modeling.* %needed to load the libary
%load a mot file
opensimTable = TimeSeriesTable('/Users/patrick/Documents/OpenSim/4.0_new/Models/Gait2354_Simbody/subject01_walk1_ik.mot');
matlabStruct_grfData = osimTableToStruct(opensimTable);

%%
%load trc
import org.opensim.modeling.*

%%

%%load sto file results inverse dynamics
 out = load_sto_file(filename)
 %%
 clc
%btk read now working finally on mac
acq = btkReadAcquisition('/Users/patrick/Desktop/OS/P036/P036_Running_Shoe_A_2.c3d');
grw = btkGetGroundReactionWrenches(acq, 0);
%Forceplate 2
forcedata = (grw(2).F(:,end));
%now detect stance phase and crop the data 
%%
%crop a acquisition
 btkCropAcquisition(acq, 20, 400)
filename= ('test_crope.c3d')
 btkWriteAcquisition(acq, filename)


clc
clear all
close all
 %convert files
%load C3ds with opensim    %working
static= 'P028_Running_Shoe_A_1_cropped'
% cd ('C:\Users\maipa\Desktop\P028 - Kopie\')
c3ddatatemP =(strcat('C:\Users\maipa\Desktop\P028 - Kopie\', static, '.c3d'));
c3d = osimC3D(c3ddatatemP,1); 

% Get some stats...
% Get the number of marker trajectories
nTrajectories = c3d.getNumTrajectories();
% Get the marker data rate
rMakers = c3d.getRate_marker();
% Get the number of forces
nForces = c3d.getNumForces();
% Get the force data rate
rForces = c3d.getRate_force();
 
% Get Start and end time
t0 = c3d.getStartTime();
tn = c3d.getEndTime();
 
%Rotate the data
c3d.rotateData('x',-90)

% Get the c3d in different forms
% Get OpenSim tables
markerTable = c3d.getTable_markers();
forceTable = c3d.getTable_forces();
% Get as Matlab Structures
% [markerStruct forceStruct] = c3d.getAsStructs();
 
% % % Convert COP (mm to m) and Moments (Nmm to Nm)
% 
%  c3d.convertMillimeters2Meters();

 

% Write the marker and force data to file
 
% Write marker data to trc file.
% c3d.writeTRC()                       Write to dir of input c3d.
% c3d.writeTRC('Walking.trc')          Write to dir of input c3d with defined file name.
 c3d.writeTRC(strcat('C:/Users/maipa/Desktop/P028 - Kopie/',static,'.trc')) % Write to defined path input path.
%c3d.writeTRC('test_data_markers.trc');
 
% Write force data to mot file.
% c3d.writeMOT()                       Write to dir of input c3d.
% c3d.writeMOT('Walking.mot')          Write to dir of input c3d with defined file name.
 c3d.writeMOT(strcat('C:/Users/maipa/Desktop/P028 - Kopie/',static ,'.mot'))  %Write to defined path input path.

 
%%
clc
import org.opensim.modeling.*
osim_model='gait2354_simbody.osim';
visualizer_path = 'C:\OpenSim 4.0\OpenSim 4.0\Geometry\';
ModelVisualizer.addDirToGeometrySearchPaths(visualizer_path);


%%
%    clc
%    clear all
%    close all
%     
%     %load a mot file
%     % Define the path to the file
% 
% % Use the standard TimeSeriesTable to read the data file.
% import org.opensim.modeling.* %needed to load the libary
% %load a mot file
% tempmot = ( 'C:\Users\maipa\Desktop\P028- Kopie\Run.mot');
% opensimTable = TimeSeriesTable(tempmot);
% matlabStruct_grfData = osimTableToStruct(opensimTable);
% 


 
% % % % %%load sto file results inverse dynamics
% % %  out = load_sto_file(filename)

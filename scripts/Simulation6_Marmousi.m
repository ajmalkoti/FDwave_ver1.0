% Please see the instructions for each section in comments

%% This part will setup all the FDwave program
clc; close all; clear all;
code_path='..\FDwave';                                                                    % Path of FD code files 
addpath(code_path);                                                                        % Add the code folder to the current command space
wf_path=pwd;                                                                                   % where you want to store your data. PWD means the current directory
FDwave_initialize('CP',code_path,'WFP',wf_path,'verbose','n');     % do necessary steps for initialization

%% Preprocessing
% create/ modify model
% Note: Make sure that the marmousi file in the input folder are unzipped/extracted to "IP folder". Then only proceed. 
FDwave_model_read_segy('WFP',wf_path,'M_NAME','marmousi','WAVE_TYPE','Elastic',...
    'CROP_MODEL','y','X1',7000,'Z1',700,'X2',12000,'Z2',4200,...
    'INTERPOLATE','y','DX_NEW',4,'DZ_NEW',4,'PlotON','y')

%source
FDwave_source_ricker('WFP',wf_path,'T',2,'DT',.00025,'F0',20,'T0',0.07,'PlotON','y');

%analyse
FDwave_analyse_elastic('WFP',wf_path)

%derived model
FDwave_model_derived_elastic_g1('WFP',wf_path)

% Boundary Conditions
FDwave_bc_select('WFP',wf_path,'BCTYPE','topFS','NAB',50,'PlotON','y') ;

% source and reciever geometry
FDwave_geometry_src_single('WFP',wf_path,'SZ',50,'PlotON','n');                 %figure(gcf); axis image
FDwave_geometry_rec_st_line_surf('WFP',wf_path,'DEPTH',1,'PlotON','n');            %figure(gcf); axis image

FDwave_geometry_plot('FIGNO',3, 'HOP_S',5, 'HOP_R',4)

%% Simulation
% Do the time stepping calculations of wavefield
FDwave_calculation_elastic_g1('dN_SS',1,'dN_W',100,'dN_P',50,'PlotON','n');


%% Post processing
str='SS_1.mat';                                                              % this should be changed by user if required
% plotting the seismogram in image form
FDwave_calculation_plot('wfp',wf_path,'SSFileName',str,'scale',5)

% plotting the seismogram in wiggle traces form
FDwave_calculation_wiggle_plot('wfp',wf_path,'SSFileName',str,'scale',5)

% animating the wave propagation
FDwave_calculation_animate('WFP',wf_path,'SSFileName','SS_1.mat', 'WaveFieldFileName','wavefield_1')

%% Terminate FDwave program
FDwave_deinitialize(code_path)


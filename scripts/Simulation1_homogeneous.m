clc; close all; clear all;

%% This part will setup all the FDwave programcode_path='F..\FDwave';   % Path of FD code files
clc; close all; clear all;
code_path='../FDwave';                                                                    % Path of FD code files 
addpath(code_path);                                                                        % Add the code folder to the current command space
wf_path=pwd;                                                                                   % where you want to store your data. PWD means the current directory
FDwave_initialize('CP',code_path,'WFP',wf_path,'verbose','n');     % do necessary steps for initialization

%% Preprocessing
% create/ modify model

T=5000;     vp=2000;        vs=0;        rho=1700;
FDwave_model_n_layers('WFP',wf_path,'WAVE_TYPE','Elastic','DX',10,'DZ',10,'THICKNESS',T,... 
         'HV_RATIO',1,'Vp',vp,'VS',vs,'RHO',rho,'PlotON','y','verbose','n')

%source
FDwave_source_ricker('WFP',wf_path,'T',2,'DT',.001,'F0',15,'T0',0.07,'PlotON','y','verbose','n');

%analyse
FDwave_analyse_elastic('WFP',wf_path,'verbose','y')

%derived model
FDwave_model_derived_elastic_g1('WFP',wf_path,'verbose','n')

%Boundary conditions
FDwave_bc_select('WFP',wf_path,'BCTYPE','topABC','NAB',45,'PlotON','y','verbose','n') ;

% source and reciever geometry
FDwave_geometry_src_single('WFP',wf_path,'SX',250,'SZ',250,'PlotON','y','verbose','n');  

FDwave_geometry_rec_st_line_surf('WFP',wf_path,'DEPTH',50,'FIRST',50,'LAST',450,'DIFF',10,'verbose','n');  

%% Simulation
% Do the time stepping calculations of wavefield
FDwave_calculation_elastic_g1('plotON','n','DN_P',10,'verbose','n');

%% Post processing
str='SS_1.mat';          % this can be changed by user if required
% plotting the seismogram in image form
FDwave_calculation_plot('wfp',wf_path,'SSFileName',str)

% plotting the seismogram in wiggle traces form
FDwave_calculation_wiggle_plot('wfp',wf_path,'SSFileName',str,'scale',3)


% animating the wave propagation
FDwave_calculation_animate('WFP',wf_path,'SSFileName','SS_1.mat', 'WaveFieldFileName','wavefield_1')

%% Terminate FDwave program
FDwave_deinitialize(code_path)



export_fig fig1_1layer_model/homo_ss.fig -pdf
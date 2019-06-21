% This code is for generating the synthetics for 2 layer case

%% This part will setup all the FDwave program
clc; close all; clear all;
code_path='..\FDwave';                                                                    % Path of FD code files 
addpath(code_path);                                                                        % Add the code folder to the current command space
wf_path=pwd;                                                                                   % where you want to store your data. PWD means the current directory
FDwave_initialize('CP',code_path,'WFP',wf_path,'verbose','n');     % do necessary steps for initialization

%% Preprocessing
% create/ modify model
T=[400,400,400,400];
vp=linspace(1800,4500,4);
vs=linspace(1600,3000,4);
rho=linspace(1600,2200,4);
FDwave_model_n_layers('WFP',wf_path,'WAVE_TYPE','Elastic','DX',5,'DZ',5,'THICKNESS',T,... 
         'HV_RATIO',1,'Vp',vp,'VS',vs,'RHO',rho,'PlotON','y')

%source     
FDwave_source_ricker('WFP',wf_path,'T',2,'DT',.0005,'F0',15,'T0',0.07,'PlotON','y','verbose','n');

%analyse
FDwave_analyse_elastic('WFP',wf_path,'verbose','y')

%derived model
FDwave_model_derived_elastic_g1('WFP',wf_path,'verbose','n')

%Boundary conditions
FDwave_bc_select('WFP',wf_path,'BCTYPE','topFS','NAB',50,'PlotON','y','verbose','n') ;

%Source and reciever geometry
FDwave_geometry_src_single('WFP',wf_path,'SX',121,'SZ',10,'PlotON','y','verbose','n');  
FDwave_geometry_rec_st_line_surf('WFP',wf_path,'DEPTH',1,'DIFF',1,'verbose','n');  

FDwave_geometry_plot('FIGNO',3, 'HOP_S',5, 'HOP_R',10)


%% Simulation
% Do the time stepping calculations of wavefield
FDwave_calculation_elastic_g1('dN_SS',1,'dN_W',200,'dN_P',50,'PlotON','n');


%% Post processing
str='SS_1.mat';          % this can be changed by user if required
% plotting the seismogram in image form
FDwave_calculation_plot('wfp',wf_path,'SSFileName',str,'scale',4)

% plotting the seismogram in wiggle traces form
FDwave_calculation_wiggle_plot('wfp',wf_path,'SSFileName',str,'scale',4)

% animating the wave propagation
FDwave_calculation_animate('WFP',wf_path,'SSFileName','SS_1.mat', 'WaveFieldFileName','wavefield_1')

%% Terminate FDwave program
FDwave_deinitialize(code_path)


export_fig fig3_4layer_model/layer_model.fig -pdf
export_fig fig3_4layer_model/layer_SS.fig -pdf
export_fig fig3_4layer_model/layer_SSwig.fig -pdf
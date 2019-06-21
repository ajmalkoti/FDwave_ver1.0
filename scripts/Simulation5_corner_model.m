% Please see the instructions for each section in comments

%% This part will setup all the FDwave program
clc; close all; clear all;
code_path='..\FDwave';                                                                    % Path of FD code files 
addpath(code_path);                                                                        % Add the code folder to the current command space
wf_path=pwd;                                                                                   % where you want to store your data. PWD means the current directory
FDwave_initialize('CP',code_path,'WFP',wf_path,'verbose','n');     % do necessary steps for initialization

%% Preprocessing
% A dipping-layer model
% Initialize a model with a homogeneous background
model_build_init('WFP',wf_path,'Wave_Type','Elastic','NX',500,'NZ',400,'DX',5,'DZ',5,'VP',2200, 'VS',...
    1800,'RHO',1600,'plotON','n')
% insert: a wedge
CVec={[200,200],[500,200],[500,400],[400,400],[200,200]};
model_build_shape_arbitrary('WFP',wf_path,'coord',CVec,'VP',2800,'VS',2200,'RHO',1800,'plotON','n');
% Plot the final model.
model_plot('WFP',wf_path)

%source
FDwave_source_ricker('WFP',wf_path,'T',1.5,'DT',.00025,'F0',20,'T0',0.05,'PlotON','y');

%analyse
FDwave_analyse_elastic('WFP',wf_path)

%derived model
FDwave_model_derived_elastic_g1('WFP',wf_path)

% Boundary Conditions
FDwave_bc_select('WFP',wf_path,'BCTYPE','topFS','NAB',50,'PlotON','y') ;
% Bording 2004 Nearly optimal BC

% source and reciever geometry
FDwave_geometry_src_single('WFP',wf_path,'SZ',40,'PlotON','n');                 %figure(gcf); axis image
FDwave_geometry_rec_st_line_surf('WFP',wf_path,'DEPTH',1,'PlotON','n');            %figure(gcf); axis image
FDwave_geometry_plot('FIGNO',3, 'HOP_S',5, 'HOP_R',4)

%% Simulation
% Do the time stepping calculations of wavefield
FDwave_calculation_elastic_g1('dN_SS',20,'dN_W',20,'dN_P',50,'PlotON','n');


%% Post processing
str='SS_1.mat';                                                              % this should be changed by user if required
% plotting the seismogram in image form
FDwave_calculation_plot('wfp',wf_path,'SSFileName',str,'scale',5)

% plotting the seismogram in wiggle traces form
FDWave_calculation_wiggle_plot('wfp',wf_path,'SSFileName',str,'scale',5)

% animating the wave propagation
FDwave_calculation_animate('WFP',wf_path,'SSFileName','SS_1.mat', 'WaveFieldFileName','wavefield_1')

%% Terminate FDwave program
FDWave_deinitialize(code_path)

export_fig fig5_corner_model/corner_model.fig -pdf
export_fig fig5_corner_model/corner_SS.fig -pdf

% Script to estimate and apply spatial filtering

clear all
close all
clc


%% Loading data
load('FetalECG.mat')

[nbSamples, nbSensors] = size(x);
time = (0:nbSamples-1) / Fs;
Ts   = 1/Fs;



%% Preprocessing: highpass filtering to remove baseline on each channel




%% R peak detection
% 1. TO DO Selection of channel used to detect R peak

% 2. Apply R peak detection



%% Spatial fitlers estimated by PiCA



%% Comparison with PCA



%% Comparison with ICA




%% Figures






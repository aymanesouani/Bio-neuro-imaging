% Script to detect R peak

clear all
close all
clc


%%
load('HealthyECG.mat')
nbSamples = length(x);
x = x / max(abs(x));
time = (0:nbSamples-1) / Fs;
Ts   = 1/Fs;




%% R peak detection



%% Epoching each beat
nbSampleBefore = 200;
nbSampleAfter  = 500;
beats = epoch(x, rPeak, nbSampleBefore, nbSampleAfter);


%% Figures

    
    
        
        
        


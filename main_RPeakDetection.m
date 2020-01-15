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
nbL = ;
%   _ nbL = number of taps in the lowpass filter
%   _ nbH = number of taps in the highpass filter
%   _ nbMA = number of taps in the MA filter
%   _ prec = half-width of the interval precision to define simultaneous R
%            peaks
[rPeak, rPeak_BP, rPeak_MA] = ecgRPeakDetector(x, nbL, nbH, nbMA, prec, Fs);


%% Epoching each beat
nbSampleBefore = 200;
nbSampleAfter  = 500;
beats = epoch(x, rPeak, nbSampleBefore, nbSampleAfter);


%% Figures

    
    
        
        
        


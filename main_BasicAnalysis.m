% Script used to the basic anaylis of ECG signal


clear all
close all
clc




%% Loading data
load('HealthyECG.mat')
nbSamples = length(x);
time = (0:nbSamples-1) / Fs;

%% Spectral analysis
fft_ecg = fftshift(fft(x));
f = (0:nbSamples-1)*(Fs/nbSamples);     % frequency range
power = abs(fft_ecg).^2/nbSamples;    % power of the DFT

plot(f,power)
xlabel('Frequency')
ylabel('Power')

%% Spectrogram
noverlap = 5;
figure()
spectrogram(x, hanning(2024),noverlap,[], Fs)

% Script to analyse the filters used in the R peak detection algorithm

clear all
close all
clc


%% Loading data
load('HealthyECG.mat')
nbSamples = length(x);
time = (0:nbSamples-1) / Fs;

nbFreq = 1024; % Number of frequency bins



%% 1. Lowpass filter
num = [1 0 0 0 0 0 -1];
num = conv(num, num);
den = [1 -1];
den = conv(den, den);
[h,w] = freqz(num,den,'whole')



  

figure(1); clf
axs2(1) = subplot(211); % Plot the gain of the filter
plot(w/pi,20*log10(abs(h)))
%plot(w/pi,h)
ylabel('Magnitude (dB)')
xlabel('Normalized Frequency (\times\pi rad/sample)')
axs2(2) = subplot(212); % Plot the phase of the filter

plot(w/pi,unwrap(phase(h)))
%plot(w/pi,h)
ylabel('Phase')
xlabel('Normalized Frequency (\times\pi rad/sample)')
linkaxes(axs1, 'x');
    
    
%% 2. Filtrage passe haut
num = zeros(1,33);
num(1,1)=-1;
num(1,17) = 32;
num(1,33) = 1;
den = [1 1];
[h, w] = freqz(num,den,'whole');
figure(2); clf
axs2(1) = subplot(211); % Plot the gain of the filter
plot(w/pi,20*log10(abs(h)))
%plot(w/pi,h)
ylabel('Magnitude (dB)')
xlabel('Normalized Frequency (\times\pi rad/sample)')

axs2(2) = subplot(212); % Plot the phase of the filter
plot(w/pi,unwrap(phase(h)))
%plot(w/pi,h)
ylabel('Phase')
xlabel('Normalized Frequency (\times\pi rad/sample)')

linkaxes(axs2, 'x');


%% 3. Derivateur
num = 1/12 * [-1 8 -8 1];
den = [1];
[h,w] = freqz(num,den,'whole')

figure(3); clf
axs3(1) = subplot(211); % Plot the gain of the filter
plot(w/pi,20*log10(abs(h)))
%plot(w/pi,h)
ylabel('Magnitude (dB)')
xlabel('Normalized Frequency (\times\pi rad/sample)')
  
axs3(2) = subplot(212); % Plot the phase of the filter
plot(w/pi,unwrap(phase(h)))
%plot(w/pi,h)
ylabel('Phase')
xlabel('Normalized Frequency (\times\pi rad/sample)')

linkaxes(axs3, 'x');



%% 4. MA


figure(4); clf
axs4(1) = subplot(211); % Plot the gain of the filter
    
axs4(2) = subplot(212); % Plot the phase of the filter


linkaxes(axs4, 'x');


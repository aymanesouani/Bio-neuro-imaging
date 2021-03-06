function [rPeak, rPeak_BP, rPeak_MA] = ecgRPeakDetector(x, nbL, nbH, nbMA, prec, Fs)


% ecgRPeakDetector      function to detect R peak in an ECG
%
% [rPeak, rPeak_BP, rPeak_MA, locRaw_BP, locRaw_MA] = 
%               ecgRPeakDetector(x, nbL, nbH, nbMA, prec)
%
% Inputs:
%   _ x = ECG signal (vector)
%   _ nbL = number of taps in the lowpass filter
%   _ nbH = number of taps in the highpass filter
%   _ nbMA = number of taps in the MA filter
%   _ prec = half-width of the interval precision to define simultaneous R
%            peaks
%   _ Fs = sampling frequency (in Hz)
%
% Outputs:
%   _ rPeak: indexes of samples detected as R peak simultaneously on both
%            channels
%   _ rPeak_BP: indexes of samples detected as R peak in the filtered
%               signal
%   _ rPeak_MA: indexes of samples detected as R peak in the MA signal


      

% 1. Lowpass filtering (the output signal is denoted ecg_L)
num_lp = [1 0 0 0 0 0 -1];
num_lp = conv(num_lp, num_lp);
den_lp = [1 -1];
den_lp = conv(den_lp, den_lp);
ecg_L = filter(num_lp, den_lp, x);

% 2. Highpass filtering (the output signal is denoted ecg_BP)
num_bp = zeros(1,33);
num_bp(1,1)=-1;
num_bp(1,17) = 32;
num_bp(1,18) = -32;
num_bp(1,33) = 1;
den_bp = [1 -1];
ecg_BP = filter(num_bp, den_bp, x);

% 3. Derivative (the output signal is denoted ecg_D)
num_d = 1/12 * [-1 8 0 -8 1];
den_d = 1;
ecg_D = filter(num_d, den_d, x) ;

% 4. Square (the output signal is denoted ecg_Q)
ecg_Q = x.^2 ;

% 5. MA (the output signal is denoted ecg_MA)
samples = 30; % BETWEEN 35 AND 40
num_ma = 1/samples * ones(1, samples);
den_ma = 1;
ecg_MA = filter(num_ma, den_ma, x) ;

% 6. Detection of peaks on MA signal
[peakDetected_MA, locDetected_MA, ...
    pksRaw_MA, locRaw_MA, ...
    THR_Sig_Store_MA, THR_Noise_Store_MA, ...
    SIG_LEV_Store_MA, NOISE_LEV_Store_MA] = peakDetector(ecg_MA, Fs);

rPeak_MA = locDetected_MA ; % TO DO: Compensation of delays 


% 7. Detection of peaks on filter signal
[peakDetected_BP, locDetected_BP, ...
    pksRaw_BP, locRaw_BP, ...
    THR_Sig_Store_BP, THR_Noise_Store_BP, ...
    SIG_LEV_Store_BP, NOISE_LEV_Store_BP] = peakDetector(ecg_BP, Fs);

rPeak_BP = locDetected_BP; % TO DO: Compensation of delays 



% 8. Selection of peaks that are simultaneously on both signal
rPeak = % TO DO


% Figure
nbSamples = length(x);
time = (0:nbSamples-1) / Fs;
fig = figure(11); clf
    axs1(1) = subplot(6,1,1);
        plot(time, x);hold on
        plot(rPeak_BP/Fs, x(rPeak_BP), 'o')
        plot(rPeak_MA/Fs, x(rPeak_MA), '*')        
        plot(rPeak/Fs, x(rPeak), 'dk')
        ylabel('ECG')
        grid on
        
    axs1(2) = subplot(6,1,2);
        plot(time, ecg_L);
        ylabel('Lowpass filter')
        grid on
        
    axs1(3) = subplot(6,1,3);
        plot(time, ecg_BP); hold on
        plot(locRaw_BP/Fs, pksRaw_BP, 'o')
        plot(locDetected_BP/Fs, peakDetected_BP, 'k*')
        ylabel('Highpass filter')
        grid on
        
    axs1(4) = subplot(6,1,4);
        plot(time, ecg_D);
        ylabel('Derivative filter')
        grid on
        
    axs1(5) = subplot(6,1,5);
        plot(time, ecg_Q);
        ylabel('Square')
        grid on
        
    axs1(6) = subplot(6,1,6);
        plot(time, ecg_MA); hold on
        plot(locRaw_MA/Fs, pksRaw_MA, 'o')
        plot(locDetected_MA/Fs, peakDetected_MA, 'k*')
        ylabel('MA filter')
        grid on
        
        
	linkaxes(axs1, 'x');


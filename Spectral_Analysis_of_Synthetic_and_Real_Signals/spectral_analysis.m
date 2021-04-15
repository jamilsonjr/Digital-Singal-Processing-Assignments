function [dft] = spectral_analysis(x, M)
%% R1a)
% Frequency
%% R1b)
figure(M)
plot(x)
grid on

title('Q1b. Signal x')

% R1b)
% The signal obtained can be described as a sinusoidal signal made up by
% the sum of 3 sinusoids with differents frequencies , amplitude and phase.
% (Aesthetically it looks like a sinusoid with added noise)
% The differences between M = 512 and M = 1024 appears only to be in the x
% axis, the same value appears at double the time index for M = 1024. This
% is normal as the sampling rate is doubled.


%% R1c)
dft = fft(x);
dft(abs(dft) < 1e-6) = 0;
figure()
plot(0:M-1,abs(dft)/M)
title('Q1C. Amplitude')
grid on
xlabel('Frequency')
ylabel('Amplitude')
xlim([0 35]);

figure()
plot(0:M-1,angle(dft))
grid on
title('Q1c. Angle')
xlabel('Frequency')
ylabel('Angle')

xlim([0 35]);

% Since the fourier transform of a cosine of frequency f0 are 2 impulses at opposite
% frequencies (f0 and -f0), it's only normal that the dft of our signal would be 6
% impulses, 3 for the one sided version shown.


%% R1d) and R1e)
%% By inspection of the main frequencies
%The frequencies are 5, 10 and 26 [Hz]
xr = zeros(1, length(dft));  
frequencies = top_three_frequencies(dft,M); % Gets the frequencias of the 3 main frequencies.
for n = 1:M
    sum  = 0;
    for k=frequencies
        sum = sum + dft(k+1)*exp(1i*2*pi*k*n/M); 
    end
    xr(n) = (2/M)*sum;    
end
%% plot
figure(M)
plot(0:M-1, xr)
hold on
plot(0:M-1, x)
grid on
title('Signal Reconstruction from  DFT Equations');
legend('Reconstructed Signal', 'Original Signal');


%% plot
figure()
plot(0:M-1, ifft(dft))
hold on
plot(0:M-1, x)
grid on
title('Signal Reconstruction from ifft matLab function');
legend('Reconstructed Signal', 'Original Signal');

%% R1f

% The length of the DFT, N, improves the reconstruction of the signal, mainly by improving
% the resolution since more samples are used. By doubling the length, the
% resolution is also doubled. But this is not a general rule since after a
% certain length there is barely any improvement on the reconstructed
% signal.
% For N = 512 and N = 1024, the differences are minimal, only perceivable
% when zooming in. The most notable difference is for N = 1024 the values
% are twice as "close" as said before.
end


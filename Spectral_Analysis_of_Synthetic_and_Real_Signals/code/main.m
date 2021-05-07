clc
close all
clear
%% Lab2: Discrete Fourier Transform
%% Spectral analysis of a synthetic signal.
% For question 1, check inside the function spectral_analysis
% Set M HERE!!!! First to 512 then to 1024
for M = [512,1024]
% Build the signal
w0 = @(M) 5.2*2*pi/M;
x_ = @(n) 5*cos(w0(M)*n + 1) + 2*cos(2*w0(M)*n + 2) + 3*cos(5*w0(M)*n + 3);
n = linspace(0,M-1, M);
x = x_(n);

spectral_analysis(x, M);
end

%% Spectral analysis of a real voice signal
%% R2a)
[r, Fs] = audioread('How_many_roads.wav');
soundsc(r, Fs);
%% R2b) 
M = 2048;
new_signal = r(48500:48500+M-1, :);

%% R2c)
<<<<<<< HEAD
dft = spectral_analysis(new_signal, M);

%% R2d

% As opposite to the first signal,x(n), the voice has many more harmonics.
% By only taking the frequencies of the largest peaks, the reconstruction
% error is bigger. In fact, in terms of amplitude, the signal is quite well
% reconstructed but the missing harmonics make the words in the signal less
% clear and audible.
% Also,since discrete-time signals are only unique over frequencies in a 2pi interval and
% continuous-time signals are unique for each frequency, it's inevitable
% that many of the frequencies of the continuous signal will be
% mapped into the 2pi interval, this is aliasing and is the reason the
% signal cannot be fully reconstructed. (<=> length(r) > M)
% When we threshold below, what we are doing is basically filtering the
% signal to remove these noisy spectral components.
=======
dft = spectral_analysis(new_signal, M); 
%% R2e)
%% Establish an S_threshold
close all
dft = fft(r);
zeros_before = nnz(~abs(dft(:,1)));
dft(abs(dft) < 15) = 0; %% S_threshold the we still hear the word is around 15!
zeros_after = nnz(~abs(dft(:,1)));
figure()
plot(0:length(r)-1,abs(dft))
title('Amplitude of the Voice Signal')
grid on
xlabel('Frequency')
ylabel('Amplitude')
r_reconstructed = ifft(dft);

soundsc(r_reconstructed, Fs);
num_of_discarted_coeff = zeros_after - zeros_before

clc
close all
clear
%% Lab2: Discrete Fourier Transform
%% Spectral analysis of a synthetic signal.
% Ol� Colega Pungo, n�o te esque�as de apagar os comments antes de enviar �
% professora! Thanks 
% Set M HERE!!!! First to 512 then to 1024
M = 1024;
% Build the signal
w0 = @(M) 5.2*2*pi/M;
x_ = @(n) 5*cos(w0(M)*n + 1) + 2*cos(2*w0(M)*n + 2) + 3*cos(5*w0(M)*n + 3);
n = linspace(0,M-1, M);
x = x_(n);
%%
spectral_analysis(x, M);
% R1F) PUNGO: Repeat everything with M = 1024
%% Spectral analysis of a real voice signal
%% R2a)
[r, Fs] = audioread('How_many_roads.wav');
soundsc(r, Fs);
%% R2b) 
M = 2048;
new_signal = r(48500:48500+M-1, :);
%% R2c)
dft = spectral_analysis(new_signal, M); %% Doent no work well! Why?
% Make the same comments as those asked in the first part.
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

% Lets spot the difference in the non null values of the vector before and
% after being cleared by the 



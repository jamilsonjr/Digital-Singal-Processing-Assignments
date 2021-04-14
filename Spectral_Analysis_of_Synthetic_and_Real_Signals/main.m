clc
close all
clear
%% Lab2: Discrete Fourier Transform
%% Spectral analysis of a synthetic signal.
% Set M HERE!!!!
M = 1024;
% Build the signal
w0 = @(M) 5.2*2*pi/M;
x_ = @(n) 5*cos(w0(M)*n + 1) + 2*cos(2*w0(M)*n + 2) + 3*cos(5*w0(M)*n + 3);
n = linspace(0,M-1, M);
x = x_(n);
%%
spectral_analysis(x, M);
%% Spectral analysis of a real voice signal
%% R2a)
[r, Fs] = audioread('How_many_roads.wav');
soundsc(r, Fs);
%% R2b) 
M = 2048;
new_signal = r(48500:48500+M-1, :);
%% R2c)
dft = spectral_analysis(new_signal, M); %% Doent no work well! Why?
figure()
plot(0:M-1, ifft(dft))
%%


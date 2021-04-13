clc
close all
clear
%% Lab2: Discrete Fourier Transform
%% Spectral analysis of a synthetic signal.
spectral_analysis(512);
%% Spectral analysis of a real voice signal
%% R2a)
[r, Fs] = audioread('How_many_roads.wav');
soundsc(r, Fs);
%% R2b) 
M = 2048;
new_signal = r(48500:48500+M-1, :);
%% R2c)
dft = fft(new_signal);
dft(abs(dft) < 1e-6) = 0;
figure()
plot(0:M-1,abs(dft)/M)
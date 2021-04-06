clc
close all
clear
%% Lab2: Discrete Fourier Transform
%% Spectral analysis of a synthetic signal.
%% R1a)
% Frequency
M = 512;
w0 = @(M) 5.2*2*pi/M;
x_ = @(n) 5*cos(w0(M)*n + 1) + 2*cos(2*w0(M)*n + 2) + 3*cos(5*w0(M)*n + 3);
n = linspace(0,M-1, M);
x = x_(n);
%% R1b)
figure()
plot(x)
grid on
title('Signal x')
% Comment: In this image it can be observed sinusoidal singal with several
% harmonics. The peaks of this signal is spaced on the X axis by 99, then 98,
% then 99, then 98 ... periodic?
%% R1c)
%% Normalized frequency?
Fs = 1000;
dft = fft(x);
P2 = abs(dft/M);
P1 = P2(1:M/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(M/2))/M;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%% Spectral analysis of a real voice signal
%% R2a)
[r, Fs] = audioread('How_many_roads.wav');
soundsc(r, Fs);
%% R2b) 


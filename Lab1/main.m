clear 
close all
clc
%% First assignment
%% Create the continous time signal
t = linspace(0, 2, 16000);
% Constants
[k_2, k_1, F_0, phi_0] = deal(1000, 0, 0, 0);
% Instantaneous frrequency
Omega = @(t) 2*pi*(k_2*t.^2 + k_1*t + F_0);
%chirp
x_c = @(t) cos( 2*pi*( (1/3)*k_2*t.^3 + (1/2)*k_1*t.^2 + F_0*t + phi_0) );
x = x_c(t);
figure
plot(t, x);
%% questions
% Confirmar se esta implementa��o est� certa?
% N�o existe aliasing pois n�o?
% o t est� bem?
%%
sound(x, 8000);
%%
% OK? Era o que estavamos � espepra
%%
% From the script tens
N=32; 
figure
spectrogram(x, hann(N), 3*N/4, 4*N, 8000, 'yaxis')
%% questions
%% Problem 4
[r, Fs] = audioread('romanza.wav');
%%
soundsc(r, Fs);
pause(5)
clear sound
%%
N = 1024; 
figure(88)
spectrogram(r(1:15*Fs), hann(N), 3*N/4, 4*N, Fs, 'yaxis');
%% Sampling Confirmar
r_sampled = r(1:5:15*Fs);
figure(99)
spectrogram(r_sampled, hann(N), 3*N/4, 4*N, Fs/5, 'yaxis');
% Camera lenta
% soundsc(r_sampled, Fs/5);
% pause(3)
% clear sound
%% Filtering
r_filtered = filter(fir1(100, 0.2), 1, r);
spectrogram(r_filtered(1:5:15*Fs), hann(N), 3*N/4, 4*N, Fs/5, 'yaxis');
% soundsc(r_filtered, Fs);
% pause(5)
% clear sound


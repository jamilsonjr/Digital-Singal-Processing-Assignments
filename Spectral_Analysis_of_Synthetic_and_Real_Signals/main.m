clc
close all
clear
%% Lab2: Discrete Fourier Transform
%% Spectral analysis of a synthetic signal.
% Olá Colega Pungo, não te esqueças de apagar os comments antes de enviar à
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
%%
% Todo: last question 


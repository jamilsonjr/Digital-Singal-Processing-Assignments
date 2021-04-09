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


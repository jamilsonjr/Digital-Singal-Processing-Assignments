clear
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
% figure
spectrogram(x, hann(N), 3*N/4, 4*N, 8000, 'yaxis')
%% questions
%% Problem 4
[r, Fs] = audioread('romanza.wav');
%%
sound(r, Fs);
%%
figure
spectrogram(r, hann(N), 3*N/4, 4*N, Fs, 'yaxis')
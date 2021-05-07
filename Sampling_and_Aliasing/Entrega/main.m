clear 
close all
clc
%% First assignment
%% Create the sampled version of the continous time signal
% Sampling times
t = linspace(0, 2, 16000);
% Constants
[k_2, k_1, F_0, phi_0] = deal(1000, 0, 0, 0);
% Instantaneous frequency
Omega = @(t) 2*pi*(k_2*t.^2 + k_1*t + F_0);
%chirp
x_c = @(t) cos( 2*pi*( (1/3)*k_2*t.^3 + (1/2)*k_1*t.^2 + F_0*t + phi_0) );
x = x_c(t);

figure
plot(t, x);

%% Question 1a 
soundsc(x, 8000);
%%
%% Question 2b

N=32; 
figure
spectrogram(x, hann(N), 3*N/4, 4*N, 8000, 'yaxis')

%% Question 3b
y = downsample(x,2);

soundsc(y,length(y));

% clear sound
N = 32;
spectrogram(y, hann(N), 3*N/4, 4*N, 4000, 'yaxis');

%% Question 3c

z = @(t) cos(2*pi*fi*t );
for fs = [4,8,20]*1000;
    
    t = linspace(0,1,fs/100);
    for fi = [1,4,8,15]*1000;
        figure;
        plot(z(t));
        xlim([0 length(t)])
    end
end


%% Question 4
[r, Fs] = audioread('romanza.wav');
N = 1024;
figure(87)
spectrogram(r, hann(N), 3*N/4, 4*N, Fs, 'yaxis');
%% Play the sound
soundsc(r, Fs);
pause(10)
clear sound

%% Question 5
r_sampled = r(1:5:15*Fs);

% Play the sampled signal
% soundsc(r_sampled, Fs/5);
% pause(10)
% clear sound

figure(99)
spectrogram(r_sampled, hann(N), 3*N/4, 4*N, Fs/5, 'yaxis');
%% Question 6
r_filtered = filter(fir1(100, 0.2), 1, r);
spectrogram(r_filtered(1:5:15*Fs), hann(N), 3*N/4, 4*N, Fs/5, 'yaxis');
soundsc(r_filtered, Fs);
% pause(5)
% clear sound


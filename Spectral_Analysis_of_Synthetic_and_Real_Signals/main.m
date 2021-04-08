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
dft = fft(x);
dft(abs(dft) < 1e-6) = 0;
figure()
plot(0:M-1,abs(dft)/M)
grid on
xlabel('Frequency')
ylabel('Amplitude')
figure()
plot(0:M-1,angle(dft))
grid on
xlabel('Frequency')
ylabel('Angle')
%% R1d)
xr = zeros(1, length(dft));  
for n=1:M    
    for k=1:M
        sum = (2/M)*dft(k)*exp(1i*2*pi*n/M); 
    end
    xr(n) = sum; 
end
plot(xr)

%% Spectral analysis of a real voice signal
%% R2a)
[r, Fs] = audioread('How_many_roads.wav');
soundsc(r, Fs);
%% R2b) 


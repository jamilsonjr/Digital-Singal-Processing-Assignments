%% Filtering 
%% R1a) Listen to the sound
% Pungo comment we hear the music with noise, like tik tiks. The msuic is a
% fucking classic! Love it! 
[y, Fs] = audioread('fugee.wav');
% sound(y, Fs);
%% R1b)Plot the Signal
% Pungo comment that the noise is in the form of diracs and we see them in
% the plot
figure()
plot(y);
%% R1c) Visualise Signal�s Magnitude Spectrum
% Use logarithmic scale because the sensitivity of our hearing is
% logarithmic as well.
Y = fft(y);
figure()
semilogy(abs(fftshift(Y))) 
grid on
%% LTI filter
%% R2a)
%[b,a] = butter(10, ) What is the cuttof frequency? 


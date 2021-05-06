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
%% R1c) Visualise Signal’s Magnitude Spectrum
% Use logarithmic scale because the sensitivity of our hearing is
% logarithmic as well.
Y = fft(y);
figure()
semilogy(abs(fftshift(Y))) 
grid on
%% LTI filter
%% R2a)
[b,a] = butter(10, 0.5); 
[h, w] = freqz(b, a);
plot(abs(h));
%% R2b) / R2c) % Improve plots
y_filtered = filter(b,a,y);
plot(y_filtered);
figure()
plot(y);
hold on
plot(y_filtered);
%sound(y_filtered, Fs);
%% R2d)
Y_filtered = fft(y_filtered);
figure()
semilogy(abs(fftshift(Y))) 
hold on
semilogy(abs(fftshift(Y_filtered)))
grid on
%% R3a/b) Filtering with a median filter
figure()
y_median_filtered = medfilt1(y,3);
plot(y)
hold on 
plot(y_median_filtered);
%% R3 c)
Y_filtered_median = fft(y_median_filtered);
figure()
semilogy(abs(fftshift(Y))) 
hold on
semilogy(abs(fftshift(Y_filtered_median)))
grid on
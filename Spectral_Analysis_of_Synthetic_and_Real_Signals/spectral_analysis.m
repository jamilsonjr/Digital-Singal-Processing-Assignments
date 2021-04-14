function [dft] = spectral_analysis(x, M)
%% R1a)
% Frequency
%% R1b)
figure()
plot(x)
grid on
title('Signal x')
% R1b)PUNGO: Comment on the pure signal. 
%% R1c)
dft = fft(x);
dft(abs(dft) < 1e-6) = 0;
figure()
plot(0:M-1,abs(dft)/M)
title('Amplitude')
grid on
xlabel('Frequency')
ylabel('Amplitude')

figure()
plot(0:M-1,angle(dft))
grid on
title('Angle')
xlabel('Frequency')
ylabel('Angle')

% R1d) PUNGO: Comment on the angle and absolute value plots of the dft.
%% R1d) and R1e)
%% By inspection of the main frequencies
%The frequencies are 5, 10 and 26 [Hz]
xr = zeros(1, length(dft));  
frequencies = top_three_frequencies(dft,M); % Gets the frequencias of the 3 main frequencies.
for n = 1:M
    sum  = 0;
    for k=frequencies
        sum = sum + dft(k+1)*exp(1i*2*pi*k*n/M); 
    end
    xr(n) = (2/M)*sum;    
end
%% plot
figure()
plot(0:M-1, xr)
hold on
plot(0:M-1, x)
grid on
title('Signal Reconstruction from  DFT Equations');
legend('Reconstructed Signal', 'Original Signal');


%% plot
figure()
plot(0:M-1, ifft(dft))
hold on
plot(0:M-1, x)
grid on
title('Signal Reconstruction from ifft matLab function');
legend('Reconstructed Signal', 'Original Signal');
end


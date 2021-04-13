function [] = spectral_analysis(M)
%% R1a)
% Frequency
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
%% R1d) and R1e)
%% Usando do todas
xr = zeros(1, length(dft));  
for n = 1:M
    sum  = 0;
    for k=[5, 10, 26]
        sum = sum + dft(k)*exp(1i*2*pi*k*n/M); 
    end
    xr(n) = (2/M)*sum;    
end
%% Por inspeção das componentes principais
% dft(5)
% dft(10)
% dft(26)
% xr_ = @(n) (1/M)*( dft(5)*exp(1i*2*pi*5*n/M) + dft(10)*exp(1i*2*pi*10*n/M) + dft(26)*exp(1i*2*pi*26*n/M) );
% n = linspace(0, M-1, M);
% xr = xr_(n);
%% plot
figure()
plot(0:M-1, xr)
hold on
plot(0:M-1, x)
grid on
title('Signal Reconstruction');
legend('Reconstructed Signal', 'Original Signal')
%The frequencies are 5, 10 and 26 [Hz]
end


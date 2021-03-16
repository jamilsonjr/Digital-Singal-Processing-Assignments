clear
%% First assignment
%% Create the continous time signal
t = linspace(0, 2, 100000);
% Constants
[k_2, k_1, F_0, phi_0] = deal(1000, 0, 0, 0);
% Instantaneous frrequency
Omega = @(t) 2*pi*(k_2*t.^2 + k_1*t + F_0);
%chirp
x_c = @(Omega) cos(Omega);
plot(t, x_c(Omega(t)))
%% Create the continuous time impulse train

w = 1/(2*800); %pulse width
d = w/2:w*2:10; %delay vector
pulse_train = pulstran(t, d, 'rectpuls', w); 
plot(t,y2); 
set(gca,'Ylim',[-0.1 1.1]);

%% Product between


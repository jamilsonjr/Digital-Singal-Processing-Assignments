clear 
close all
clc
%% Anomaly Detection in Energy Time Series Data
%% R1a)
% Function that receives a time series and returns the coeficcient 'a' for
% the AR model


%% R1 a) & b)
x_train = load('energy_train.mat');
% Obtaining the "a" coefficient
x = x_train.x_train;
N = 96;
a = AR_coef(x, N);

% Predicted signal 
[x_predicted, r] = deal(zeros(1, length(x)));
for n=1:length(x)
    if(n <= N)
        x_predicted(n) = x(n);
    else 
        x_predicted(n) = a*x(n-N); 
    end
    r(n) = x(n) - x_predicted(n);
end
%% Plots
figure
plot(x);
hold on
plot(x_predicted);
hold on
plot(r)
legend('x_train', 'x_predicted', 'Residual');
grid on 
title('Predicted and Residual plots');

%% R1c) Coeficient and the 
% Energy of the residual
Energy = 0;
for n=1:length(r)
    Energy = Energy + abs(r(n))^2; 
end
display(Energy);
display(a);

%% R1d) Short term model
P = 6;
a = AR_short_term_coef(r, P);
%% R1e) 
[r_predicted, e] = deal(zeros(1, length(r)));

for n=1:length(r)
    for k=1:P
        if(n <= k)
            r_predicted(n) = r(n);
        else        
            r_predicted(n)  = r_predicted(n) + a(k)*r(n-k);
        end
    end
    e(n) = r(n) - r_predicted(n);
end

x_new_prediction = x_predicted - r_predicted;

figure
plot(x);
hold on
plot(x_new_prediction);
hold on
plot(e)
legend('x_train', 'x_prediction', 'Residual');
grid on 
title('New Prediction and Residual plots');

Energy = 0;
for n=1:length(r)
    Energy = Energy + abs(r(n))^2; 
end
display(Energy);
display(a);
%% R1f) Coeficient and the Energy of the residual
Energy = 0;
for n=1:length(e)
    Energy = Energy + abs(e(n))^2; 
end
display(Energy);
display(a);

%% Part2 Anomaly Detection R2a) & R2b) & R2c)
% Load test data
x_test = load('energy_test.mat');
x = x_test.x_test;

% Creating predicted signal
N = 96;
a = AR_coef(x, N);
% Predicted signal 
[x_predicted, r] = deal(zeros(1, length(x)));
for n=1:length(x)
    if(n <= N)
        x_predicted(n) = x(n);
    else 
        x_predicted(n) = a*x(n-N); 
    end
    r(n) = x(n) - x_predicted(n);
end
% Short term prediction
P = 6;
a = AR_short_term_coef(r, P);
[r_predicted, e] = deal(zeros(1, length(r)));
for n=1:length(r)
    for k=1:P
        if(n <= k)
            r_predicted(n) = r(n);
        else        
            r_predicted(n)  = r_predicted(n) + a(k)*r(n-k);
        end
    end
    e(n) = r(n) - r_predicted(n);
end
x_new_prediction = x_predicted - r_predicted;

% Calculating anomaly
anomalies = Anomalies(x, x_predicted); % PUNGO SWITCH BETWEEN: x_predicted e x_new_prediction !!!!!!!! 
[pks, locs] = findpeaks(anomalies, 'MinPeakDistance', 50, 'MinPeakHeight', 0.1);
plot(anomalies);
hold on 
findpeaks(anomalies, 'MinPeakDistance', 50, 'MinPeakHeight', 0.1);
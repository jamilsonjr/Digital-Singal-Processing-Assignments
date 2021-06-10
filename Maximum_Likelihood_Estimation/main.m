clear close all clc
%% Maximum Likelihood Estimation
%% R1b) Load and Visualize
load('sar_image.mat');
imagem = imagesc(I);
title('Synthetic Aperture Radar (SAR)');
colormap('default');
%% R1c) Crop the images into ICE and WATER. Estimates the parameter(s) of the given distributions
% Cropping images
image_croped_ice = imcrop(imagem);
figure; 
imagesc(image_croped_ice);

image_croped_water= imcrop(imagem);
figure; 
imagesc(image_croped_water);

% Estimate the parameters of the distributions: PUNGO Comenta esta parte sff
% Mean
ice_mean = mean(mean(image_croped_ice)); % The first mean return mean of each column 
water_mean = mean(mean(image_croped_water));

% b 
ice_b = mean(mean(image_croped_ice.^2))/2;
water_b = mean(mean(image_croped_ice.^2))/2;

%Variance
ice_variance = mean(mean((image_croped_ice-ice_mean).^2));
water_variance = mean(mean((image_croped_water-water_mean).^2));

% PUNGO: OBTER OS RESULTADOS PARA AS PERGUNTAS
%% R1d) Plot the distributions and Compare with the 

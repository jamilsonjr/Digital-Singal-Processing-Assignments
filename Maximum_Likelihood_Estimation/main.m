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

% Estimate the parameters of the distributions:
% Exponential
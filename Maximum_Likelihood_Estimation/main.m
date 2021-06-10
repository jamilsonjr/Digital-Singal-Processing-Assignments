clear
close all 
clc
%% Maximum Likelihood Estimation
%% R1b) Load and Visualize
load('sar_image.mat');
img = imagesc(I);
title('Synthetic Aperture Radar (SAR)');
colormap('default');
%% R1c) Crop the images into ICE and WATER. Estimates the parameter(s) of the given distributions
%% Cropping images
% Ice
[image_croped_ice, rect_ice] = imcrop(I,[0.510000000000000,0.510000000000000,277.980000000000,483.980000000000]); 
figure
imagesc(image_croped_ice);
% Water
[image_croped_water, rect_water]= imcrop(I, [271.510000000000,2.51000000000000,531.980000000000,480.980000000000]);
figure; 
imagesc(image_croped_water);
%% Estimate the parameters of the distributions: PUNGO Comenta esta parte sff
% Ice Params
ice_normal_params = mle(image_croped_ice(:),'distribution','norm');
ice_exponential_params = mle(image_croped_ice(:),'distribution','exp');
ice_rayleigh_params = mle(image_croped_ice(:),'distribution','rayl');

% Water Params
water_normal_params = mle(image_croped_water(:),'distribution','norm');
water_exponential_params = mle(image_croped_water(:),'distribution','exp');
water_rayleigh_params = mle(image_croped_water(:),'distribution','rayl');
% PUNGO: OBTER OS RESULTADOS PARA AS PERGUNTAS

%% R1d) Plot the distributions and compare with the histogram
% histogram
figure;
histogram_ice = histogram(image_croped_ice(:),1000,'Normalization', 'pdf');
%% Distributions for Ice
rayleigh_ice = raylpdf(sort(image_croped_ice(:)), ice_rayleigh_params);
exponential_ice = exppdf(sort(image_croped_ice(:)), ice_exponential_params);
normal_ice = normpdf(sort(image_croped_ice(:)), ice_normal_params(1),ice_normal_params(2));
hold on 
plot(rayleigh_ice)
hold on
plot(exponential_ice)
hold on
plot(normal_ice)
title('Ice Histogram and Distributions')
xlabel('Pixel intensity');
ylabel('Probability density');
legend('Histogram', 'Rayleigh', 'Exponential', 'Normal');

%% Distributions for Water TODO voltar aqui PUNGO
rayleigh_water = raylpdf(sort(image_croped_water(:)), water_rayleigh_params);
exponential_water = exppdf(sort(image_croped_water(:)), water_exponential_params);
normal_water = normpdf(sort(image_croped_water(:)), water_normal_params(1),water_normal_params(2));
figure
histogram_water = histogram(image_croped_water(:),'Normalization', 'pdf');
hold on 
plot(rayleigh_water)
hold on
plot(exponential_water)
hold on
plot(normal_water)
title('Water Histogram and Distributions')
xlabel('Pixel intensity');
ylabel('Probability density');
legend('Histogram', 'Rayleigh', 'Exponential', 'Normal');

%% R2) Image Segmentation
%% R2a) Perform the segmentation using the best distribution: Rayleigh
ice_seg = log(raylpdf(I, ice_rayleigh_params));
water_seg = log(raylpdf(I, water_rayleigh_params));
Segmentation = ice_seg > water_seg;

figure;
imagesc(I);
hold on 
contour(logical(Segmentation), 'LineColor', 'r');
title('Segmentation');

%% R2b) Repeat the previous using patch  
patch = ones(5);
ice_with_patch = conv2(log(raylpdf(I, ice_rayleigh_params)), patch, 'same');
water_with_patch= conv2(log(raylpdf(I, water_rayleigh_params)), patch, 'same');
Patch_Segmentation = ice_with_patch > water_with_patch;
figure;
imagesc(I);
hold on 
contour(Patch_Segmentation, 'LineColor', 'r');
title('Segmentation with Patch');

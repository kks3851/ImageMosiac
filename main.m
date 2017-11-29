% EECS 332: Intro  to Computer Vision 
% Project : Project Mosiac 
% Author: Karan Shah, Francesco Spadafotra
% Main Function
% Calls other panoramic function for creartion of Panorama Image

clc;
close all;
clear all;

file_folder = 'C:\Users\Karan Shah\Desktop\Intro to Comp Vision\Project\Final\code\'; % file path
row_correction = 6; % parameters for cropping
column_correction = 15;

[file_names, image_num] = load_image(file_folder); % loading of images
[I, map] = imread(file_names{1,1});

[image_size, proj_transform] = feature_image(I, file_names, image_num); % feature extraction
[panorama, x_min, x_max, y_min, y_max, width, height] = panorama_size(proj_transform, image_size, I); % finding the size of panorama 
[panorama] = panorama_creation(panorama, x_min, x_max, y_min, y_max, width, height, image_num, file_names, proj_transform); % creation of panorama
[panorama_complete] = panorama_edit(panorama, row_correction, column_correction); % cropping of deformed part
figure;
imshow(panorama_complete) % final output
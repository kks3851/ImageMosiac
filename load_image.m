% EECS 332: Intro  to Computer Vision 
% Project : Project Mosiac 
% Author: Karan Shah, Francesco Spadafotra
% Loading Image Function
% Input: File path
% Output: File names and number of images 

function [file_names, image_num] = load_image(fileFolder)
%Loading of Images
file_folder = fileFolder;
dirOutput = dir(fullfile(file_folder,'*.jpg'));
file_names = {dirOutput.name}';
montage(file_names, 'Size', [1 5]);
image_num = numel(file_names);
end


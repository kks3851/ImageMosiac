% EECS 332: Intro  to Computer Vision 
% Project : Project Mosiac 
% Author: Karan Shah, Francesco Spadafotra
% Panorama Cropping Function
% Input: Panorama Image with the correction parameters
% Output: Cropped Panorama Image

function [panorama_complete] = panorama_edit(panorama, row_correction, column_correction)
[row, column,dimension] = size(panorama);
row_outer_1 = floor(row/(row_correction));
row_outer_2 = floor(row - row_outer_1);
column_outer_1 = floor(column/(column_correction));
column_outer_2 = floor(column - column_outer_1);
panorama_complete = panorama(row_outer_1:row_outer_2, column_outer_1:column_outer_2,:);
end


% EECS 332: Intro  to Computer Vision 
% Project : Project Mosiac 
% Author: Karan Shah, Francesco Spadafotra
% Panorama Size Function
% Input: Original Image with the image size and Projective transform
% Output: Empty Panorama Image with the width and height

function [panorama, x_min, x_max, y_min, y_max, width, height] = panorama_size(proj_transform, image_size, I)
for i = 1:numel(proj_transform)
    [x_limit(i,:), y_limit(i,:)] = outputLimits(proj_transform(i), [1 image_size(2)], [1 image_size(1)]);
end

% Find the minimum and maximum output limits
x_min = min([1; x_limit(:)]);
x_max = max([image_size(2); x_limit(:)]);

y_min = min([1; y_limit(:)]);
y_max = max([image_size(1); y_limit(:)]);

% Width and height of panorama.
width  = round(x_max - x_min);
height = round(y_max - y_min);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);
end


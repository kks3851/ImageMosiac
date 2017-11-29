% EECS 332: Intro  to Computer Vision 
% Project : Project Mosiac 
% Author: Karan Shah, Francesco Spadafotra
% Panorama Creation Function
% Input: Blank Panorama Image with the limiting parameters, projective 
% transform and image files
% Output: Panorama Image

function [panorama] = panorama_creation(panorama, x_min, x_max, y_min, y_max, width, height, image_num, file_names, proj_transform)
%Blends the image, as a mask that is used to blend with them
blender = vision.AlphaBlender('Operation', 'Binary mask','MaskSource', 'Input port');

% Create a 2-D spatial reference object defining the size of the panorama.
x_limit = [x_min x_max];
y_limit = [y_min y_max];
panorama_view = imref2d([height width], x_limit, y_limit);

% Create the panorama.
for i = 1:image_num

    I = imread(file_names {i, 1});
    
    % Transform I into the panorama.
    warped_image = imwarp(I, proj_transform(i), 'OutputView', panorama_view);

    % Generate a binary mask.
    mask_image = imwarp(true(size(I,1),size(I,2)), proj_transform(i), 'OutputView', panorama_view);
    % mask = mask .* 0.25;
    
    % Overlay the warpedImage onto the panorama.
    % For blending
    panorama = step(blender, panorama, warped_image, mask_image);
end

figure
imshow(panorama)

end


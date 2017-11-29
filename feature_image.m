% EECS 332: Intro  to Computer Vision 
% Project : Project Mosiac 
% Author: Karan Shah, Francesco Spadafotra
% Feature Image Extraction Function
% Input: Original Images 
% Output: Projective Transform and Image size

function [image_size, proj_transform] = feature_image(I, file_names, image_num)
gray_image = rgb2gray(I);
feature_points = detectSURFFeatures(gray_image);
[features, points] = extractFeatures(gray_image, feature_points);
proj_transform(image_num) = projective2d(eye(3));

% Iterate over remaining image pairs
for n = 2:image_num
    
    % Store points and features for I(n-1).
    points_previous = points;
    features_previous = features;
    I1 = gray_image;

    % Read I(n).
    I = imread(file_names {n, 1});
   
    % Detect and extract SURF features for I(n).
    gray_image = rgb2gray(I);
    points = detectSURFFeatures(gray_image);
    [features, points] = extractFeatures(gray_image, points);
    I2 = gray_image; 
    
    % Find correspondences between I(n) and I(n-1).
    index_pairs = matchFeatures(features, features_previous); 
    
    matched_points = points(index_pairs(:,1), :);
    matche_points_prev = points_previous(index_pairs(:,2), :);
    
    figure; 
    %showMatchedFeatures(I2,I1,matched_points,matche_points_prev,'montage');    

    % Estimate the transformation between I(n) and I(n-1).
    proj_transform(n) = estimateGeometricTransform(matched_points, matche_points_prev, 'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);

    % Compute T(n) * T(n-1) * ... * T(1)
    proj_transform(n).T = proj_transform(n).T * proj_transform(n-1).T;
end

image_size = size(I);  % all the images are the same size

% Compute the output limits  for each transform
for i = 1:numel(proj_transform)
    [x_limit(i,:), y_limit(i,:)] = outputLimits(proj_transform(i), [1 image_size(2)], [1 image_size(1)]);
end

avg_x_limit = mean(x_limit, 2);
[~, idx] = sort(avg_x_limit);
center_I_dx = floor((numel(proj_transform)+1)/2);
center_image_I_dx = idx(center_I_dx);
T_inv = invert(proj_transform(center_image_I_dx));

for i = 1:numel(proj_transform)
    proj_transform(i).T = proj_transform(i).T * T_inv.T;
end
end


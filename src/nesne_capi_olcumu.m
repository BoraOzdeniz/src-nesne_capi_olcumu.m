clc;
clear;
close all;

% Goruntu secme
[file, path] = uigetfile({'*.jpg;*.png'}, 'Bir goruntu sec');
img = imread(fullfile(path, file));

figure;
imshow(img);
title('Orijinal Goruntu');

% Griye cevir
if size(img,3) == 3
    grayImg = rgb2gray(img);
else
    grayImg = img;
end

% Gurultu azalt
filteredImg = imgaussfilt(grayImg, 2);

figure;
imshow(filteredImg);
title('Gri Seviye Goruntu');

% Binary yap
bw = imbinarize(filteredImg);

figure;
imshow(bw);
title('Binary Goruntu');

% Nesne ozellikleri
stats = regionprops(bw, 'EquivDiameter', 'Centroid');

% En buyuk nesneyi al
[~, idx] = max([stats.EquivDiameter]);
diameter = stats(idx).EquivDiameter;
center = stats(idx).Centroid;

% Sonucu goster
figure;
imshow(img);
hold on;
plot(center(1), center(2), 'r+', 'MarkerSize', 15, 'LineWidth', 2);
text(center(1), center(2), ...
    sprintf('Cap = %.2f px', diameter), ...
    'Color', 'red', 'FontSize', 12);
title('Nesne Capi Olcumu');
hold off;

fprintf('Nesnenin capi: %.2f piksel\n', diameter);

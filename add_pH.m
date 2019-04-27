function [magnitudes,sample] = add_pH()

save_location = "C:\Users\scary\Documents\Emmer\Current";

%% Get image and crop swatches and sample
[filename,pathname] = uigetfile('*.jpg','Select Image');

full_image = imread(fullfile(pathname,filename));

cropper = figure;
pH_scale_image = imcrop(rot90(full_image,-1)); % Rotated to look upright

sample_image = imcrop(rot90(full_image,-1));

close(cropper);

%% Pull out scale's RGB values
for i=1:3
    transect=pH_scale_image(:,:,i);
    transects(:,i)=mean(double(transect),1);
end

magnitudes = zeros(7,3);
for i=1:3
    [~,magnitudes(:,i)] = peakfinder(transects(:,i),[],[],-1);
end

%% Pull out sample's RGB values
sample = [];
for i=1:3
    sample_slice = sample_image(:,:,i);
    sample.value(i) = mean(double(sample_slice(:)));
    sample.std(i) = std(double(sample_slice(:)));
end

answer = inputdlg("pH response measured in this image");

sample.pH = str2double(answer);
filename = strcat(answer,'.mat');
save(fullfile(save_location,filename),'sample','magnitudes');



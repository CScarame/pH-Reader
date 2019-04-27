%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ph_guesser.m
% Author: Chris Scaramella
% 4/12/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ph = ph_guesser()

%% Get Cal curve

[file,path] = uigetfile();

load(fullfile(path,file)); %should contain x_cal,y_cal


%% Get image and crop swatches and sample
[filename,pathname] = uigetfile('*.jpg','Select Image');

full_image = imread(fullfile(pathname,filename));

cropper = figure;
pH_scale_image = imcrop(rot90(full_image,-1)); % Rotated to look upright

sample_image = imcrop(rot90(full_image,-1));

close(cropper);

colors = ['r','g','b'];
figure;
hold on;
slices = zeros(1,3);
for i=1:3
    slice = sample_image(:,:,i);
    slices(i) = mean(slice(:));
    plot(x_cal,y_cal(:,i),colors(i));
end


for i=1:size(x_cal,2)
    if(i==1)
        short_x = x_cal(i);
        short_d = calculate_distance(slices,y_cal(i));
    else
        new_d = calculate_distance(slices,y_cal(i));
        if(new_d < short_d)
            short_d = new_d;
            short_x = x_cal(i);
        end
    end
    
end
ph = short_x;

plot([ph ph],[0 255],'k');
for i = 1:3
    plot(ph,slices(i),strcat(colors(i),'x'));
end
end



function [x_cal, y_cal] = make_curve()

%% Get folder full of data points
working_dir = uigetdir();

data = dir(working_dir);

pattern = '(\d*\.\d*)\.mat';
sample_ph = [];
sample_values =[];
magnitudes_all = [];
num = 1;
for i=1:size(data)
    token = regexp(data(i).name,pattern,'tokens');
    if(isempty(token))
        continue;
    else
        load(fullfile(working_dir,data(i).name));
        sample_ph(num) = sample.pH;
        sample_values(num,1:3) = sample.value(1:3);
        num = num + 1;
    end
end

%% Plot data to create curve
colors = ['r','g','b'];
figure;
hold on;
for i=1:3
    plot(sample_ph,sample_values(:,i),strcat(colors(i),'x'));
end
title('Calibration Curve');
ylabel('Sensor Value');
xlabel('pH');
axis([0 3.5 0 255]);
x_cal = linspace(sample_ph(1),sample_ph(end),1000);
y_cal = zeros(size(x_cal,2),3);
for i=1:3
    cal_curve = polyfit(sample_ph, sample_values(:,i)',6);
    y_cal(:,i) = polyval(cal_curve,x_cal);
    plot(x_cal,y_cal(:,i),colors(i));
end

save(fullfile(working_dir,'Calibration_curve.mat'),'x_cal','y_cal');
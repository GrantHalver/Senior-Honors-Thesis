function [] = plotByFreq3D(data)
%plotByFreq3d Plots magnitude of frequency over time in 3D
%   X-axis is time, Y-axis is freq, Z-axis is magnitude

data(:, 4) = ceil((1:length(data))/512);

subplot(1, 2, 1);
plot3(data(:, 4), data(:, 3), data(:, 1));
xlabel('Time');
ylabel('Frequency');
zlabel('Magnitude');
title('Sensor 1');
axis([0 510 0 510 0 0.02]);

subplot(1, 2, 2);
plot3(data(:, 4), data(:, 3), data(:, 2));
xlabel('Time');
ylabel('Frequency');
zlabel('Magnitude');
title('Sensor 2');
axis([0 510 0 510 0 0.02]);

end


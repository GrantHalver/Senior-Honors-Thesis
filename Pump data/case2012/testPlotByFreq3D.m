data = F2_fixed;

data(:, 4) = ceil((1:length(data))/512);

plot3(data(:, 4), data(:, 3), data(:, 1));
xlabel('Time');
ylabel('Frequency');
zlabel('Magnitude');

figure();

plot3(data(:, 4), data(:, 3), data(:, 2));
xlabel('Time');
ylabel('Frequency');
zlabel('Magnitude');

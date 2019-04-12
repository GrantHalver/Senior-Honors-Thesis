function [] = plotByFreq2D(dataCol1, dataCol2)
%plotByFreq2D Graphs magnitude over time for each frequency

%Plotting magnitude of each frequency over time
j = 1;
color1 = 'black';
color2 = 'magenta';
color3 = 'cyan';
color4 = 'green';


for i = 1:4:512
    subplot(2, 2, j);
    plot(1:size(dataCol1, 1), dataCol1(:, i), color1, 1:size(dataCol1, 1), dataCol1(:, i+1), color2, 1:size(dataCol1, 1), dataCol1(:, i+2), color3, 1:size(dataCol1, 1), dataCol1(:, i+3), color4);
    xlabel('Time');
    ylabel('Magnitude')
    title("Accelerometer 1");
    legend(sprintf('%d', i), sprintf('%d', i+1), sprintf('%d', i+2), sprintf('%d', i+3));
    
    subplot(2, 2, j+1);
    plot(1:size(dataCol2, 1), dataCol2(:, i), color1, 1:size(dataCol2, 1), dataCol2(:, i+1), color2, 1:size(dataCol2, 1), dataCol2(:, i+2), color3, 1:size(dataCol2, 1), dataCol2(:, i+3), color4);
    xlabel('Time');
    ylabel('Magnitude')
    title("Accelerometer 2");
    legend(sprintf('%d', i), sprintf('%d', i+1), sprintf('%d', i+2), sprintf('%d', i+3));
    
    
    j = j + 2;
    if j > 3
        j = 1;
        figure();
    end
end

end


data = F2_fixed(1:length(F2_fixed)-10*512,:);

numberFFT = length(data)/512;

for i = 1:512
    if mod(i, 8) == 1
        figure();
        j = 1;
    end
    
    if mod(i, 2) ==  1 && i ~= 1
        hold off
        j = j + 1;
    else
        hold on
    end
    
    if j > 4
        j = 1;
    end
    
    subplot(2, 2, j);
    
    if mod(i, 2) == 0
        color1 = 'black';
        color2 = 'magenta';
    else
        color1 = 'cyan';
        color2 = 'green';
    end
    
    magnitudeOverTime = magnitudeOverFFT(data, i);
    plot(1:numberFFT, magnitudeOverTime(:,1), color1, 1:numberFFT, magnitudeOverTime(:,2), color2);
    xlabel('Time');
    ylabel('Magnitude');
    
end
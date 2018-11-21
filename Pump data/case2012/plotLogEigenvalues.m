function [diagonal1, diagonal2] = plotLogEigenvalues(data1, data2)
%plotLogEigenvalues Plots the negative logarithm of the eigenvalues
%   Detailed explanation goes here
diagonal1 = size(data1, 1);
diagonal2 = size(data2, 1);
for i = 1:diagonal1
 diagonal1(i, 1) = data1(i, i); 
 diagonal2(i, 1) = data2(i, i);
end

subplot(1, 2, 1);
plot(1:512, -log10(diagonal1));
%xlabel('Time');
%ylabel('Frequency');
title('Sensor 1');
%axis([0 510 0 510 0 0.02]);

subplot(1, 2, 2);
plot(1:512, -log10(diagonal2));
%xlabel('Time');
%ylabel('Frequency');
title('Sensor 2');
%axis([0 510 0 510 0 0.02]);

end


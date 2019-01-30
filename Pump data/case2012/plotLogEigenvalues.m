function [diagonal1, diagonal2] = plotLogEigenvalues(data1, data2, sizeFFT)
%plotLogEigenvalues Plots the negative logarithm of the eigenvalues
%   Detailed explanation goes here
diagonal1 = size(data1, 1);
diagonal2 = size(data2, 1);
for i = 1:diagonal1
 diagonal1(i, 1) = data1(i, i); 
 diagonal2(i, 1) = data2(i, i);
end

subplot(1, 2, 1);
plot(1:sizeFFT, -log10(sort(diagonal1, 'descend')));
xlabel('Eigenvalues in Descending Order');
ylabel('-log10(Eigenvalue)');
title('Sensor 1');
axis([0 sizeFFT 0 25]);

subplot(1, 2, 2);
plot(1:sizeFFT, -log10(sort(diagonal2, 'descend')));
xlabel('Eigenvalues in Descending Order');
ylabel('-log10(Eigenvalue)');
title('Sensor 2');
axis([0 sizeFFT 0 25]);

end


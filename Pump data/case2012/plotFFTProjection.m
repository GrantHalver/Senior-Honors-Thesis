function [xCol1, xCol2] = plotFFTProjection(eigenvectorsCol1,eigenvectorsCol2, data)
%PLOTFFTPROJECTION Summary of this function goes here
%   Detailed explanation goes here

eigenvectorsCol1T = transpose(eigenvectorsCol1(:, 1:3));
eigenvectorsCol2T = transpose(eigenvectorsCol2(:, 1:3));

%eigenvectorsCol1 = repmat(eigenvectorsCol1,1,512);
%eigenvectorsCol2 = repmat(eigenvectorsCol2,1,512);

sizeFFT = 512;
%Reduces data to only full FFTs
numberFFT = floor(length(data)/sizeFFT);
data = data(1:numberFFT*sizeFFT,:);


%Creates horizontal array of FFTs
fiCol1 = zeros(sizeFFT,numberFFT); %pre-allocation for speed
fiCol2 = zeros(sizeFFT,numberFFT);
for i = 1:numberFFT
    fiCol1(1:sizeFFT,i) = data(i*sizeFFT-(sizeFFT-1):i*sizeFFT, 1);
    fiCol2(1:sizeFFT,i) = data(i*sizeFFT-(sizeFFT-1):i*sizeFFT, 2);
end

%Finding average value for each position in the FFTs
fbarCol1 = mean(fiCol1, 2);
fbarCol2 = mean(fiCol2, 2);

%Subtracts fbar from each FFT
fiMinusFbarCol1 = zeros(sizeFFT, numberFFT);
fiMinusFbarCol2 = zeros(sizeFFT, numberFFT);
for i = 1:numberFFT
    fiMinusFbarCol1(:, i) = fiCol1(:,i)-fbarCol1;
    fiMinusFbarCol2(:, i) = fiCol2(:,i)-fbarCol2;
end

xCol1 = eigenvectorsCol1T*fiMinusFbarCol1;
xCol2 = eigenvectorsCol2T*fiMinusFbarCol2;


subplot(1, 2, 1);
plot3(xCol1(1, :), xCol1(2, :), xCol1(3, :));
title('Sensor 1');

subplot(1, 2, 2);
plot3(xCol2(1, :), xCol2(2, :), xCol2(3, :));
title('Sensor 2');
end
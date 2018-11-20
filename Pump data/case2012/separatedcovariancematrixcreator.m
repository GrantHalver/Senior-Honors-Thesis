function [covarianceMatrixCol1,covarianceMatrixCol2] = separatedcovariancematrixcreator(data)
%separateCovarianceMatrixCreator Creates separated covariance matricies of
%the data

%Reduces data to only full FFTs
numberFFT = floor(length(data)/512);
data = data(1:numberFFT*512,:);

%Creates horizontal array of FFTs
fiCol1 = zeros(512,numberFFT); %pre-allocation for speed
fiCol2 = zeros(512,numberFFT);
for i = 1:numberFFT
    fiCol1(1:512,i) = data(i*512-511:i*512, 1);
    fiCol2(1:512,i) = data(i*512-511:i*512, 2);
end

%Finding average value for each position in the FFTs
nInvCol1 = ones(size(fiCol1, 2), 1) / numberFFT;
fbarCol1 = fiCol1 * nInvCol1;
nInvCol2 = ones(size(fiCol2, 2), 1) / numberFFT;
fbarCol2 = fiCol2 * nInvCol2;

%Subtracts fbar from each FFT
fiMinusFbarCol1 = zeros(512, numberFFT);
fiMinusFbarCol2 = zeros(512, numberFFT);
for i = 1:numberFFT
    fiMinusFbarCol1(:,i) = fiCol1(:,i)-fbarCol1;
    fiMinusFbarCol2 = fiCol2(:,i)-fbarCol2;
end

covarianceMatrixCol1 = (1/(numberFFT-1))*(fiMinusFbarCol1)*transpose(fiMinusFbarCol1);
covarianceMatrixCol2 = (1/(numberFFT-1))*(fiMinusFbarCol2)*transpose(fiMinusFbarCol2);
end


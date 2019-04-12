function [covarianceMatrix] = covariancematrixcreator(data)
%CovarianceMatrixCreator Creates the covariance matrix for the data
%   Detailed explanation goes here
%Reduces data to only full FFTs
numberFFT = floor(length(data)/512);
data = data(1:numberFFT*512,:);

%Creates horizontal array of FFTs
fi = zeros(512, 2*numberFFT); %pre-allocation for speed
for i = 1:numberFFT
    fi(1:512,2*i-1:2*i) = data(i*512-511:i*512, 1:2);
end

%Finding average value for each position in the FFTs
nInv = ones(size(fi, 2), 2) / numberFFT;
fbar = fi * nInv;

%Subtracts fbar from each FFT
fiMinusFbar = zeros(512, 2*numberFFT);
for i = 1:numberFFT
    fiMinusFbar(1:512,2*i-1:2*i) = fi(:,2*i-1:2*i)-fbar;
end

covarianceMatrix = 1/(numberFFT-1)*(fiMinusFbar)*transpose(fiMinusFbar);

end
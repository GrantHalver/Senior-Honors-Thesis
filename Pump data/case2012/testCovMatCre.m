data = F2_fixed;

%Reduces data to only full FFTs
numberFFT = floor(length(data)/512);
data = data(1:numberFFT*512,:);

%Creates horizontal array of FFTs
for i = 1:numberFFT
    j = i*512;
    k = 2*i;
    fi(1:512,k-1:k) = data(j-511:j, 1:2);
end

%Finding average value for each position in the FFTs
nInv = ones(size(fi, 2), 2) / numberFFT;
fbar = fi * nInv;

%Subtracts fbar from each FFT
for i = 1:numberFFT
    k = 2*i;
    fiMinusFbar(1:512,k-1:k) = fi(:,k-1:k)-fbar;
end

covarianceMatrix = 1/(numberFFT-1)*transpose(fiMinusFbar)*(fiMinusFbar);
function [replace] = fouriercosinetransform(data,repeat)
%FourierCosineTransform Creates estimated value for missing data
%   Uses Fourier Cosine Transform to replace repeated values in the data

%Making matrix for DCT
numberFFT = floor(length(data)/512);
data(1:512*numberFFT,:);
repeat(1:512*numberFFT,:);
dataT = [];
repeat1 = [];
for i = 1:numberFFT
   dataT = [dataT; transpose(data(i*512-511:i*512,1:2))];
   repeat1 = [repeat1; transpose(repeat(i*512-511:i*512,:))];
end
data1 = [];
data2 = [];
for i = 1:2:length(dataT)-1
    data1 = [data1; dataT(i,:)];
    data2 = [data2; dataT(i+1,:)];
end



%Creating DCT
Y1 = dct(data1(:,:),[],2);
Y2 = dct(data2(:,:),[],2);

Y1inv = Y1;
Y1inv(:, 491:512) = zeros(length(Y1), 22);
Y2inv = Y2;
Y2inv(:, 491:512) = zeros(length(Y2), 22);

Y1inv = idct(Y1inv,[],2);
Y2inv = idct(Y2inv,[],2);

%Replacing values
for i = 1:length(data1)
    for j = 1:490
       if repeat1(i,j)==1
           data1(i,j) = Y1inv(i,j);
           data2(i,j) = Y2inv(i,j);
       end
    end
end

%Reformatting data to orignial format
replace = [];
for i = 1:length(data1)
    replace = [replace; transpose(data1(i,:)) transpose(data2(i,:)) transpose(1:512)];
end

end
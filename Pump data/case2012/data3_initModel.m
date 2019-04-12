%Loading variables
load('initmodel.mat');
F2_fixed = F3;

%Adding missing element before recording starts in a cycle
%F2_fixed = [F2_fixed(1:42747,:); [0,0,2]; F2_fixed(42748:end,:)];

F2_fixed = DataCleaner(F2_fixed);

%Truncating to full FFTs only
numberFFT = floor(length(F2_fixed)/512);
F2_fixed(1:512*numberFFT,:);

%Detecting repeat data
repeat = zeros(length(F2_fixed),1);
repeat(1,1)=1;
for i = 2:1:length(F2_fixed)
    if diff(F2_fixed(i-1:i,3)) == 0
        repeat(i,1)=1;
    elseif isequal(F2_fixed(i,1:2), [0,0])
            repeat(i,1)=1;
    elseif F2_fixed(i,3) == -0.001
            repeat(i,1)=1;
    end
end

%Converting matrix to be more readable
F2_fixedT = [];
repeat1 = [];
for i = 1:numberFFT
   F2_fixedT = [F2_fixedT; transpose(F2_fixed(i*512-511:i*512,1:2))];
   repeat1 = [repeat1; transpose(repeat(i*512-511:i*512,:))];
end
sensor1 = [];
sensor2 = [];
for i = 1:2:length(F2_fixedT)-1
    sensor1 = [sensor1; F2_fixedT(i,:)];
    sensor2 = [sensor2; F2_fixedT(i+1,:)];
end


%Replacing repeat data
F2_fixed = fouriercosinetransform(sensor1, sensor2, repeat1);

F2_fixedT = [];
for i = 1:numberFFT
   F2_fixedT = [F2_fixedT; transpose(F2_fixed(i*512-511:i*512,1:2))];
end
for i = 1:2:length(F2_fixedT)-1
    sensor1 = [sensor1; F2_fixedT(i,:)];
    sensor2 = [sensor2; F2_fixedT(i+1,:)];
end


F2_fixedTCol1 = zeros(517, 512);
F2_fixedTCol2 = zeros(517, 512);
for i = 1:2:length(F2_fixedT)
     F2_fixedTCol1(ceil(i/2), :) = F2_fixedT(i, :);
     F2_fixedTCol2(ceil(i/2), :) = F2_fixedT(i+1, :);
end

%Plost with last 11 included
plotByFreq2D(F2_fixedTCol1, F2_fixedTCol2);
%plotByFreq3D(F2_fixed(:,:));

%{

F2_fixedT = [];
for i = 1:numberFFT
   F2_fixedT = [F2_fixedT; transpose(F2_fixed(i*512-511:i*512,1:2))];
end
for i = 1:2:length(F2_fixedT)-1
    sensor1 = [sensor1; F2_fixedT(i,:)];
    sensor2 = [sensor2; F2_fixedT(i+1,:)];
end

%Getting covariance matrix
covarianceMatrix = covariancematrixcreator(F2_fixed);
[eigenvectors, eigenvalues] = eig(covarianceMatrix);

%Getting separate covariance matrices
[covMatCol1, covMatCol2] = separatedcovariancematrixcreator(F2_fixed, 512);
[eigenvectorsCol1, eigenvaluesCol1] = eig(covMatCol1);
[eigenvectorsCol2, eigenvaluesCol2] = eig(covMatCol2);

%Summing Frequency Values
sensor1_summed = zeros(length(sensor1), 256);
sensor2_summed = zeros(length(sensor2), 256);
for i = 1:numberFFT
    for j = 1:2:511
        sensor1_summed (i, (j+1)/2) = sensor1(i, j) + sensor1(i, j+1);
        sensor2_summed (i, (j+1)/2) = sensor2(i, j) + sensor2(i, j+1);
    end
end

%Converting back to original matrix format
sensor1_summedT = zeros(256*numberFFT, 1);
sensor2_summedT = zeros(256*numberFFT, 1);
for i = 1:numberFFT
    sensor1_summedT(i*256-255:i*256, 1) = sensor1_summed(i, :);
    sensor2_summedT(i*256-255:i*256, 1) = sensor2_summed(i, :);
end
F2_summed = [sensor1_summedT, sensor1_summedT];

%Getting separate cov matricies for summed values
[covMatCol1_summed, covMatCol2_summed] = separatedcovariancematrixcreator(F2_summed, 256);
[eigenvectorsCol1_summed, eigenvaluesCol1_summed] = eig(covMatCol1_summed);
[eigenvectorsCol2_summed, eigenvaluesCol2_summed] = eig(covMatCol2_summed);

F2_fixedT = F2_fixedT(1:1012, :);
F2_fixedTCol1 = zeros(506, 512);
F2_fixedTCol2 = zeros(506, 512);
for i = 1:2:length(F2_fixedT)
     F2_fixedTCol1(ceil(i/2), :) = F2_fixedT(i, :);
     F2_fixedTCol2(ceil(i/2), :) = F2_fixedT(i+1, :);
end

%Creating data visualizations
%Last 11 FFT show evidence of the pump stopping and are excluded
plotByFreq2D(F2_fixedTCol1, F2_fixedTCol2);
%plotByFreq3D(F2_fixed(:,:));

%Sorting eigenvectors
[dCol1, ind] = sort(diag(eigenvaluesCol1));
eigenvectorsCol1 = eigenvectorsCol1(:, ind);
[dCol2, ind2] = sort(diag(eigenvaluesCol2));
eigenvectorsCol2 = eigenvectorsCol2(:, ind2);

%figure();
%diagonal1 value 453 is negative, diagonal2 is complex double
%[diagonal1, diagonal2] = plotLogEigenvalues(eigenvaluesCol1, eigenvaluesCol2, 512);

%figure();
%plotLogEigenvalues(eigenvaluesCol1_summed, eigenvaluesCol2_summed, 256);

%[xCol1, xCol2] = plotFFTProjection(eigenvaluesCol1, eigenvaluesCol2, F2_fixed);
%

%}
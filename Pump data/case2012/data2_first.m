%Loading variables
load('Fdata2_first.mat');
F2_fixed = F2;

%Adding missing element before recording starts in a cycle
F2_fixed = [F2_fixed(1:42747,:); [0,0,2]; F2_fixed(42748:end,:)];

F2_fixed = DataCleaner(F2_fixed);

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

%Replacing repeat data
F2_fixed = fouriercosinetransform(F2_fixed, repeat);

%Getting covariance matrix
covarianceMatrix = covariancematrixcreator(F2_fixed);
[eigenvalues, eigenvectors] = eig(covarianceMatrix);

%Getting separate covariance matrices
[covMatCol1, covMatCol2] = separatedcovariancematrixcreator(F2_fixed);
[eigenvaluesCol1, eigenvectorsCol1] = eig(covMatCol1);
[eigenvaluesCol2, eigenvectorsCol2] = eig(covMatCol2);

%Creating data visualizations
%Last 10 FFT show evidence of the pump stopping and are excluded
%plotByFreq2D(F2_fixed(1:length(F2_fixed)-10*512,:));
plotByFreq3D(F2_fixed(1:length(F2_fixed)-10*512,:));

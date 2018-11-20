%Loading variables
load('Fdata2_last.mat');
load('Fdata2_last.mat', 't2');
load('Fdata2_last.mat', 'F2');
F2_fixed = F2;

run('datacleaner_last');

%Detecting repeat data
repeat = [0;diff(F2_fixed(:,3)) == 0] | F2_fixed(:,3) == -0.001;

%Replacing repeat data
for i = 512:512:264704
    F2_fixed(i-511:i,:) = fouriercosinetransform(F2_fixed(i-511:i,:),repeat(i-511:i,:),512);
end
F2_fixed(264704:end,:) = fouriercosinetransform(F2_fixed(264704:end,:),repeat(264704:end,:),138);
%Loading variables
load('Fdata2_second.mat');
load('Fdata2_second.mat', 't2');
load('Fdata2_second.mat', 'F2');
F2_fixed = F2;

run('datacleaner_second');

%Detecting repeat data
repeat = [0;diff(F2_fixed(:,3)) == 0] | F2_fixed(:,3) == -0.001;

%Replacing repeat data
for i = 512:512:410624
    F2_fixed(i-511:i,:) = fouriercosinetransform(F2_fixed(i-511:i,:),repeat(i-511:i,:),512);
end
F2_fixed(410625:end,:) = fouriercosinetransform(F2_fixed(410625:end,:),repeat(410625:end,:),425);
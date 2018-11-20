%Loading variables
load('initmodel.mat');
F3_fixed = F3;

run('datacleaner_F3');

%Detecting repeat data
repeat = [0;diff(F3_fixed(:,3)) == 0] | F3_fixed(:,3) == -0.001;

%Replacing repeat data
for i = 512:512:264704
    F3_fixed(i-511:i,:) = fouriercosinetransform(F3_fixed(i-511:i,:),repeat(i-511:i,:),512);
end
F3_fixed(264705:end,:) = fouriercosinetransform(F3_fixed(264705:end,:),repeat(264705:end,:),11);
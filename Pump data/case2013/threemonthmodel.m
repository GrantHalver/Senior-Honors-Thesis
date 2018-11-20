%Loading variables
load('threemonthmodel.mat');
F2_fixed = F2;

run('datacleaner');

%Detecting repeat data
repeat = [0;diff(F2_fixed(:,3)) == 0] | F2_fixed(:,3) == -0.001;

%Replacing repeat data
%%{
for i = 512:512:264704
    F2_fixed(i-511:i,:) = fouriercosinetransform(F2_fixed(i-511:i,:),repeat(i-511:i,:),512);
end
F2_fixed(264705:end,:) = fouriercosinetransform(F2_fixed(264705:end,:),repeat(264705:end,:),84);
%}
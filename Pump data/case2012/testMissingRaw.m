missingRaw = [0];
testMR = [0;diff(F2(:,3)) > 1] & [0;diff(F2(:,3)) ~= -512.0010];
for i = 42748:1:45000
    if testMR(i,1)
        missingRaw = cat(1, missingRaw,i);
    end
end

missingRaw = missingRaw(2:length(missingRaw),:);
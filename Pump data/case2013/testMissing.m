missing = [0];
testM = [0;diff(F2_fixed(:,3)) > 1] & [0;diff(F2_fixed(:,3)) ~= -511];
for i = 1:1:length(F2_fixed)
    if testM(i,1)
        missing = cat(1, missing,i);
    end
end

missing = missing(2:length(missing),:);
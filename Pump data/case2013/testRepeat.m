repeat_checker = [0];
testR = [0;diff(F2_fixed(:,3)) == 0] | F2_fixed(:,3) == -0.001;
for i = 1:1:length(F2_fixed)
    if testR(i,1)
        repeat_checker=cat(1,repeat_checker,i);
    end
end
repeat_checker = repeat_checker(2:length(repeat_checker),:);
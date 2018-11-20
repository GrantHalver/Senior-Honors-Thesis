rerepeat = [0];
for i=1:1:length(repeat_checker)
    if repeat(repeat_checker(i,1),1)
        rerepeat = cat(1, rerepeat, repeat_checker(i,1));
    end
end
rerepeat = rerepeat(2:length(rerepeat),:);
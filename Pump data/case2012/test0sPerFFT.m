ZeroesPerFFT = zeros(512, 2);
for i = 1:length(F2_fixed)
    for j = 1:2
        if F2_fixed(i,j) == 0
            if mod(i, 512) == 0
                ZeroesPerFFT(512,j) = ZeroesPerFFT(512,j) + 1;
            else
                ZeroesPerFFT(mod(i, 512),j) = ZeroesPerFFT(mod(i, 512),j) + 1;
            end
            if mod(i, 512) == 1
                lastLeadingZero = i;
            end
        end
    end
end
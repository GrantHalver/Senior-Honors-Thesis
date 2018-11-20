function [C] = fouriercosinetransform(F2_fixed,repeat,dim)
%FourierCosineTransform Creates estimated value for missing data
%   Uses Fourier Cosine Transform to create a trendline along the series
%   1:512
Y = dct(F2_fixed(:,1:2),[],2);
for i=1:1:dim
    if repeat(i,1)
        F2_fixed(i,1:2)=Y(i,:);
        F2_fixed(i,3)=ceil(F2_fixed(i,3))+1;
    end
end
C = F2_fixed;
end


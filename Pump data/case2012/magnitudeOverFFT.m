function [toPlot] = magnitudeOverFFT(data,t)
%magnitudeOverFFT Creates a matrix containing values of only 1 frequency
%value, to see change over time in magnitude of frequency response

toPlot = [];
for i = t:512:length(data)
    toPlot = [toPlot; data(i,:)];
end

end
function [data] = DataCleaner(data)
%DataCleaner Cleans the data from the FFT accelerometer data files

%Deleting spacing (0s at start of file and -1E-3 entries)
Del0 = all(data(:,:) == 0,2);

DelSpacing = zeros(length(data), 1);
i = 1;
while i < length(data)
    if all(data(i,:) == -0.00100000000000000,2)
        DelSpacing(i:i+2) = [1; 1; 1];
        i = i + 4;
    else
        i = i + 1;
    end
end

Del = Del0 | DelSpacing;
data(Del,:) = [];

%Removing data from cycle before start of data collection
data = data(512:end,:);

%Adding in rows removed where 1 is a repeat
last = length(data);

for i = 2:1:last
    if data(i-1,3)- data(i,3) == 510 && data(i,3) ~= 1
        data = [data(1:i-1,:); [0,0,-0.001]; data(i:length(data),:)];
        last = last + 1;
    end
end

%Changing glitched entries
%{
for i=1:1:length(data)-2
    if data(i,1)==data(i+1,1) && data(i,2)==data(i+1,2) && data(i,3)==data(i+1,3) && data(i+2,3)-data(i,3)==1
        data(i+1,:)=data(i+2,:);
    end
    if data(i,3)==data(i+1,3)
       if data(i,1)~=data(i+1,1) || data(i,2)~=data(i+1,2)
           data(i+1,3)=data(i+1,3)+1;
       end
   end
end
%}

end


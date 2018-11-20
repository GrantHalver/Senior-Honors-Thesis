%Deleting spacing
Del0 = all(F3_fixed(:,:) == 0,2);
DelSpacing = all(F3_fixed(:,:) == -0.00100000000000000,2);
Del = Del0 | DelSpacing;
F3_fixed(Del,:) = [];

%Removing data from cycle before start of data collection
%Will need to be changed for every new data set
F3_fixed = F3_fixed(512:265226,:);

%Adding in rows removed where 1 is a repeat
last = length(F3_fixed);

for i = 2:1:last
    if F3_fixed(i-1,3)- F3_fixed(i,3) == 510 && F3_fixed(i,3) ~= 1
        F3_fixed = [F3_fixed(1:i-1,:); [0,0,-0.001]; F3_fixed(i:length(F3_fixed),:)];
        last = last + 1;
    end
end

%Changing glitched entries
for i=1:1:length(F3_fixed)-2
    if F3_fixed(i,1)==F3_fixed(i+1,1) && F3_fixed(i,2)==F3_fixed(i+1,2) && F3_fixed(i,3)==F3_fixed(i+1,3) && F3_fixed(i+2,3)-F3_fixed(i,3)==1
        F3_fixed(i+1,:)=F3_fixed(i+2,:);
    end
    if F3_fixed(i,3)==F3_fixed(i+1,3)
       if F3_fixed(i,1)~=F3_fixed(i+1,1) || F3_fixed(i,2)~=F3_fixed(i+1,2)
           F3_fixed(i+1,3)=F3_fixed(i+1,3)+1;
       end
   end
end
%}
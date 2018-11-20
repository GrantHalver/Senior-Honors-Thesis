%Adding Missing Value
F2_fixed = [F2_fixed(1:502641,:);[0,0,1];F2_fixed(502642:end,:)];
F2_fixed = [F2_fixed(1:51501,:);[0,0,1];F2_fixed(51502:end,:)];

%Deleting spacing
Del0 = all(F2_fixed(:,:) == 0,2);
DelSpacing = all(F2_fixed(:,:) == -0.00100000000000000,2);
Del = Del0 | DelSpacing;
F2_fixed(Del,:) = [];

%Removing data from cycle before start of data collection
%Will need to be changed for every new data set
F2_fixed = F2_fixed(512:265226,:);

%Adding in rows removed where 1 is a repeat
last = length(F2_fixed);

for i = 2:1:last
    if F2_fixed(i-1,3)- F2_fixed(i,3) == 510 && F2_fixed(i,3) ~= 1
        F2_fixed = [F2_fixed(1:i-1,:); [0,0,-0.001]; F2_fixed(i:length(F2_fixed),:)];
        last = last + 1;
    end
end

%Changing glitched entries
for i=1:1:length(F2_fixed)-2
    if F2_fixed(i,1)==F2_fixed(i+1,1) && F2_fixed(i,2)==F2_fixed(i+1,2) && F2_fixed(i,3)==F2_fixed(i+1,3) && F2_fixed(i+2,3)-F2_fixed(i,3)==1
        F2_fixed(i+1,:)=F2_fixed(i+2,:);
    end
    if F2_fixed(i,3)==F2_fixed(i+1,3)
       if F2_fixed(i,1)~=F2_fixed(i+1,1) || F2_fixed(i,2)~=F2_fixed(i+1,2)
           F2_fixed(i+1,3)=F2_fixed(i+1,3)+1;
       end
   end
end
%}
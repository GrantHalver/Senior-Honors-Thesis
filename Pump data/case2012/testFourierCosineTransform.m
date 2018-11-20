clear;
%Loading variables
load('Fdata2_first.mat');
F2_fixed = F2;

%Adding missing element before recording starts in a cycle
F2_fixed = [F2_fixed(1:42747,:); [0,0,2]; F2_fixed(42748:end,:)];

run('datacleaner');

%Detecting repeat data
repeat = zeros(length(F2_fixed),1);
repeat(1,1)=1;
for i = 2:1:length(F2_fixed)
    if diff(F2_fixed(i-1:i,3)) == 0
        repeat(i,1)=1;
    elseif isequal(F2_fixed(i,1:2), [0,0])
            repeat(i,1)=1;
    elseif F2_fixed(i,3) == -0.001
            repeat(i,1)=1;
    end
end
data = F2_fixed;

%Making matrix for DCT
numberFFT = floor(length(data)/512);
data(1:512*numberFFT,:);
repeat(1:512*numberFFT,:);
dataT = [];
repeat1 = [];
for i = 1:numberFFT
   dataT = [dataT; transpose(data(i*512-511:i*512,1:2))];
   repeat1 = [repeat1; transpose(repeat(i*512-511:i*512,:))];
end
data1 = [];
data2 = [];
for i = 1:2:length(dataT)-1
    data1 = [data1; dataT(i,:)];
    data2 = [data2; dataT(i+1,:)];
end



%Creating DCT
Y1 = dct(data1(:,:),[],2);
Y2 = dct(data2(:,:),[],2);

Y1inv = Y1;
Y1inv(:, 491:512) = zeros(length(Y1), 22);
Y2inv = Y2;
Y2inv(:, 491:512) = zeros(length(Y2), 22);

Y1inv = idct(Y1inv,[],2);
Y2inv = idct(Y2inv,[],2);

%Replacing values
for i = 1:length(data1)
    for j = 1:512
       if repeat1(i,j) == 1
           data1(i,j) = Y1inv(i,j);
           data2(i,j) = Y2inv(i,j);
       end
    end
end

%Reformatting data to orignial format
replace = [];
for i = 1:length(data1)
    replace = [replace; transpose(data1(i,:)) transpose(data2(i,:)) transpose(1:512)];
end

%Plotting the resulting DCT
%{
subplot(2,1,1);
plot(1:512, Y(:,1), 'b', 1:512, Yinv(:,1), 'r');
legend({'dct', 'idct'}, 'location', 'northeast');

subplot(2,1,2);
plot(1:50, Y(1:50,1), 'b', 1:50, Yinv(1:50,1), 'r');
%}
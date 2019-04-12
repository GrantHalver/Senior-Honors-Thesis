function [] = plotByFreq3D(data)
%plotByFreq3d Plots magnitude of frequency over time in 3D
%   X-axis is time, Y-axis is freq, Z-axis is magnitude

data(:, 4) = ceil((1:length(data))/512);

subplot(1, 2, 1);
plot3(data(:, 4), data(:, 3), data(:, 1));
xlabel('Time');
ylabel('Frequency');
zlabel('Magnitude');
title('Sensor 1');
axis([0 510 0 510 0 0.02]);

subplot(1, 2, 2);
plot3(data(:, 4), data(:, 3), data(:, 2));
xlabel('Time');
ylabel('Frequency');
zlabel('Magnitude');
title('Sensor 2');
axis([0 510 0 510 0 0.02]);
 %{
grid on
az = 0;
el = 90;
view([az,el])

degStep = 5;
detlaT = 0.1;
fCount = 71;
f = getframe(gcf);
[im,map] = rgb2ind(f.cdata,256,'nodither');
im(1,1,1,fCount) = 0;
k = 1;
% spin 45°
for i = 0:-degStep:-45
  az = i;
  ([az,el])
  f = getframe;
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% tilt down
for i = 90:-degStep:15
  el = i;
  view([az,el])
  f = getframe;
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% spin left
for i = az:-degStep:-90
  az = i;
  view([az,el])
  f = getframe;
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% spin right
for i = az:degStep:0
  az = i;
  view([az,el])
  f = getframe;
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
% tilt up to original
for i = el:degStep:90
  el = i;
  view([az,el])
  f = getframe;
  im(:,:,1,k) = rgb2ind(f.cdata,map,'nodither');
  k = k + 1;
end
imwrite(im,map,'Animation.gif','DelayTime',detlaT,'LoopCount',inf)
%}
end


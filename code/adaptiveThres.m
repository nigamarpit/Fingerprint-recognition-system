function [o] = adaptiveThres(a,W,noShow);
%Adaptive thresholding is performed by segmenting image a

[w,h] = size(a);
o = zeros(w,h);

%seperate it to W block
%step to w with step length W

for i=1:W:w
for j=1:W:h
mean_thres = 0;

%white is ridge -> large

if i+W-1 <= w & j+W-1 <= h
   	mean_thres = mean2(a(i:i+W-1,j:j+W-1));
   	%threshold value is choosed
      mean_thres = 0.8*mean_thres;
      %before binarization
      %ridges are black, small intensity value -> 1 (white ridge)
      %the background and valleys are white, large intensity value -> 0(black)
      o(i:i+W-1,j:j+W-1) = a(i:i+W-1,j:j+W-1) < mean_thres;
end;
   
end;
end;


if nargin == 2
imagesc(o);
colormap(gray);
end;

function [roiImg,roiBound,roiArea] = drawROI(in,inBound,inArea,noShow)
%  drawROI(grayLevelFingerprintImage,ROIboundMap,ROIareaMap,flagToDisableGUI)
%  construct a ROI rectangle for the input fingerprint image and return the 
%  segmented fingerprint
%  With the assumption that only one ROI region for each fingerprint image

[iw,ih]=size(in);
tmplate = zeros(iw,ih);
[w,h] = size(inArea);
tmp=zeros(iw,ih);
%ceil(iw/16) should = w
%ceil(ih/16) should = h

left = 1;
right = h;
upper = 1;
bottom = w;

le2ri = sum(inBound);
roiColumn = find(le2ri>0);
left = min(roiColumn);
right = max(roiColumn);

tr_bound = inBound';

up2dw=sum(tr_bound);
roiRow = find(up2dw>0);
upper = min(roiRow);
bottom = max(roiRow);

%cut out the ROI region image

%show background,bound,innerArea with different gray intensity:0,100,200

for i = upper:1:bottom
   for j = left:1:right
      if inBound(i,j) == 1
         tmplate(16*i-15:16*i,16*j-15:16*j) = 200;
         tmp(16*i-15:16*i,16*j-15:16*j) = 1;
         
      elseif inArea(i,j) == 1 & inBound(i,j) ~=1
         tmplate(16*i-15:16*i,16*j-15:16*j) = 100;
         tmp(16*i-15:16*i,16*j-15:16*j) = 1;
         
      end;
   end;
end;

in=in.*tmp;



roiImg = in(16*upper-15:16*bottom,16*left-15:16*right);

roiBound = inBound(upper:bottom,left:right);
roiArea = inArea(upper:bottom,left:right);


        
%inner area
roiArea = im2double(roiArea) - im2double(roiBound);

if nargin == 3
	colormap(gray);
   imagesc(tmplate);
end;



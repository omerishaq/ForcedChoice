function [ peakimg ] = findpeaks2D( img, kernelsize, strictpeak )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%   img - img to be analyzed
%   kernelsize - neighborhood size in which a peak should be a local
%   maximum
%   strictpeak - if 1 then all neighbors should be strictly less and is
%   zero then they can either be equal or lesser

[sy, sx] = size(img);
peakimg = zeros(sy,sx);

systart = double(kernelsize)/2+0.5; systart = int32(systart);
systop = double(kernelsize)/2-0.5; systop = sy - int32(systop);
sxstart = double(kernelsize)/2+0.5; sxstart = int32(sxstart);
sxstop = double(kernelsize)/2-0.5; sxstop = sx - int32(sxstop);
offset = int32(double(kernelsize)/2-0.5);

for y = systart : systop 
%   disp(y);
    for x = sxstart : sxstop
        if img(y,x) > 75
            test = 1;
        end
        comparevalue = img(y,x);
        compareregion = img(y-offset: y+offset, x-offset: x+offset);
        compareregion(ceil(kernelsize/2), ceil(kernelsize/2)) = 0;
        [greaterIndices] = find(compareregion > comparevalue);
        if isempty(greaterIndices)
        	[equalIndices] = find(compareregion == comparevalue);
            if isempty(equalIndices)
                peakimg(y,x) = 1;
            elseif strictpeak == 0
                peakimg(y,x) = 1;
            end
        end 
        
    end
end

end


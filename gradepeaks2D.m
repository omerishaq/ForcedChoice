function [ gradeimg ] = gradepeaks2D( img, imgpeaks, kernelsizemin, kernelsizemax )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
%   img - img to be analyzed
%   imgpeaks - image with identified peak locations
%   kernelsizemin - size of the minimum gaussian peak
%   kernelsizemax - size of the maximum gaussian peak

[sy, sx] = size(img);
[R, C] = find(imgpeaks == 1);

kernelsizes = kernelsizemin:2:kernelsizemax;
gradeimg = zeros(sy,sx,length(kernelsizes));
load gaussian.mat

for i = 1:length(R)
    
    y = R(i);
    x = C(i);
    if rem(i,100) == 0
        disp([num2str(i) '/' num2str(length(R))]);
    end
    
    for k = 1:length(kernelsizes)

        offset = int32(double(kernelsizes(k))/2-0.5);
        
        try
            compareregion = double(img(y-offset: y+offset, x-offset: x+offset));
            normconstant = sum(compareregion(:));
            compareregion = compareregion./normconstant;
            compareregion = compareregion*100;
            
%             ReferenceData = [randn(50000,1) randn(50000,1)]; % Generate reference data.
%             AbsReferenceData = abs(ReferenceData);
%             [Rows, Cols] = find(AbsReferenceData > 3);
%             counter = 1; newdata = [];
%             for a = 1:size(ReferenceData, 1)
%                 if ~ismember(a, Rows)
%                     newdata = [newdata; ReferenceData(counter,:)];
%                     counter = counter + 1;
%                 end
%             end

            NormalDistribution = hist3(newdata, [kernelsizes(k) kernelsizes(k)]);
            normconstant = sum(NormalDistribution(:));
            NormalDistribution = NormalDistribution./normconstant;
            NormalDistribution = NormalDistribution*100;
            
            Diff = NormalDistribution - compareregion;
            Diff = Diff.^2;
%             Normalization = NormalDistribution + compareregion + 0.0001;
%             Diff = Diff./Normalization;
            gradeimg(y,x,k) = sum(Diff(:));
        catch
            gradeimg(y,x,:) = 1e15;
            break
        end
    
    end
    
end

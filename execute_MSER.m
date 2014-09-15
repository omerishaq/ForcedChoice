clear all
close all

str_imgname = 'slow_20ms_15msexp0000.png';
str_imgfile = 'C:\Users\Omer\Desktop\2AFC Temporary\slow_20ms_15msexp0000.png';
str_csvfile = 'C:\Users\Omer\Desktop\2AFC Temporary\slow_20ms_15msexp0000.csv';

csv_data = csvread(str_csvfile, 1, 0);
img_data = imread(str_imgfile);
res_data = load('Results.mat')


%%% code which will go into a function for creating the bins.
% first find all records which have the same img name.
logicalIndexOfElement = arrayfun(@(x)all(strcmp(x.img,str_imgname)),res_data.Records);
[Indices] = find(logicalIndexOfElement);
Data = res_data.Records(Indices);

[TPlist, TNlist] = create_TP_TN(Data);

VALS = [];

img_data = imfilter(img_data, fspecial('gaussian',[7 7], 1), 'replicate');

for thresholdl = 10:-0.1:0.1
    
    regions = detectMSERFeatures(img_data,'RegionAreaRange',[3 100],'ThresholdDelta',thresholdl,'MaxAreaVariation',1);
    imagesc(img_data); hold on;
    plot(regions);
    
    for i = 1:length(regions)
        STATS(i).Centroid = regions(i).Location;
    end
    
    if ~exist('STATS','var')
        STATS = [];
    end
    
    [TPR, FPR, PR] = calculate_TPR_FPR_PR(STATS, TPlist, TNlist);
    
    clear STATS
    
    VALS = [VALS; thresholdl TPR FPR PR];
    disp([num2str(thresholdl) ' ... ' num2str(TPR) ' ... ' num2str(FPR) ' ... ' num2str(PR)]);
    
end

save mser_00.mat VALS
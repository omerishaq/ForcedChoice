% create the tests for the tophat filtering example

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

for thresholdl = .3:-0.01:0
    
    I9 = imtophat(img_data, strel('disk', 9));
    BW9 = im2bw(I9,thresholdl);
    D9 = -bwdist(~BW9);
    D9(~BW9) = -Inf;
    L9 = watershed(D9);
    STATS9 = regionprops(L9, 'centroid');
    if length(STATS9) == 1
        STATS9 = [];
    end
    
    I7 = imtophat(img_data, strel('disk', 7));
    BW7 = im2bw(I7,thresholdl);
    D7 = -bwdist(~BW7);
    D7(~BW7) = -Inf;
    L7 = watershed(D7);
    STATS7 = regionprops(L7, 'centroid');
    if length(STATS7) == 1
        STATS7 = [];
    end
    
    I5 = imtophat(img_data, strel('disk', 5));
    BW5 = im2bw(I5,thresholdl);
    D5 = -bwdist(~BW5);
    D5(~BW5) = -Inf;
    L5 = watershed(D5);
    STATS5 = regionprops(L5, 'centroid');
    if length(STATS5) == 1
        STATS5 = [];
    end
    
    STATS = [STATS5; STATS7; STATS9];
    
%     imagesc(BW)
%     D = -bwdist(~BW);
%     D(~BW) = -Inf;
%     L = watershed(D);
%     imshow(label2rgb(L,'jet','w'))
%     STATS = regionprops(L, 'centroid');
    
    [TPR, FPR, PR] = calculate_TPR_FPR_PR(STATS, TPlist, TNlist);
    
    VALS = [VALS; thresholdl TPR FPR PR];
    disp([num2str(thresholdl) ' ... ' num2str(TPR) ' ... ' num2str(FPR) ' ... ' num2str(PR)]);
    
end

save th_00.mat VALS





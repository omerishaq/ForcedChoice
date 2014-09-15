% create the tests for the log filtering example

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
img_data = conv2(img_data, fspecial('gaussian',9,1.2));

for thresholdl = 1:-0.001:0
    
    I9 = conv2(img_data, fspecial('log',11,1.5));
    I9 = (-1*I9);
    I9 = uint16(I9);
    BW9 = im2bw(I9,thresholdl);
    BW9 = uint16(BW9);
    I9 = I9.*BW9;
    L9 = imregionalmax(I9);
    cc = bwconncomp(L9);
    STATS9 = regionprops(cc, 'centroid');
    if length(STATS9) == 1
        STATS9 = [];
    end
    
    I7 = conv2(img_data, fspecial('log',11,1.2));
    I7 = (-1*I7);
    I7 = uint16(I7);
    BW7 = im2bw(I7,thresholdl);
    BW7 = uint16(BW7);
    I7 = I7.*BW7;
    L7 = imregionalmax(I7);
    cc = bwconncomp(L7);
    STATS7 = regionprops(L7, 'centroid');
    if length(STATS7) == 1
        STATS7 = [];
    end
    
    I5 = conv2(img_data, fspecial('log',11,0.9));
    I5 = (-1*I5);
    I5 = uint16(I5);
    BW5 = im2bw(I5,thresholdl);
    BW5 = uint16(BW5);
    I5 = I5.*BW5;
    L5 = imregionalmax(I5);
    cc = bwconncomp(L5);
    STATS5 = regionprops(L5, 'centroid');
    if length(STATS5) == 1
        STATS5 = [];
    end
    
    STATS = [STATS5; STATS7; STATS9];
    
    [TPR, FPR, PR] = calculate_TPR_FPR_PR(STATS, TPlist, TNlist);
    
    VALS = [VALS; thresholdl TPR FPR PR];
    disp([num2str(thresholdl) ' ... ' num2str(TPR) ' ... ' num2str(FPR) ' ... ' num2str(PR)]);
    
end

%%
% code for plotting STATS
figure; hold on;

%%
for i = 1:length(STATS);
    data = STATS(i).Centroid;
    plot(data(1), data(2), '+r');
end

%%
for i = 1:length(TPlist);
    plot(TPlist(i).c, TPlist(i).r, '+b');
end

save log_00.mat VALS
% This is a script for generating tiling windows for the project that I am
% currently working on

str_imgfile = 'C:\Users\Omer\Desktop\2AFC Temporary\slow_20ms_15msexp0000.png';
str_csvfile = 'C:\Users\Omer\Desktop\2AFC Temporary\slow_20ms_15msexp0000.csv';

grid_cols = 8;
grid_spacing = 5;
peak_ratio = .85;
spotsize = 9;

csv_data = csvread(str_csvfile, 1, 0);
img_data = imread(str_imgfile);

% sort on photon count in descending order.
csv_data = sortrows(csv_data, 4) 
csv_data = flipud(csv_data);

% divide the csv file into spots which belong to the peak and the bkgd
num_datapoints = size(csv_data,1);
num_peaks = floor(peak_ratio * num_datapoints);

csv_data_peak = csv_data(1:num_peaks, :);
csv_data_bkgd = csv_data(num_peaks+1:end, :);

% load the order information
order = load('order0000.mat');
order = order.ImageData(:,2);

% first plot the foreground spots.
num_rows = ceil(num_peaks/grid_cols);
Image = [];
counter = 1;
for i = 1:num_rows;
    
    Row = zeros(spotsize, spotsize*grid_cols + grid_spacing*(grid_cols-1));
    for j = 1:grid_cols
        
        patch = img_data(round(csv_data_peak(order(counter),2))-4:round(csv_data_peak(order(counter),2))+4, round(csv_data_peak(order(counter),1))-4:round(csv_data_peak(order(counter),1))+4);
        Row(:,((j-1)*spotsize)+((j-1)*grid_spacing)+1:  ((j-1)*spotsize)+((j-1)*grid_spacing)+spotsize) = patch;
%         imagesc(Row); axis image;
        counter = counter + 1;
        
        if counter >= num_peaks; break; end;
        
    end
    Image = [Image; Row];
    Image = [Image; zeros(grid_spacing, spotsize*grid_cols + grid_spacing*(grid_cols-1))];
    
end

% Insert vertical spacing
Image = [Image; zeros(grid_spacing*2, spotsize*grid_cols + grid_spacing*(grid_cols-1))];    
imagesc(Image); axis image;

% now plot the background spots
num_peaks = size(csv_data_bkgd, 1);
num_rows = ceil(num_peaks/grid_cols);
counter = 1;
for i = 1:num_rows;
    
    Row = zeros(spotsize, spotsize*grid_cols + grid_spacing*(grid_cols-1));
    for j = 1:grid_cols
        
        patch = img_data(round(csv_data_bkgd(counter,2))-4:round(csv_data_bkgd(counter,2))+4, round(csv_data_bkgd(counter,1))-4:round(csv_data_bkgd(counter,1))+4);
        Row(:,((j-1)*spotsize)+((j-1)*grid_spacing)+1:  ((j-1)*spotsize)+((j-1)*grid_spacing)+spotsize) = patch;
%         imagesc(Row); axis image;
        counter = counter + 1;
        
        if counter >= num_peaks; break; end;
        
    end
    Image = [Image; Row];
    Image = [Image; zeros(grid_spacing, spotsize*grid_cols + grid_spacing*(grid_cols-1))];
    
end

Image = [Image; zeros(grid_spacing-4, spotsize*grid_cols + grid_spacing*(grid_cols-1))];    
imagesc(Image); axis image;




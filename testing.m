
I2 = imtophat(I, strel('disk', 7));
BW = im2bw(I2,0.10);
imagesc(BW)
D = -bwdist(~BW);
D(~BW) = -Inf;
L = watershed(D);
imshow(label2rgb(L,'jet','w'))
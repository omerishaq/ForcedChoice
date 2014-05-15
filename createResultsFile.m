% Script to generate the inital Results.mat file

clear all
close all

str_filename = 'Results.mat';

if exist(str_filename, 'file')
    delete(str_filename);
else
    Records.peak    = 0;
    Records.r       = 0;
    Records.c       = 0;
    Records.user    = 'test user';
    Records.img     = 'test user';
end

save Results.mat Records


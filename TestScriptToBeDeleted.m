% test script
% only a test script created to tweak the record insertion into the
% Results.m file.
% To be deleted if the insertion is proceeding well.

clear all
close all

str_resultsfilename = 'Results.mat';

struct_record.peak = rand;
struct_record.r = 0;
struct_record.c = 0;
struct_record.user = 'test';
struct_record.img = 'test';

Records = load(str_resultsfilename);
Records = Records.Records;
ilength = length(Records);
Records(ilength + 1).peak = struct_record.peak;
Records(ilength + 1).r = struct_record.r;
Records(ilength + 1).c = struct_record.c;
Records(ilength + 1).user = struct_record.user;
Records(ilength + 1).img = struct_record.img;
save(str_resultsfilename, 'Records');
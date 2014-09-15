%% plot information

clear all
close all

data_tophat = load('th_00.mat');
data_log = load('log_00.mat');
data_mser = load('mser_00.mat');
data_four = load('other_00.mat');

figure; hold on;
plot(log10(data_tophat.VALS(1:end-5,3)), data_tophat.VALS(1:end-5,2), '-r');
plot(log10(data_four.VALS(1:end-8,3)), data_four.VALS(1:end-8,2), '-b');
plot(log10(data_log.VALS(:,3)), data_log.VALS(:,2), '-m');
plot(log10(data_mser.VALS(:,3)), data_mser.VALS(:,2), '-k');
ylabel('True Positive Rate');
xlabel('False Positive Rate');
legend('Top hat','Wavelet filtering','LOG','MSER','Location','SouthEast');

figure; hold on;
plot(data_tophat.VALS(1:end-5,2), data_tophat.VALS(1:end-5,4), '-r');
plot(data_four.VALS(1:end-8,2), data_four.VALS(1:end-8,4), '-b');
plot(data_log.VALS(:,2), data_log.VALS(:,4), '-m');
plot(data_mser.VALS(:,2), data_mser.VALS(:,4), '-k');
ylabel('Precision');
xlabel('True Positive Rate');
legend('Top hat','Wavelet filtering','LOG','MSER','Location','SouthWest');
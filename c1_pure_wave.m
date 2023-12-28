% function xs_all = c1_pure_wave( )

clc;
close all;
clear all;

t = 0:0.0001:0.2;
x = @(t) sin(2*pi*50*t); % Generated Signal


% Add 20 dB Gaussian noise to the signal
SNR = 20; % Signal-to-noise ratio in dB
x_20 = awgn(x(t), SNR, 'measured');

%% Visulalisation
% % Plotting the original signal and the noisy signal
% figure;
% subplot(2,1,1);
% plot(t, x(t));
% title('Original Signal');
% xlabel('Time');
% ylabel('Amplitude');
% 
% subplot(2,1,2);
% plot(t, x_20);
% title('Signal with 20 dB Gaussian Noise');
% xlabel('Time');
% ylabel('Amplitude');

%% Sampling
num_repetitions = 200;
fs = 16000 - 1;
ts = 0:1/fs:0.2;

xs_all = zeros(num_repetitions, length(ts));
x_20_all = zeros(num_repetitions, length(ts));

for i = 1:num_repetitions
    xs = x(ts);
    x_20 = awgn(xs, SNR, 'measured');
    xs_all(i, :) = xs;
    x_20_all(i,:) = x_20;
end

% csvwrite('dataset1.csv', xs_all);
csvwrite('dataset1_20db.csv', x_20_all);
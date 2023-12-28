% function xs = c10_flicker( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;

for lamda=0.05:0.004:0.1
    for fn=8:1:25

        x=@(t) (1 + lamda* sin(2*pi*fn*t)).*sin(2*pi*50*t); %% Generated Signal
        flag=flag+1;

        % Add 20 dB Gaussian noise to the signal
        SNR = 20; % Signal-to-noise ratio in dB
        x_20 = awgn(x(t), SNR, 'measured');

        %      visualisation
%         if flag > 0 && flag < 20
%             figure(flag)
%             %             plot(t,x(t));
%             %             plot(t,x_20);
%             hold on;
%         end

        %sampling
        fs=16000-1;
        ts=0:1/fs:0.2;
        xs_temp(flag,:)=x(ts);
        xs_temp_20(flag,:) = awgn(x(ts), SNR, 'measured');

    end
end

xs=xs_temp(1:200,:);
xs_20 = xs_temp_20(1:200,:);

% shuffling dataset
% Get the number of rows in the matrix
numRows = size(xs, 1);

% Generate a random permutation of row indices
shuffledIndices = randperm(numRows);

% Shuffle the rows of the matrix based on the shuffled indices
xs = xs(shuffledIndices, :);
xs_20 = xs_20(shuffledIndices, :);


csvwrite('dataset10_20db.csv', xs_20);
% csvwrite("dataset10.csv",xs);

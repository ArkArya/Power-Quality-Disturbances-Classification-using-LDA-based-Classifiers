% function xs = c7_harmonics( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;

for alpha3=0.05:0.03:0.15
    for alpha5=0.05:0.04:0.15
        for alpha7=0.05:0.05:0.15
            for vn=-180:60:180

                x=@(t) (sin(2*pi*50*t) + alpha3*sin(3*2*pi*50*t-vn) + alpha5*sin(5*2*pi*50*t-vn) + alpha7*sin(7*2*pi*50*t-vn)); %% Generated Signal
                flag=flag+1;

                % Add 20 dB Gaussian noise to the signal
                SNR = 20; % Signal-to-noise ratio in dB
                x_20 = awgn(x(t), SNR, 'measured');

                % Visualization
%                 if flag > 100 && flag < 120
%                     figure(flag)
%                     plot(t,x(t));
%                     plot(t,x_20)
%                     hold on;
%                 end

                %sampling
                fs=16000-1;
                ts=0:1/fs:0.2;
                xs_temp(flag,:)=x(ts);
                xs_temp_20(flag,:) = awgn(x(ts), SNR, 'measured');

            end
        end
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


csvwrite('dataset7_20db.csv', xs_20);
% csvwrite('dataset7.csv', xs);


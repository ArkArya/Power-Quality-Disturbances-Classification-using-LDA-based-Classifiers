% function xs = c6_oscillatory_transient( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;

for v=-180:60:180
    for tao=0.008:0.01:0.04
        for beta=0.222:0.3:1.11
            for fn=300:300:900
                for t1=0:0.03:0.2

                    t2=t1+0.02;
                    x=@(t) sin(2*50*pi*t) + beta*(exp(-(t-t1)/tao)).*sin(2*fn*pi*(t-t1)-v).*(heaviside(t-t2)-heaviside(t-t1)); %% Generated Signal
                    flag=flag+1;

                    % Add 20 dB Gaussian noise to the signal
                    SNR = 20; % Signal-to-noise ratio in dB
                    x_20 = awgn(x(t), SNR, 'measured');

                    % Visualization
%                     if flag > 150 && flag < 170
%                         figure(flag)
%                         plot(t,x(t));
%                         plot(t,x_20)
%                         hold on;
%                     end

                    %sampling
                    fs=16000-1;
                    ts=0:1/fs:0.2;
                    xs_temp(flag,:)=x(ts);
                    xs_temp_20(flag,:) = awgn(x(ts), SNR, 'measured');

                end
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


csvwrite('dataset6_20db.csv', xs_20);
% csvwrite('dataset6.csv', xs);


% function xs = c2_sag( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;

for alpha=0.1:0.2:0.9
    for t1=0:0.01:0.15
        for k=0.01:0.02:0.06

            t2=t1+k;
            x=@(t) (1-alpha*((heaviside(t-t1)-heaviside(t-t2)))).*sin(2*pi*50*t); %% Generated Signal
            flag=flag+1;

            % Add 20 dB Gaussian noise to the signal
            SNR = 20; % Signal-to-noise ratio in dB
            x_20 = awgn(x(t), SNR, 'measured');

%             % Visualization
%             if flag > 50 && flag < 70
%                 figure(flag)
% %                 plot(t,x(t));
%                   plot(t,x_20);
%                 hold on;
%             end

            %sampling
            fs=16000-1;
            ts=0:1/fs:0.2;
            xs_temp(flag,:)=x(ts);
            xs_temp_20(flag,:) = awgn(x(ts), SNR, 'measured');

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

% csvwrite('dataset2.csv', xs);
csvwrite('dataset2_20db.csv', xs_20);



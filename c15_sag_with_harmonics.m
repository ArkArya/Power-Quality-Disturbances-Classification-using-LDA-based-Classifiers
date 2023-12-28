% function xs = c15_sag_with_harmonics( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;
alpha1 = 1;
% alpha = 0.7;

for vn=-180:180:180
    for alpha=0.1:0.4:0.9
        for t1=0:0.03:0.15
            for k=0.03:0.01:0.06
                for alpha3=0.05:0.03:0.15
                    for alpha5=0.05:0.03:0.15

                        t2=t1+k;

                        x=@(t) sin(2*pi*50*t) + (-alpha*(heaviside(t-t1)-heaviside(t-t2))).*(alpha1*sin(1*2*pi*50*t-vn) + alpha3*sin(3*2*pi*50*t-vn) + alpha5*sin(5*2*pi*50*t-vn)); %% Generated Signal
                        flag = flag + 1;
                        
                         % Add 20 dB Gaussian noise to the signal
                            SNR = 20; % Signal-to-noise ratio in dB
                            x_20 = awgn(x(t), SNR, 'measured');

%                         % % visualisation
%                         if flag > 2001 && flag < 2050
%                             figure(flag)
%                             plot(t,x(t));
%                             plot(t,x_20);
%                             hold on;
%                         end

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
end

xs=xs_temp(2001:2200,:);
xs_20 = xs_temp_20(2001:2200,:);

% shuffling dataset
% Get the number of rows in the matrix
numRows = size(xs, 1);

% Generate a random permutation of row indices
shuffledIndices = randperm(numRows);

% Shuffle the rows of the matrix based on the shuffled indices
xs = xs(shuffledIndices, :);
xs_20 = xs_20(shuffledIndices, :);


csvwrite('dataset15_20db.csv', xs_20);
% csvwrite("dataset15.csv",xs);

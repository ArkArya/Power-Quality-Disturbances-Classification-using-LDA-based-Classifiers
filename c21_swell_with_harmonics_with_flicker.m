% function xs = c21_swell_with_harmonics_with_flicker( )

clc;
clear;
close all;

flag=0;
t=0:0.0001:.2;
alpha = 0.3;
alpha1 = 1;
k = 0.05;

for vn=-180:180:180
    for t1=0:0.05:0.15
        for alpha3=0.05:0.05:0.15
            for alpha5=0.05:0.05:0.15
                for lamda=0.05:0.01:0.1
                    for fn=8:4:25

                        t2=t1+k;

                        x=@(t) sin(2*pi*50*t) + (1 + lamda* sin(2*pi*fn*t)) .* (alpha1*sin(1*2*pi*50*t-vn) + alpha3*sin(3*2*pi*50*t-vn) + alpha5*sin(5*2*pi*50*t-vn)) .* ( alpha *(heaviside(t-t1)-heaviside(t-t2))); %% Generated Signal
                        flag = flag + 1;

                        % Add 20 dB Gaussian noise to the signal
                        SNR = 20; % Signal-to-noise ratio in dB
                        x_20 = awgn(x(t), SNR, 'measured');

                        % % visualisation
%                         if flag > 1201 && flag < 1250
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

xs = xs_temp(1201:1250,:);
xs = [xs; xs_temp(1501:1550,:)];
xs = [xs; xs_temp(1801:1850,:)];
xs = [xs; xs_temp(2001:2050,:)];

xs_20 = xs_temp_20(1201:1250,:);
xs_20 = [xs_20; xs_temp_20(1501:1550,:)];
xs_20 = [xs_20; xs_temp_20(1801:1850,:)];
xs_20 = [xs_20; xs_temp_20(2001:2050,:)];


% shuffling dataset
% Get the number of rows in the matrix
numRows = size(xs, 1);

% Generate a random permutation of row indices
shuffledIndices = randperm(numRows);

% Shuffle the rows of the matrix based on the shuffled indices
xs = xs(shuffledIndices, :);


% csvwrite("dataset21.csv",xs);
csvwrite('dataset21_20db.csv', xs_20);


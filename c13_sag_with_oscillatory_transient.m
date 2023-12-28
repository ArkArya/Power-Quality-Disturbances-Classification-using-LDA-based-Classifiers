% function xs = c13_sag_with_oscillatory_transient( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;
xs = [];


for alpha=0.1:0.4:0.9
    for t1=0:0.05:0.15
        for k=0.02:0.02:0.06
            for v=-180:360:180
                for tao=0.008:0.01:0.04
                    for beta=0.222:0.5:1.11
                        for fn=300:300:900

                            t2=t1+k;

                            x=@(t) sin(2*pi*50*t).*(1 - alpha*(heaviside(t-t1)-heaviside(t-t2))) + beta*(exp(-(t-t1)/tao)).*sin(2*fn*pi*(t-t1)-v).*(heaviside(t-t2)-heaviside(t-t1)); %% Generated Signal
                            flag = flag + 1;


                            % Add 20 dB Gaussian noise to the signal
                            SNR = 20; % Signal-to-noise ratio in dB
                            x_20 = awgn(x(t), SNR, 'measured');

                            % % visualisation
%                             if flag > 801 && flag < 825
%                                 figure(flag)
%                                 plot(t,x(t));
%                                 plot(t,x_20);
%                                 hold on;
%                             end

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
end

xs = xs_temp(1001:1025,:);
xs = [xs; xs_temp(1501:1525,:)];
xs = [xs; xs_temp(801:825,:)];
xs = [xs; xs_temp(701:725,:)];
xs = [xs; xs_temp(1026:1050,:)];
xs = [xs; xs_temp(1526:1550,:)];
xs = [xs; xs_temp(826:850,:)];
xs = [xs; xs_temp(726:750,:)];


xs_20 = xs_temp_20(1001:1025,:);
xs_20 = [xs_20; xs_temp_20(1501:1525,:)];
xs_20 = [xs_20; xs_temp_20(801:825,:)];
xs_20 = [xs_20; xs_temp_20(701:725,:)];
xs_20 = [xs_20; xs_temp_20(1026:1050,:)];
xs_20 = [xs_20; xs_temp_20(1526:1550,:)];
xs_20 = [xs_20; xs_temp_20(826:850,:)];
xs_20 = [xs_20; xs_temp_20(726:750,:)];

% shuffling dataset
% Get the number of rows in the matrix
numRows = size(xs, 1);

% Generate a random permutation of row indices
shuffledIndices = randperm(numRows);

% Shuffle the rows of the matrix based on the shuffled indices
xs = xs(shuffledIndices, :);
xs_20 = xs_20(shuffledIndices, :);


csvwrite('dataset13_20db.csv', xs_20);

% csvwrite("dataset13.csv",xs);

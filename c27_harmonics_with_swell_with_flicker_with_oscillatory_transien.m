% function xs = c27_harmonics_with_swell_with_flicker_with_oscillatory_transient( )

clc;
clear all;
close all;

flag=0;
t=0:0.0001:.2;
alpha1 = 1;
alpha = 0.4;
k = 0.04;
xs = [];
vn = 0;
f_flick = 10;
lamda = 0.1;


for t1=0:0.05:0.15
    for v=-180:360:180
        for tao=0.008:0.01:0.04
            for beta=0.222:0.5:1.11
                for fn=300:300:900
                    for alpha3=0.05:0.05:0.15
                        for alpha5=0.05:0.05:0.15


                            t2=t1+k;

                            x=@(t)  ((1 + alpha*(heaviside(t-t1)-heaviside(t-t2))) .* (alpha1*sin(1*2*pi*50*t-vn) + alpha3*sin(3*2*pi*50*t-vn) + alpha5*sin(5*2*pi*50*t-vn))+ beta*(exp(-(t-t1)/tao)).*sin(2*fn*pi*(t-t1)-v).*(heaviside(t-t2)-heaviside(t-t1))) .* (1 + lamda* sin(2*pi*f_flick*t)); %% Generated Signal
                            flag = flag + 1;

                            % Add 20 dB Gaussian noise to the signal
                            SNR = 20; % Signal-to-noise ratio in dB
                            x_20 = awgn(x(t), SNR, 'measured');

                            % % visualisation
%                             if flag > 1001 && flag < 1050
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


xs = xs_temp(701:750,:);
xs = [xs; xs_temp(201:250,:)];
xs = [xs; xs_temp(1501:1550,:)];
xs = [xs; xs_temp(1001:1050,:)];

xs_20 = xs_temp_20(701:750,:);
xs_20 = [xs_20; xs_temp_20(201:250,:)];
xs_20 = [xs_20; xs_temp_20(1501:1550,:)];
xs_20 = [xs_20; xs_temp_20(1001:1050,:)];


% shuffling dataset
% Get the number of rows in the matrix
numRows = size(xs, 1);

% Generate a random permutation of row indices
shuffledIndices = randperm(numRows);

% Shuffle the rows of the matrix based on the shuffled indices
xs = xs(shuffledIndices, :);


% csvwrite("dataset27.csv",xs);
csvwrite('dataset27_20db.csv', xs_20);

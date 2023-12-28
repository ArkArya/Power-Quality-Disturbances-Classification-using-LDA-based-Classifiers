% function xs = c17_notch( )

clc;
clear;
close all;

flag=0;
t=0:0.0001:.2;

T = 1/50;
c = 6;
N = 10;
% k = 0.1;


% for i=1:1:2
    for k=0.1:0.02:0.4
        for td=0.0002:0.00005:0.0011

%             c_temp = c(i);
%             disp(c_temp);
            s = T/c;
            tc = 0.0001;

                        x = @(t) sin(2*pi*50*t) - sign(sin(2*pi*50*t)) .* ( k*(heaviside(t-(tc+s*20)) - heaviside(t-(td+s*20))) ...
            + k*(heaviside(t-(tc+s*21)) - heaviside(t-(td+s*21)))  + k*(heaviside(t-(tc+s*22)) - heaviside(t-(td+s*22)))...
            + k*(heaviside(t-(tc+s*23)) - heaviside(t-(td+s*23)))  + k*(heaviside(t-(tc+s*24)) - heaviside(t-(td+s*24)))...
            + k*(heaviside(t-(tc+s*25)) - heaviside(t-(td+s*25)))  + k*(heaviside(t-(tc+s*26)) - heaviside(t-(td+s*26))) ...
            + k*(heaviside(t-(tc+s*27)) - heaviside(t-(td+s*27)))  + k*(heaviside(t-(tc+s*28)) - heaviside(t-(td+s*28)))...
            + k*(heaviside(t-(tc+s*29)) - heaviside(t-(td+s*29)))  + k*(heaviside(t-tc) - heaviside(t-td))...
            + k*(heaviside(t-(tc+s*1)) - heaviside(t-(td+s*1)))  + k*(heaviside(t-(tc+s*2)) - heaviside(t-(td+s*2)))... 
            + k*(heaviside(t-(tc+s*3)) - heaviside(t-(td+s*3)))  + k*(heaviside(t-(tc+s*4)) - heaviside(t-(td+s*4)))...
            + k*(heaviside(t-(tc+s*5)) - heaviside(t-(td+s*5)))  + k*(heaviside(t-(tc+s*6)) - heaviside(t-(td+s*6))) ...
            + k*(heaviside(t-(tc+s*7)) - heaviside(t-(td+s*7)))  + k*(heaviside(t-(tc+s*8)) - heaviside(t-(td+s*8)))...
            + k*(heaviside(t-(tc+s*9)) - heaviside(t-(td+s*9)))  + k*(heaviside(t-(tc+s*10)) - heaviside(t-(td+s*10))) ...
            + k*(heaviside(t-(tc+s*11)) - heaviside(t-(td+s*11)))+ k*(heaviside(t-(tc+s*12)) - heaviside(t-(td+s*12))) ...
            + k*(heaviside(t-(tc+s*13)) - heaviside(t-(td+s*13)))+ k*(heaviside(t-(tc+s*14)) - heaviside(t-(td+s*14))) ...
            + k*(heaviside(t-(tc+s*15)) - heaviside(t-(td+s*15)))+ k*(heaviside(t-(tc+s*16)) - heaviside(t-(td+s*16))) ...
            + k*(heaviside(t-(tc+s*17)) - heaviside(t-(td+s*17)))+ k*(heaviside(t-(tc+s*18)) - heaviside(t-(td+s*18))) ...
            + k*(heaviside(t-(tc+s*19)) - heaviside(t-(td+s*19)))+ k*(heaviside(t-(tc+s*30)) - heaviside(t-(td+s*30)))...
            + k*(heaviside(t-(tc+s*31)) - heaviside(t-(td+s*31)))  + k*(heaviside(t-(tc+s*32)) - heaviside(t-(td+s*32)))...
            + k*(heaviside(t-(tc+s*33)) - heaviside(t-(td+s*33)))  + k*(heaviside(t-(tc+s*34)) - heaviside(t-(td+s*34)))...
            + k*(heaviside(t-(tc+s*35)) - heaviside(t-(td+s*35)))  + k*(heaviside(t-(tc+s*36)) - heaviside(t-(td+s*36))) ...
            + k*(heaviside(t-(tc+s*37)) - heaviside(t-(td+s*37)))  + k*(heaviside(t-(tc+s*38)) - heaviside(t-(td+s*38)))...
            + k*(heaviside(t-(tc+s*39)) - heaviside(t-(td+s*39)))  + k*(heaviside(t-(tc+s*40)) - heaviside(t-(td+s*40)))...
            + k*(heaviside(t-(tc+s*41)) - heaviside(t-(td+s*41)))  + k*(heaviside(t-(tc+s*42)) - heaviside(t-(td+s*42)))...
            + k*(heaviside(t-(tc+s*43)) - heaviside(t-(td+s*43)))  + k*(heaviside(t-(tc+s*44)) - heaviside(t-(td+s*44)))...
            + k*(heaviside(t-(tc+s*45)) - heaviside(t-(td+s*45)))  + k*(heaviside(t-(tc+s*46)) - heaviside(t-(td+s*46))) ...
            + k*(heaviside(t-(tc+s*47)) - heaviside(t-(td+s*47)))  + k*(heaviside(t-(tc+s*48)) - heaviside(t-(td+s*48)))...
            + k*(heaviside(t-(tc+s*49)) - heaviside(t-(td+s*49)))+ k*(heaviside(t-(tc+s*50)) - heaviside(t-(td+s*50)))...
            + k*(heaviside(t-(tc+s*51)) - heaviside(t-(td+s*51)))  + k*(heaviside(t-(tc+s*52)) - heaviside(t-(td+s*52)))...
            + k*(heaviside(t-(tc+s*53)) - heaviside(t-(td+s*53)))  + k*(heaviside(t-(tc+s*54)) - heaviside(t-(td+s*54)))...
            + k*(heaviside(t-(tc+s*55)) - heaviside(t-(td+s*55)))  + k*(heaviside(t-(tc+s*56)) - heaviside(t-(td+s*56))) ...
            + k*(heaviside(t-(tc+s*57)) - heaviside(t-(td+s*57)))  + k*(heaviside(t-(tc+s*58)) - heaviside(t-(td+s*58)))...
            + k*(heaviside(t-(tc+s*59)) - heaviside(t-(td+s*59))))  ;
 
                 %% Generated Signal

            flag = flag + 1;

            % Add 20 dB Gaussian noise to the signal
            SNR = 20; % Signal-to-noise ratio in dB
            x_20 = awgn(x(t), SNR, 'measured');

            % % visualisation
%             if flag >0 && flag < 20
%                 figure(flag)
%                 plot(t,x(t));
% %                 plot(t,x_20);
%                 hold on;
%             end

            %sampling
            fs=16000-1;
            ts=0:1/fs:0.2;
            xs_temp(flag,:)=x(ts);
            xs_temp_20(flag,:) = awgn(x(ts), SNR, 'measured');

%              if flag >100 && flag < 150
%                 figure(flag)
% %                 stem(ts, xs_temp(1,:));
% %                 plot(t,x_20);
%                 hold on;
%             end
        end

    end
% end

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


csvwrite('dataset17_20db.csv', xs_20);
% csvwrite("dataset17.csv",xs);
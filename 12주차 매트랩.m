%문제 1번
clear; clc;
%a
x = [21, 22, NaN, 23, 24, 120, 25, NaN, 26, 27];
%b
idx_missing = isnan(x);
%c
mu0 = mean(x,'omitnan');
sig0 = std(x,0,'omitnan');
%d
idx_outlier = ~isnan(x) & (abs(x - mu0) > 3 * sig0);
%e
x_temp  = x;
x_temp(idx_missing | idx_outlier) = NaN;
%f
fill_val = mean(x_temp, 'omitnan');
x_clean = x_temp;
x_clean(isnan(x_clean)) = fill_val;
%g
mu_clean = mean(x_clean);
sig_clean = std(x_clean);

fprintf('mu0=%.4f, sig0=%.4f\n', mu0, sig0);
fprintf('mu_clean=%.4f, sig_clean=%.4f\n', mu_clean, sig_clean);
%h
figure;
plot(x, 'o--');
hold on;
plot(x_clean, 's-');
legend('Original x', 'Cleaned x_clean');
xlabel('Index'); ylabel('Value');
title('Original vs Cleaned Data');
grid on;

%문제 2번
clear; clc;
%a
A = [10 200 0.5;
     12 180 0.7;
     15 220 0.6;
     20 250 0.9;
     25 300 1.1];
%b
colMin = min(A);
colMax = max(A);
%c
A_norm = (A - colMin) ./ (colMax - colMin);
%d
rowMean = mean(A_norm, 2);
%e
[~, idx] = max(rowMean);
%f
bestOriginal    = A(idx, :);
bestNormalized  = A_norm(idx, :);

disp(A_norm);
fprintf('idx=%d\n', idx);
disp(bestOriginal);
disp(bestNormalized);

%문제 3번
clear; clc;
%a
Channel = {'CH1';'CH2';'CH3';'CH4';'CH5';'CH6';'CH7';'CH8'};
Signal  = [18.2; 15.5; 21.0; 11.7; 25.3; 19.4; 28.6; 16.8];
Noise   = [2.1; 3.4; 2.8; 4.2; 3.0; 5.1; 2.9; 3.7];
T = table(Channel, Signal, Noise);
%b
T.SignalToNoise = T.Signal ./ T.Noise;
%c
meanSNR = mean(T.SignalToNoise);
%d
T_high = T(T.SignalToNoise > meanSNR, :);
%e
snrVec = T_high{:, 'SignalToNoise'};
%f
varSNR = var(snrVec);

disp(T);
disp(T_high);
fprintf('meanSNR=%.4f, varSNR=%.4f\n', meanSNR, varSNR);

%문제 4번
clear; clc;
varNames = {'Class','Alcohol','MalicAcid','Ash','Alcalinity',...
            'Magnesium','Phenols','Flavanoids','Nonflavanoid',...
            'Proanthocyanins','ColorIntensity','Hue','OD280','Proline'};
%a
Wine = readtable('wine.data', 'FileType', 'text');
%b
Wine.Properties.VariableNames = varNames;
%c
X = [Wine.Alcohol, Wine.MalicAcid, Wine.ColorIntensity];
%d
X_std = (X - mean(X)) ./ std(X);
%e
normVec = vecnorm(X_std, 2, 2);
%f
cutoff = prctile(normVec, 90);
%g
T_top = Wine(normVec >= cutoff, :);
%h
disp(T_top(:, {'Class','Alcohol','MalicAcid','ColorIntensity'}));

%문제 5번
clear; clc;
%a
rng(42);
y = 50 + 5 * randn(100, 1);
%b
y(10) = 90; y(25) = 95; y(40) = 5; y(70) = 100; y(90) = 0;
%c
Q1 = quantile(y, 0.25);
Q3 = quantile(y, 0.75);
%d
IQR_val = Q3 - Q1;
%e
lower = Q1 - 1.5 * IQR_val;
upper = Q3 + 1.5 * IQR_val;
%f
idx_outlier = y < lower | y > upper;
%g
y_clean = y(~idx_outlier);
med_clean = median(y_clean);

fprintf('Q1=%.4f, Q3=%.4f, IQR=%.4f\n', Q1, Q3, IQR_val);
fprintf('lower=%.4f, upper=%.4f\n', lower, upper);
fprintf('med_clean=%.4f\n', med_clean);

%문제 6번
clear; clc;

%a
Device     = {'D1';'D2';'D3';'D4';'D5';'D6';'D7';'D8';'D9';'D10';'D11';'D12'};
Power      = [110;130;125;160;170;150;190;200;210;180;220;240];
Throughput = [42;50;48;61;65;57;72;75;79;69;83;91];
DeviceData = table(Device, Power, Throughput);

%b
pw = DeviceData.Power;
tp = DeviceData.Throughput;

%c
R = corrcoef(pw, tp);
rValue = R(1, 2);

%d
if rValue >= 0.7
    disp('Strong correlation');
else
    disp('Weak correlation');
end

%e,f
figure;
scatter(pw, tp, 60, 'filled');
xlabel('Power (W)'); ylabel('Throughput');
title('Power vs Throughput');
grid on;
ax = gca;
ax.FontSize = 12;
ax.LineWidth = 1.5;

%문제 7번
clear; clc;
%a
Material = {'A';'A';'A';'A';'B';'B';'B';'B';'C';'C';'C';'C'};
EnergyDensity = [245;252;238;260;310;295;305;318;180;190;176;185];
Battery = table(Material, EnergyDensity);
%b
idxA = strcmp(Battery.Material, 'A');
idxB = strcmp(Battery.Material, 'B');
idxC = strcmp(Battery.Material, 'C');
%c
meanA = mean(Battery.EnergyDensity(idxA));
meanB = mean(Battery.EnergyDensity(idxB));
meanC = mean(Battery.EnergyDensity(idxC));
%d
stdA = std(Battery.EnergyDensity(idxA));
stdB = std(Battery.EnergyDensity(idxB));
stdC = std(Battery.EnergyDensity(idxC));
%e
Summary = table({'A';'B';'C'}, [meanA;meanB;meanC], [stdA;stdB;stdC], ...
    'VariableNames', {'Material','Mean','Std'});
disp(Summary);
%f
G = groupsummary(Battery, 'Material', {'mean','std'}, 'EnergyDensity');
disp(G);

%문제 8번
clear; clc;
%a
Speed = [1.2;1.5;1.7;2.0;2.2;2.4;2.6;2.8;3.0;3.2;3.4;3.6;3.8;4.0;4.2];
Torque = [15;18;21;24;26;29;31;35;38;41;43;47;50;54;58];
SlipRate = [0.08;0.10;0.12;0.15;0.18;0.21;0.22;0.25;0.27;0.30;0.33;0.35;0.39;0.42;0.45];
EnergyUse = [42;48;53;61;66;72;77;85;91;98;105;113;121;130;140];
Robot = table(Speed, Torque, SlipRate, EnergyUse);
%b
X = table2array(Robot);
%c
figure;
plotmatrix(X);
title('Scatter Plot Matrix');
%d
varVec = var(X);
%e
[~, idxMax] = max(varVec);
%f
maxVarName = Robot.Properties.VariableNames{idxMax};
fprintf('최대 분산 변수: %s\n', maxVarName);

%문제 9번
clear; clc;
%a
T = readtable('train.csv');
%b
numMissingAge = sum(ismissing(T.Age));
%c
ageMean = mean(T.Age, 'omitnan');
T.Age(ismissing(T.Age)) = ageMean;
%d
muFare  = mean(T.Fare, 'omitnan');
sigFare = std(T.Fare, 0, 'omitnan');
%e
isOutlier = abs(T.Fare - muFare) > 3 * sigFare;
T_clean = T(~isOutlier, :);
%f,g
meanAge0 = mean(T_clean.Age(T_clean.Survived == 0));
meanAge1 = mean(T_clean.Age(T_clean.Survived == 1));
%h
Result = table([0;1], [meanAge0;meanAge1], ...
    'VariableNames', {'Survived','MeanAge'});
disp(Result);

%문제 10번
clear; clc;
%a
Epoch = (1:8)';
LossA = [2.40;1.95;1.62;1.31;1.05;0.86;0.70;0.58];
LossB = [2.55;2.10;1.80;1.50;1.25;1.03;0.86;0.72];
LossC = [2.70;2.20;1.90;1.63;1.42;1.21;1.05;0.93];
AccA  = [0.42;0.50;0.58;0.64;0.70;0.75;0.79;0.82];
AccB  = [0.40;0.47;0.53;0.60;0.66;0.70;0.74;0.78];
AccC  = [0.38;0.45;0.51;0.57;0.62;0.67;0.70;0.73];
TrainLog = table(Epoch,LossA,LossB,LossC,AccA,AccB,AccC);
%b
figure;
tl = tiledlayout(2, 1);
%c
nexttile;
plot(Epoch, LossA, '-o', Epoch, LossB, '-s', Epoch, LossC, '-^');
legend('LossA','LossB','LossC');
xlabel('Epoch'); ylabel('Loss'); title('Loss Curve'); grid on;
%d
nexttile;
plot(Epoch, AccA, '-o', Epoch, AccB, '-s', Epoch, AccC, '-^');
legend('AccA','AccB','AccC');
xlabel('Epoch'); ylabel('Accuracy'); title('Accuracy Curve'); grid on;
%f
title(tl, 'Training Dashboard');

%문제 11번
clear; clc;
%a
A = [ 3 -1  5 -2  4;
     -4  6 -3  2  1;
      7 -5  8 -1  0;
     -2  4 -6  9  3;
      5 -3  2 -4  6];
%b
A_clean = A;
%c,d
[r, c] = size(A_clean);
for i = 1:r
    for j = 1:c
        if A_clean(i, j) < 0
            A_clean(i, j) = 0;
        end
    end
end
%e
disp('원본 A:'); disp(A);
disp('정제 A_clean:'); disp(A_clean);

%문제 12번
clear; clc;
%a
rng(42);
%b,c
t = (1:120)';
signal = 30 + 4*sin(t/8) + randn(120,1);
%d
signal([15,45,90]) = NaN;
%e
signal(30) = 80; signal(75) = -20; signal(110) = 95;
%f
idxMissing = isnan(signal);
numMissing = sum(idxMissing);
%g
fillMean = mean(signal, 'omitnan');
signalFilled = signal;
signalFilled(idxMissing) = fillMean;
%h
mu_f  = mean(signalFilled);
sig_f = std(signalFilled);
idxOutlier = abs(signalFilled - mu_f) > 3 * sig_f;
%i
signalClean = signalFilled;
signalClean(idxOutlier) = NaN;
%j
validSignal = signalClean(~isnan(signalClean));
%k
normSignal = (validSignal - min(validSignal)) ./ (max(validSignal) - min(validSignal));
%l
finalMean = mean(normSignal);
finalVar  = var(normSignal);
fprintf('finalMean=%.4f, finalVar=%.4f\n', finalMean, finalVar);
%m
figure;
tl = tiledlayout(2,1);
nexttile;
plot(validSignal); title('validSignal'); xlabel('Index'); ylabel('Value'); grid on;
nexttile;
plot(normSignal); title('normSignal (Min-Max)'); xlabel('Index'); ylabel('Value'); grid on;

%문제 13번
clear; clc;
%a
x = -5:0.05:5;
y = -5:0.05:5;
[X, Y] = meshgrid(x, y);
%b
Z = exp(-0.08*(X.^2 + Y.^2)) .* sin(3*X) .* cos(2*Y) + 0.15*sin(X.*Y);
%c
figure;
h_surf = surf(X, Y, Z);
%d
shading interp;
colorbar;
%e,f
xlabel('x-axis', 'FontSize', 12);
ylabel('y-axis', 'FontSize', 12);
zlabel('z=f(x,y)', 'FontSize', 12);
title('Detailed Surface Plot of a Multivariable Function', 'FontSize', 13);
%g
grid on;
ax = gca; ax.FontSize = 12;
%h
view(45, 30);
%i
hold on;
h_plane = surf(X, Y, zeros(size(Z)));
h_plane.FaceAlpha = 0.3;
h_plane.EdgeColor = 'none';
%j
maxZ = max(Z(:));
minZ = min(Z(:));
%k
[row_max, col_max] = find(Z == maxZ, 1);
[row_min, col_min] = find(Z == minZ, 1);
maxPoint = [X(row_max, col_max), Y(row_max, col_max), maxZ];
minPoint = [X(row_min, col_min), Y(row_min, col_min), minZ];

disp('maxPoint:'); disp(maxPoint);
disp('minPoint:'); disp(minPoint);
%l
h_max = plot3(maxPoint(1), maxPoint(2), maxPoint(3), 'r*', 'MarkerSize', 12, 'LineWidth', 2);
h_min = plot3(minPoint(1), minPoint(2), minPoint(3), 'b^', 'MarkerSize', 12, 'LineWidth', 2);
legend([h_surf, h_plane, h_max, h_min], ...
    'Surface', 'z=0 plane', 'Maximum point', 'Minimum point')
%m
exportgraphics(gcf, 'complex_surface.png', 'Resolution', 150);

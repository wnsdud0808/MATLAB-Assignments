%문제 1번
%a
rng(14);
%b
request = poissrnd(18,30,12);
%c
dailyTotal = sum(request,2);
%d
busyDay = dailyTotal>=240;
%e
numBusyDay = sum(busyDay);
%f
hourlyMean = mean(request, 1);
%g
figure;
plot(1:30,dailyTotal,'-b','LineWidth',1.5);
hold on;
plot(find(busyDay), dailyTotal(busyDay), 'ro', ...
    'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold off;
%h
xlabel('Day');
ylabel('Total Requests');
title('Daily Delivery Request Simulation');
legend('Daily Total', 'Busy Day', 'Location', 'best');
grid on;

%문제 2번
clear; clc;
%a
n =3000;
%b
interArrival = exprnd(1.2,1,n);
%c
arrival = cumsum(interArrival);
%d
service = exprnd(0.9,1,n);
%e
startTime  = zeros(1, n);
finishTime = zeros(1, n);
for i = 1:n
    if i == 1
        startTime(1) = arrival(1);
    else
        startTime(i) = max(arrival(i),finishTime(i-1));
    end
    finishTime(i) = startTime(i) + service(i);
end
%f
waitingTime = startTime - arrival;
%g
meanWait = mean(waitingTime);
maxWait = max(waitingTime);
longWaitRatio = sum(waitingTime>=5)/n;
%h
figure;
histogram(waitingTime,40);
xlabel('WaitingTime');
ylabel('Frequency');
%f
title('Waiting Time Distribution in a Data Center Queue');

%문제 3번
clear; clc;
%a
n = 100000;
%b
c1 = rand(1,n) < 0.97;
c2 = rand(1,n) < 0.95;
c3 = rand(1, n) < 0.96;
c4 = rand(1, n) < 0.92;
%c
systemWorking = c1 & c2 & c3 & c4;
%d
reliabilityEst = mean(systemWorking);
%e
reliabilityTrue = 0.97 * 0.95 * 0.96 * 0.92;
%f
absError = abs(reliabilityEst - reliabilityTrue);
%g
failCounts = [sum(~c1), sum(~c2), sum(~c3), sum(~c4), sum(~systemWorking)];
%h
figure;
bar(failCounts);
xticklabels({'C1', 'C2', 'C3', 'C4', 'System'});
xlabel('Component');
ylabel('Fail Count');
title('Component and System Failure Counts');

%문제 4번
clear; clc;
%a
n = 50000;
batteryLife = normrnd(9.5, 1.2, 1, n);
%b
lowBattery =  batteryLife < 8;
%c
normalBattery = batteryLife >= 8 & batteryLife < 11;
%d
excellentBattery = batteryLife >= 11;
%e
gradeCounts = [sum(lowBattery), sum(normalBattery), sum(excellentBattery)];
%f
gradeRatio = gradeCounts / n;
%g
figure;
histogram(batteryLife,50);
xline(8,  'r', 'LineWidth', 2);
xline(11, 'b', 'LineWidth', 2);
xlabel('Battery Life (hours)');
ylabel('Frequency');
title('Battery Life Distribution');
%h
figure;
bar(gradeCounts);
xticklabels({'부족', '정상', '우수'});
xlabel('Grade');
ylabel('Count');
title('Battery Grade Counts');

%문제 5번
clear; clc;
%a
n = 20000;
%b
hasClaim = rand(1,n) < 0.06;
%c
claimAmount = normrnd(800, 250, 1, n);
%d
claimAmount(claimAmount < 0) = 0;
%e
claimPayment = hasClaim .* claimAmount;
%f
totalPayment   = sum(claimPayment);
meanPayment    = mean(claimPayment);
meanClaimOnly  = mean(claimPayment(hasClaim));
%g
numLargeClaim = sum(claimPayment >= 1200);
%h
figure;
histogram(claimPayment);
title('All Customers Payment Distribution');
xlabel('Payment');
ylabel('Frequency');

figure;
histogram(claimPayment(claimPayment > 0));
title('Claim Only Payment Distribution');
xlabel('Payment');
ylabel('Frequency');

%문제 6번
clear; clc;
%a
n = 1000;
m = 100;
%b
steps = rand(n,m) < 0.56;
steps = 2*steps - 1;
%c
walks = cumsum(steps);
%d
figure;
plot(walks);
xlabel('Step');
ylabel('Position');
title('100 Random Walks');
grid on;
%e
finalPosition = walks(end,:);
%f
meanFinal = mean(finalPosition);
stdFinal  = std(finalPosition);
%g
rightDriftRatio = sum(finalPosition >= 100) / m;
%h
figure;
histogram(finalPosition,30);
xlabel('Final Position');
ylabel('Frequency');
title('Final Position Distribution');

%문제 7번
clear; clc;

%a
rng(7);
%b
t = linspace(0, 30, 300);
%c
trueSignal = 2*sin(0.4*t) + 0.7*cos(1.5*t);
%d
obsSignal = trueSignal + 0.25*randn(1, 300);
%e
miss = randperm(300, 45);
obsSignal(miss) = NaN;
%f
valid = ~isnan(obsSignal);
%g
recLinear = interp1(t(valid), obsSignal(valid), t, 'linear');
%h
recSpline = interp1(t(valid), obsSignal(valid), t, 'spline');
%i
rmseLinear = sqrt(mean((trueSignal - recLinear).^2));
rmseSpline = sqrt(mean((trueSignal - recSpline).^2));
%j
figure;
plot(t, trueSignal, 'k-', 'LineWidth', 1.5);
hold on;
plot(t, obsSignal, 'g.', 'MarkerSize', 8);
plot(t, recLinear, 'b--', 'LineWidth', 1.2);
plot(t, recSpline, 'r-.', 'LineWidth', 1.2);
hold off;
legend('True Signal', 'Observed', 'Linear', 'Spline');
xlabel('Time');
ylabel('Signal');
title('Signal Recovery Comparison');
grid on;

%문제 8번
clear; clc;
%a
timeObs = [0 3 6 9 12 15 18 21 24];
windObs = [3.1 3.8 5.4 7.2 8.0 7.1 5.6 4.2 3.5];
%b
timeHourly = 0:1:24;
%c
windLinear = interp1(timeObs, windObs, timeHourly, 'linear');
%d
windSpline = interp1(timeObs, windObs, timeHourly, 'spline');
%e
diffWind = windSpline - windLinear;
%f
maxDiff = max(abs(diffWind));
%g
figure;
plot(timeObs, windObs, 'ko', 'MarkerFaceColor', 'k');
hold on;
plot(timeHourly, windLinear, 'b--');
plot(timeHourly, windSpline, 'r-');
hold off;
legend('Observed', 'Linear', 'Spline');
xlabel('Time');
ylabel('Wind Speed');
title('Wind Speed Interpolation');
grid on;
%h
figure;
plot(timeHourly, diffWind);
xlabel('Time');
ylabel('Difference');
title('Difference between Spline and Linear');
grid on;

%문제 9번
clear; clc;
%a
[X, Y] = meshgrid(1:5, 1:5);
%b
H = [12 14 16 15 13;
     13 18 22 20 16;
     15 23 31 25 18;
     14 20 26 24 17;
     11 15 18 16 14];
%c
[Xq, Yq] = meshgrid(1:0.1:5, 1:0.1:5);
%d
HqLinear = interp2(X, Y, H, Xq, Yq, 'linear');
%e
HqSpline = interp2(X, Y, H, Xq, Yq, 'spline');
%f,g
figure;
tiledlayout(1, 3);

nexttile;
surf(X, Y, H);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Original');

nexttile;
surf(Xq, Yq, HqLinear);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Linear Interpolation');

nexttile;
surf(Xq, Yq, HqSpline);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Spline Interpolation');

%문제 10번
clear; clc;
%a
tObs = [0 1.2 2.8 4.5 7.0 8.1 9.7 12.0];
cObs = [5.0 6.4 9.1 8.6 6.8 5.9 5.2 4.8];
%b
tq = 0:0.1:12;
%c
cqLinear = interp1(tObs, cObs, tq, 'linear');
%d
cqSpline = interp1(tObs, cObs, tq, 'spline');
%e
deltaC = diff(cqLinear);
%f
idxMaxChange = find(abs(deltaC) == max(abs(deltaC)));
%g
changeInterval = [tq(idxMaxChange), tq(idxMaxChange + 1)];
%h
figure;
plot(tObs, cObs, 'ko', 'MarkerFaceColor', 'k');
hold on;
plot(tq, cqLinear, 'b--');
plot(tq, cqSpline, 'r-');
plot(tq(idxMaxChange), cqLinear(idxMaxChange), 'bs', 'MarkerSize', 10);
plot(tq(idxMaxChange+1), cqLinear(idxMaxChange+1), 'bs', 'MarkerSize', 10);
hold off;
legend('Observed', 'Linear', 'Spline', 'Max Change Points');
xlabel('Time');
ylabel('Concentration');
title('Concentration Interpolation');
grid on;

%문제 11번
clear; clc;
%a
t = linspace(0, 80, 12000);
%b
y = exp(-0.04*t).*sin(2*t) + 0.3*exp(-0.01*t).*cos(7*t);
%c
figure('Color', 'w');
%d
plot(t, y, 'LineWidth', 1.3);
%e
yline(0);
%f
xlabel('Time');
ylabel('Signal Amplitude');
title('High-Resolution Damped Oscillatory Signal');
%g
xlim([0 80]);
grid on;
box on;
%h
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
%i
exportgraphics(gcf, 'damped_signal.png', 'Resolution', 300);

%문제 12번
clear; clc;
%a
x = linspace(-5, 5, 600);
y = linspace(-5, 5, 600);
%b
[X, Y] = meshgrid(x, y);
%c
Z = exp(-0.06*(X.^2 + Y.^2)).*sin(4*X).*cos(3*Y) + 0.2*sin(X.*Y);
%d,e,f,g,h
figure;
surf(X, Y, Z);
shading interp;
colormap(jet);
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Detailed Surface Plot with Oscillation and Damping');
view(45, 30);
camlight headlight;
lighting phong;
%i
maxZ = max(Z(:));
minZ = min(Z(:));
%j
[row_max, col_max] = find(Z == maxZ);
maxPoint = [X(row_max, col_max), Y(row_max, col_max), maxZ];

[row_min, col_min] = find(Z == minZ);
minPoint = [X(row_min, col_min), Y(row_min, col_min), minZ];

%문제 13번
clear; clc;
%a
x = linspace(-8, 8, 800);
y = linspace(-8, 8, 800);
%b
[X, Y] = meshgrid(x, y);
%c
Z = cos(2*X).*sin(3*Y) ./ (1 + 0.1*(X.^2 + Y.^2));
%d
figure;
contourf(X, Y, Z, 70, 'LineColor', 'none');
%e
colormap(parula);
colorbar;
axis equal;
grid on;
box on;
%f
xlabel('X coordinate');
ylabel('Y coordinate');
%g
title('High-Resolution Filled Contour of a Damped Oscillatory Field');
%h
set(gca, 'FontSize', 12, 'LineWidth', 1.2);

%문제 14번
clear; clc;
%a
x = linspace(-4, 4, 300);
y = linspace(-4, 4, 300);
%b
[X, Y] = meshgrid(x, y);
%c
Z1 = sin(X).*cos(Y);
Z2 = exp(-0.08*(X.^2 + Y.^2));
Z3 = sin(X.^2 + Y.^2);
%d
figure;
tiledlayout(1, 3);
%e,f,g
nexttile;
surf(X, Y, Z1);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Z1 = sin(X)cos(Y)');
view(45, 30);

nexttile;
surf(X, Y, Z2);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Z2 = exp(-0.08(X^2+Y^2))');
view(45, 30);

nexttile;
surf(X, Y, Z3);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Z3 = sin(X^2+Y^2)');
view(45, 30);
%h
sgtitle('Comparison of Three Surface Structures');

%문제 15번
clear; clc;
%a
u = linspace(0, 8*pi, 500);
v = linspace(-pi, pi, 180);
%b
[U, V] = meshgrid(u, v);
%c
X = (2 + 0.4*cos(V)).*cos(U);
Y = (2 + 0.4*cos(V)).*sin(U);
Z = 0.25*U + 0.4*sin(V);
%d
figure;
surf(X, Y, Z);
%e
shading interp;
colormap(parula);
colorbar;
%f
xlabel('X');
ylabel('Y');
zlabel('Z');
%g
title('Twisted Parametric Ribbon Surface');
%h
axis equal;
axis tight;
grid on;
view(45, 35);
%i
exportgraphics(gcf, 'twisted_ribbon.png', 'Resolution', 300);

%문제 16번
clear; clc;
%a
rng(3);
%b
t = linspace(0, 60, 6000);
signal = sin(0.5*t) + 0.4*sin(3*t) + 0.15*randn(1, 6000);
%c
trend = movmean(signal, 200);
%d
x = linspace(-5, 5, 300);
y = linspace(-5, 5, 300);
[X, Y] = meshgrid(x, y);
%e
Z = exp(-0.05*(X.^2 + Y.^2)).*cos(3*X).*sin(2*Y);
%f
figure;
tiledlayout(2, 2);
%g
nexttile;
plot(t, signal, 'Color', [0.7 0.7 0.7]);
hold on;
plot(t, trend, 'r', 'LineWidth', 1.5);
hold off;
xlabel('Time');
ylabel('Amplitude');
title('Signal with Moving Average');
legend('Signal', 'Trend');
grid on;
%h
nexttile;
surf(X, Y, Z);
shading interp;
colorbar;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('Surface Plot');
%i
nexttile;
contourf(X, Y, Z, 50, 'LineColor', 'none');
colorbar;
xlabel('X'); ylabel('Y');
title('Filled Contour');
grid on;
%j
nexttile;
axis off;
text(0.5, 0.5, 'Dashboard Summary', ...
    'HorizontalAlignment', 'center', 'FontSize', 14);
%k
sgtitle('Integrated Visualization Dashboard');
%l
exportgraphics(gcf, 'visualization_dashboard.png', 'Resolution', 300);

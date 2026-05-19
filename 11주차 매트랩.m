%문제 1번
clear; clc;
%a
Hour     = [6;7;8;9;10;11;12;13;14;15;16;17];
SolarGen = [0.5;1.2;2.4;3.8;4.6;5.1;5.4;5.0;4.2;3.0;1.7;0.8];
Demand   = [1.8;2.0;2.3;2.7;3.1;3.4;3.8;4.0;3.7;3.4;3.0;2.5];
Battery  = [3.2;3.0;3.1;3.8;4.5;5.2;5.9;6.3;6.5;6.1;5.4;4.7];
%b
A = [Hour, SolarGen, Demand, Battery];
disp(A);
%c
writematrix(A, 'solar_system.txt');
%d
B = load('solar_system.txt');
%e
hour    = B(:,1);
solar   = B(:,2);
demand  = B(:,3);
battery = B(:,4);
%f
netPower = solar - demand;
%g
figure;
plot(hour,netPower,'-o');
xlabel('hour'); ylabel('netPower');
title('시간별 순 발전량');
grid on;

%문제 2번
clear; clc;
%a
D = [1, 2.1, 8,  12;
     2, 3.4, 13, 19;
     3, 1.8, 7,  10;
     4, 5.2, 21, 31;
     5, 4.7, 19, 28;
     6, 6.0, 25, 36;
     7, 3.1, 12, 18;
     8, 5.8, 24, 35];
%b
writematrix(D, 'drone_delivery.txt');
D_loaded = load('drone_delivery.txt');
%c
RouteID     = D_loaded(:,1);
DistanceKm  = D_loaded(:,2);
TimeMin     = D_loaded(:,3);
BatteryUsed = D_loaded(:,4);
%d
speed = DistanceKm ./ TimeMin;
%e
BatteryPerKm = BatteryUsed ./ DistanceKm;
%f
idx = find(BatteryPerKm > 6);
result = [RouteID(idx), DistanceKm(idx), BatteryPerKm(idx)];
disp(result);

%문제 3번
clear; clc;
%a
Zone     = {'Z1';'Z2';'Z3';'Z4';'Z5';'Z6';'Z7';'Z8'};
Temp     = [22.5;24.1;21.8;25.3;23.7;26.0;22.9;24.8];
Humidity = [61;58;67;55;62;53;65;57];
Light    = [420;460;390;520;480;550;410;500];
CO2      = [510;540;495;610;575;640;520;600];
%b
Farm = table(Zone, Temp, Humidity, Light, CO2);
%c
Farm.EnvIndex = 0.4*Farm.Temp + 0.01*Farm.Light + 0.02*Farm.CO2;
%d
HighEnv = Farm(Farm.EnvIndex >= 25, :);
%e
disp(HighEnv(:, {'Zone','Temp','Light','EnvIndex'}));

%문제 4번
clear; clc;
%a
Machine   = {'M1';'M2';'M3';'M4';'M5';'M6';'M7';'M8';'M9';'M10'};
Vibration = [1.8;2.4;1.5;3.1;2.7;1.9;3.5;2.2;1.6;2.9];
Temp      = [68;72;65;78;74;69;82;71;66;76];
Power     = [4.5;5.1;4.2;6.3;5.7;4.8;6.8;5.0;4.4;6.0];
Defect    = [2;5;1;8;6;3;10;4;1;7];

Factory = table(Machine, Vibration, Temp, Power, Defect);
%b
Factory.RiskScore = Factory.Vibration .* Factory.Temp ./ Factory.Power;
%c
RiskMachines = Factory(Factory.RiskScore >= 35 & Factory.Defect >= 6, :);
%d
disp(RiskMachines(:, {'Machine','RiskScore','Defect'}));
%e
writetable(Factory, 'factory_risk.csv');

%문제 5번
clear; clc;
%a
url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data';
%b
Abalone = readtable(url, 'FileType','text', 'ReadVariableNames',false);
%c
Abalone.Properties.VariableNames = ...
    {'Sex','Length','Diameter','Height','WholeWeight', ...
     'ShuckedWeight','VisceraWeight','ShellWeight','Rings'};
%d
disp(Abalone(:, {'WholeWeight','ShellWeight','Rings'}));
%e
OldMale = Abalone(strcmp(Abalone.Sex,'M') & Abalone.Rings >= 15, :);
%f
disp(OldMale(:, {'Sex','Length','WholeWeight','Rings'}));

%문제 6번

%a 문제 5번 table 그대로 사용
%b
Abalone.ShellRatio = Abalone.ShellWeight ./ Abalone.WholeWeight;
%c
HardShell = Abalone(Abalone.ShellRatio >= 0.25 & Abalone.Rings >= 12, :);
%d
disp(HardShell(:, {'Sex','WholeWeight','ShellWeight','ShellRatio','Rings'}));
%e
ratioData = HardShell{:, 'ShellRatio'};
disp(ratioData(1:5));

%문제 7번
clear; clc;
%a
url = 'https://archive.ics.uci.edu/ml/machine-learning-databases/forest-fires/forestfires.csv';
%b
Fire = readtable(url);
%c
temp = Fire.temp;
RH   = Fire.RH;
wind = Fire.wind;
rain = Fire.rain;
area = Fire.area;
%d
HotDryFires = Fire(Fire.temp >= 25 & Fire.RH <= 35, :);
%e
disp(HotDryFires(:, {'month','day','temp','RH','wind','area'}));

%문제 8번
%a 문제7번 table 사용
%b
Fire.RiskIndex = Fire.temp .* Fire.wind ./ Fire.RH;
%c
RiskFire = Fire(Fire.RiskIndex >= 2 & Fire.area > 0, :);
%d
disp(RiskFire(:, {'month','day','temp','RH','wind','area','RiskIndex'}));
%e
writetable(RiskFire, 'forest_risk.csv');

%문제 9번
clear; clc;

%a
P = readtable('penguins.csv');
%b
P.Properties.VariableNames'
%c
HeavyPenguins = P(P.body_mass_g >= 4500, :);
%d
disp(HeavyPenguins(:, {'species','island','body_mass_g','sex'}));
%e
LargeGentoo = P(strcmp(P.species,'Gentoo') & P.body_mass_g >= 5000, :);
disp(LargeGentoo);

%문제 10번

%a 9번 그대로 사용
%b
P.BillRatio = P.bill_length_mm ./ P.bill_depth_mm;
%c
LongBill = P(P.BillRatio >= 2.8, :);
%d
disp(LongBill(:, {'species','bill_length_mm','bill_depth_mm','BillRatio'}));
%e
billRatioData = LongBill{:, 'BillRatio'};
disp(billRatioData(1:5));

%문제 11번
clear; clc;
%a
H = readtable('heart_failure.csv');
%b
H.Properties.VariableNames'
%c
HighRisk = H(H.age >= 70 & H.ejection_fraction <= 35, :);
%d
disp(HighRisk(:, {'age','ejection_fraction','serum_creatinine','serum_sodium','DEATH_EVENT'}));
%e
DeathGroup    = H(H.DEATH_EVENT == 1, :);
SurvivalGroup = H(H.DEATH_EVENT == 0, :);

%문제 12번
%a 11번의 table그대로 사용
%b
H.RiskScore = H.age ./ H.ejection_fraction + H.serum_creatinine;
%c
RiskScoreGroup = H(H.RiskScore >= 4, :);
%d
disp(RiskScoreGroup(:, {'age','ejection_fraction','serum_creatinine','RiskScore','DEATH_EVENT'}));
%e
writetable(RiskScoreGroup, 'heart_risk_group.csv');

%문제 13번
clear; clc;
%a
B = readtable('bank-full.csv');
%b
B.Properties.VariableNames'
%c
age     = B.age;
balance = B.balance;
loan    = B.loan;
deposit = B.deposit;
%d
T1 = B(B.age >= 40 & B.balance >= 2000 & strcmp(B.loan,'no'), :);
%e
T2 = T1(:, {'age','balance','deposit'});
%f
T2.NewFlag = double(strcmp(T2.deposit, 'yes'));
%g
Subscribed = T2(T2.NewFlag == 1, :);
%h
balanceVec = Subscribed{:, 'balance'};
%i
avgBalance = mean(balanceVec);
fprintf('avgBalance = %.2f\n', avgBalance);
%j
writetable(Subscribed, 'bank_selected.csv');

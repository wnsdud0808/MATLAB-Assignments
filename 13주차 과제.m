%문제 1번
clear; clc;
%a
rng(13);
%b
p = 0.35 + (0.95 - 0.35) * rand(1,40);
%c
R = rand(5000, 40);
correct = R < p;
%d
total_scores = sum(correct, 2);
mean_score   = mean(total_scores);
std_score    = std(total_scores);

fprintf('평균 점수: %.4f\n', mean_score);
fprintf('표준편차:  %.4f\n', std_score);
%e
above_avg_ratio = mean(total_scores >= mean_score);
fprintf('평균 이상 학생 비율: %.4f (%.2f%%)\n', above_avg_ratio, above_avg_ratio*100);

figure;
histogram(total_scores);
xline(mean_score, 'r--');
xlabel('점수 (총 40점)');
ylabel('학생 수');
title('5000명 학생 점수 분포');
grid on;

%문제 2번
clear; clc;
%a
weights = 100 + 4 * randn(10000, 20);
%b
box_mean = mean(weights, 2);
%c
fail = (box_mean < 98) | (box_mean > 102);
%d
fail_ratio = mean(fail);
fprintf('불합격률: %.4f (%.2f%%)\n', fail_ratio, fail_ratio*100);
%e
figure;
histogram(box_mean);
xline(98, 'r--');
xline(102, 'r--');
xlabel('상자 평균 무게 (g)');
ylabel('상자 수');
title('상자 평균 무게 분포');
grid on;

%문제 3번
clear; clc;
%a
N = randn(100000, 1);
%b
A = 1.8;
S = A + N;
%c
threshold = 1.2;
detected = S >= threshold;
%d
detect_rate = mean(detected);
fprintf('감지 성공률: %.4f (%.2f%%)\n', detect_rate, detect_rate*100);
%e
figure;
histogram(S);
xline(threshold, 'r--');
xlabel('수신 신호 세기 S');
ylabel('빈도');
title('수신 신호 분포');
grid on;

%문제 4번
clear; clc;
%a
n_days = 365;
daily_orders = poissrnd(180, n_days, 1);
%b
daily_total_time = zeros(n_days, 1);
for d = 1:n_days
    n = daily_orders(d);
    process_times = 6 + 2 * randn(n, 1);
    process_times(process_times < 0) = 0;
    daily_total_time(d) = sum(process_times);
end
%c
over_ratio = mean(daily_total_time > 1200);
fprintf('하루 처리시간 1200분 초과 비율: %.4f (%.2f%%)\n', over_ratio, over_ratio*100);
%d
figure;
subplot(2,1,1);
plot(1:n_days, daily_orders, 'b-');
xlabel('날짜 (일)'); ylabel('주문 수');
title('하루 주문 수');
grid on;

subplot(2,1,2);
plot(1:n_days, daily_total_time, 'r-');
xlabel('날짜 (일)'); ylabel('총 처리시간 (분)');
title('하루 총 처리 시간');
grid on;
%e
figure;
scatter(daily_orders, daily_total_time);
xlabel('하루 주문 수');
ylabel('하루 총 처리시간 (분)');
title('주문 수 vs 총 처리 시간');
grid on;

%문제 5번
clear; clc;

n_sensors = 30;
n_iter    = 10000;
true_temp = 25;
sigma     = 0.8;
%a
measurements = true_temp + sigma * randn(n_iter, n_sensors);
%b
sensor_mean = mean(measurements, 2);
%c
within_range = (sensor_mean >= 24.7) & (sensor_mean <= 25.3);
%d
prob = mean(within_range);
fprintf('30개 센서 평균이 ±0.3도 이내일 확률: %.4f (%.2f%%)\n', prob, prob*100);
%e
single_sensor = measurements(:, 1);

figure;
histogram(single_sensor, 'Normalization', 'pdf', 'FaceAlpha', 0.5);
hold on;
histogram(sensor_mean, 'Normalization', 'pdf', 'FaceAlpha', 0.5);
xline(24.7, 'k--');
xline(25.3, 'k--');
legend('센서 1개', '30개 평균');
xlabel('측정값 (°C)');
ylabel('확률 밀도');
title('센서 1개 vs 30개 평균 분포 비교');

%문제 6번
clear; clc;

n_paths = 5000;
n_days  = 60;
mu      = 0.0008;
sigma   = 0.015;
S0      = 100;
%a
returns = mu + sigma * randn(n_paths,n_days);
%b
cum_returns = cumprod(1+returns,2);
asset_paths = S0 * cum_returns;
%c
final_values = asset_paths(:,end);
fprintf('마지막 날 자산 평균: %.4f\n',mean(final_values));
fprintf('마지막 날 자산 최솟값: %.4f\n',min(final_values));
fprintf('마지막 날 자산 최대값: %.4f\n',max(final_values));
%d
loss_prob = mean(final_values<S0);
fprintf('마지막 날 손실 확률(자산<100) : %.4f (%.2f%%)\n',loss_prob,loss_prob*100);
%e
idx = randperm(n_paths,30);

figure;
plot(0:n_days,[repmat(S0, 30, 1), asset_paths(idx, :)]');
xlabel('날');
ylabel('자산 가치');
title('임의 30개 자산 경로');
yline(S0,'r--');
grid on;

%문제 7번
clear; clc;

n_patients = 300;
%a
inter_arrival = exprnd(8,n_patients,1);
arrival_time = cumsum(inter_arrival);
%b
service_time = 10 + 3 *randn(n_patients,1);
service_time(service_time < 0) = 1;
%c
start_time = zeros(n_patients, 1);
end_time   = zeros(n_patients, 1);
start_time(1) = arrival_time(1);
end_time(1)   = start_time(1) + service_time(1);

for i = 2:n_patients
    start_time(i) = max(arrival_time(i), end_time(i-1));
    end_time(i)   = start_time(i) + service_time(i);
end
%d
wait_time = start_time - arrival_time;
%e
fprintf('평균 대기시간: %.4f분\n', mean(wait_time));
fprintf('최대 대기시간: %.4f분\n', max(wait_time));
over20_ratio = mean(wait_time > 20);
fprintf('대기시간 20분 초과 환자 비율: %.4f (%.2f%%)\n', over20_ratio, over20_ratio*100);

figure;
histogram(wait_time);
xline(20, 'r--');
xlabel('대기시간 (분)');
ylabel('환자 수');
title('환자 대기시간 분포');
grid on;

%문제 8번
clear; clc;

n_trials = 100000;
p = [0.72, 0.81, 0.67, 0.90, 0.76];
%a
R = rand(n_trials, 5);
%b
detected_mat = R < p;
%c
n_detected = sum(detected_mat, 2);
%d
system_success = mean(n_detected >= 3);
fprintf('=== 문제 8 ===\n');
fprintf('시스템 감지 확률: %.4f (%.2f%%)\n', system_success, system_success*100);
%e
figure;
histogram(n_detected, 'BinEdges', -0.5:5.5);
xlabel('감지 모듈 수');
ylabel('빈도');
title('감지 모듈 수 분포');
xticks(0:5);
grid on;

%문제 9번
clear; clc;

n_products = 50000;

%a
pass1 = rand(n_products, 1) < 0.94;
%b
pass2 = false(n_products, 1);
idx1  = find(pass1);
pass2(idx1) = rand(length(idx1), 1) < 0.91;
%c
pass3 = false(n_products, 1);
idx2  = find(pass2);
pass3(idx2) = rand(length(idx2), 1) < 0.88;
%d
final_pass_rate = mean(pass3);
fprintf('최종 합격률: %.4f (%.2f%%)\n', final_pass_rate, final_pass_rate*100);
%e
fail1 = sum(~pass1);
fail2 = sum(pass1 & ~pass2);
fail3 = sum(pass2 & ~pass3);
final_pass_count = sum(pass3);

fprintf('1단계 탈락: %d개\n', fail1);
fprintf('2단계 탈락: %d개\n', fail2);
fprintf('3단계 탈락: %d개\n', fail3);
fprintf('최종 합격:  %d개\n', final_pass_count);

figure;
bar([fail1, fail2, fail3, final_pass_count]);
xticklabels({'1단계 탈락', '2단계 탈락', '3단계 탈락', '최종 합격'});
ylabel('제품 수');
title('단계별 탈락 및 최종 합격 제품 수');
grid on;

%문제 10번
clear; clc;

n_days     = 10000;
P_base     = 500;
P_extra    = 120;
p_overload = 0.12;
%a
server_load = 35 * randn(n_days, 1);
%b
cooling_overload = rand(n_days, 1) < p_overload;
%c
daily_power = P_base + server_load + P_extra * cooling_overload;
%d
over650_ratio = mean(daily_power > 650);
fprintf('전력 650 초과 날 비율: %.4f (%.2f%%)\n', over650_ratio, over650_ratio*100);
%e
mean_overload    = mean(daily_power(cooling_overload));
mean_no_overload = mean(daily_power(~cooling_overload));
fprintf('과부하 발생일 평균 전력:   %.4f\n', mean_overload);
fprintf('과부하 미발생일 평균 전력: %.4f\n', mean_no_overload);

figure;
histogram(daily_power(~cooling_overload), 'FaceAlpha', 0.6, 'DisplayName', '과부하 없음');
hold on;
histogram(daily_power(cooling_overload), 'FaceAlpha', 0.6, 'DisplayName', '과부하 있음');
xline(650, 'r--', 'HandleVisibility', 'off');
legend;
xlabel('하루 전력 사용량');
ylabel('빈도');
title('전력 사용량 분포 (과부하 여부별)');

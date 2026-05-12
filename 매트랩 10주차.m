%문제 1번
clear; clc;
figure;
%a
t = 0 : 0.01 : 30;
f = exp(-0.12*t) .* sin(5*t) + 0.3*cos(2*t);
plot(t,f);
xlabel('t'); ylabel('f(t)'); title('f(t)그래프');
%b
u = exp(-0.12*t) + 0.3;
l = -exp(-0.12*t) - 0.3;
hold on;
plot(t, u, 'r--');
plot(t, l, 'g--');
legend('f(t)', 'u(t)', 'l(t)');
hold off;
%c
k = find(f(2:end-1) > f(1:end-2) & f(2:end-1) > f(3:end)) + 1;
%d
hold on;
plot(t(k), f(k), 'ko', 'MarkerSize', 6, 'LineWidth', 1.5);
hold off;
%e
result1 = [t(k)', f(k)'];
disp('국소 최대값 후보 [t, f(t)]:');
disp(result1);

%문제 2번
clear; clc;
figure;

x = -5 : 0.05 : 5;
y = -5 : 0.05 : 5;
[X, Y] = meshgrid(x, y);
%a
Z = sin(X .* Y) ./ (1 + X.^2 + Y.^2);
%b
mesh(X, Y, Z);
xlabel('x'); ylabel('y'); zlabel('z');
title('mesh 그래프');
%c
contour(X, Y, Z, 25);
xlabel('x'); ylabel('y');
title('contour 그래프');
colorbar;
%d
absZ = abs(Z);
maxZ = max(absZ(:));
fprintf('|Z| 최댓값: %.4f\n', maxZ);
%e
idx = find(absZ == maxZ, 1);
[row, col] = ind2sub(size(absZ), idx);
fprintf('최댓값 위치: x = %.2f, y = %.2f\n', X(row, col), Y(row, col));

%문제 3번
clear; clc;
A = [7 2 1; 2 6 -2; 1 -2 5];
%a
[V, D] = eig(A);
disp('고유벡터 행렬 V:'); disp(V);
disp('고유값 행렬 D:'); disp(D);
%b
eigenvalues = diag(D);
disp('고유값 벡터:'); disp(eigenvalues);
%c
[lambda_max, idx] = max(eigenvalues);
fprintf('최대 고유값 lamda_max = %.4f, index = %d\n', lambda_max, idx);
%d
v = V(:, idx);
disp('대응 고유벡터 v:'); disp(v);
%e
v_unit = v / norm(v);
disp('단위벡터 v/norm(v):'); disp(v_unit);
%f
residual = A*v - lambda_max*v;
disp('Av - λmax*v (영벡터에 가까워야 함):'); disp(residual);

%문제 4번
clear; clc;
X = [2 5 1; 4 8 3; 6 11 7; 9 15 10; 13 20 14];
%a
col_mean = mean(X);
disp('각 열 평균:'); disp(col_mean);
%b
Xc = X - mean(X);
disp('중심화 행렬 Xc:'); disp(Xc);
%c
S = Xc' * Xc;
disp('공분산 행렬 S:'); disp(S);
%d
[VS, DS] = eig(S);
eigenvalues_S = diag(DS);
disp('S의 고유값:'); disp(eigenvalues_S);
%e
[max_eig, idx] = max(eigenvalues_S);
fprintf('최대 고유값: %.4f\n', max_eig);
%f
v_max = VS(:, idx);
disp('최대 고유값에 대응하는 고유벡터:'); disp(v_max);

%문제 5번
clear; clc;
%a
A = [5 2 -1; -2 6 3; 1 -1 7];
b = [8; 5; 12];
%b
x1 = inv(A) * b;
disp('x1 = inv(A)*b:'); disp(x1);
%c
x2 = A \ b;
disp('x2 = A\b:'); disp(x2);
%d
disp('x1 - x2 (차이):'); disp(x1 - x2);
%e
d = det(A);
fprintf('det(A) = %.4f\n', d);
if d ~= 0
    disp('det(A) ≠ 0 이므로 해가 유일하게 존재한다.');
end

%문제 6번
clear; clc;
figure;

x = -6 : 0.05 : 6;
y = -6 : 0.05 : 6;
%a
[X, Y] = meshgrid(x, y);
Z = exp(-0.08*(X.^2 + Y.^2)) .* cos(3*X) .* sin(2*Y);
%b
surf(X, Y, Z);
xlabel('x'); ylabel('y'); zlabel('z');
title('surf 그래프');
%c
contour(X, Y, Z, 30);
xlabel('x'); ylabel('y');
title('contour 그래프');
colorbar;
%d
maxZ = max(Z(:));
minZ = min(Z(:));
fprintf('Z 최대값: %.4f\n', maxZ);
fprintf('Z 최소값: %.4f\n', minZ);
%e
idx_max = find(Z == maxZ, 1);
idx_min = find(Z == minZ, 1);
[r_max, c_max] = ind2sub(size(Z), idx_max);
[r_min, c_min] = ind2sub(size(Z), idx_min);
fprintf('최대값 위치: x = %.2f, y = %.2f\n', X(r_max, c_max), Y(r_max, c_max));
fprintf('최소값 위치: x = %.2f, y = %.2f\n', X(r_min, c_min), Y(r_min, c_min));

%문제 7번
clear; clc;
figure;
n = [50, 100, 200, 400, 800, 1600];
T = [14, 19, 30, 51, 92, 170];
%a
subplot(1, 3, 1);
plot(n, T, 'o-');
xlabel('n'); ylabel('T'); title('일반 그래프');
%b
subplot(1, 3, 2);
semilogx(n, T, 'o-');
xlabel('n (log)'); ylabel('T'); title('semilogx');
%c
subplot(1, 3, 3);
semilogy(n, T, 'o-');
xlabel('n'); ylabel('T (log)'); title('semilogy');
%e
semilogx 그래프(x축 로그)에서 점들이 가장 직선에 가깝게 보인다.

%문제 8번
clear; clc;
figure;

%a
t = 0 : 0.01 : 24;
P = 50 + 18*sin(pi*t/12) + 6*cos(pi*t/4);
plot(t, P);
xlabel('t (hour)'); ylabel('P(t)'); title('전력 사용량');
%b
[maxP, idx_max] = max(P);
fprintf('최대 전력: %.4f\n', maxP);
%c
fprintf('최대 전력 발생 시간: t = %.2f hour\n', t(idx_max));
%d
[minP, idx_min] = min(P);
fprintf('최소 전력: %.4f, 발생 시간: t = %.2f hour\n', minP, t(idx_min));
%e
hold on;
plot(t(idx_max), maxP, 'r^');
plot(t(idx_min), minP, 'bs');
legend('P(t)', '최대점', '최소점');
hold off;

%문제 9번
clear; clc;

X = [1 3 0; 2 5 1; 4 8 3; 7 12 5; 11 17 9];
%a
x1 = X(:, 1);
x2 = X(:, 2);
x3 = X(:, 3);
%b
cos12 = dot(x1, x2) / (norm(x1) * norm(x2));
theta12 = acosd(cos12);
fprintf('x1-x2 각도: %.4f도\n', theta12);
%c
cos13 = dot(x1, x3) / (norm(x1) * norm(x3));
theta13 = acosd(cos13);
cos23 = dot(x2, x3) / (norm(x2) * norm(x3));
theta23 = acosd(cos23);
fprintf('x1-x3 각도: %.4f도\n', theta13);
fprintf('x2-x3 각도: %.4f도\n', theta23);
%d
theta = [theta12, theta13, theta23];
disp('theta = '); disp(theta);
%e
[min_theta, idx] = min(theta);
sensor_pairs = [1 2; 1 3; 2 3];
fprintf('가장 작은 각도: %.4f도\n', min_theta);
fprintf('가장 방향이 비슷한 두 센서: 센서 %d, 센서 %d\n',sensor_pairs(idx,1), sensor_pairs(idx,2));


%문제 10번
clear; clc;

%a
A = [9 -2 -1; -2 8 -3; -1 -3 10];
b = [15; 7; 11];
%b
I = A \ b;
disp('전류 벡터 I:'); disp(I);
%c
d = det(A);
fprintf('det(A) = %.4f\n', d);
if d ~= 0
    disp('det(A) ≠ 0 이므로 A는 가역행렬이다.');
end
%d
absI = abs(I);
disp('abs(I):'); disp(absI);
%e
[maxI, idx] = max(absI);
fprintf('절댓값 최대 전류: %.4f A, 전류 번호: i%d\n', maxI, idx);

%문제 11번
clear; clc;
figure;

t = 0 : 0.01 : 40;
%a
y = exp(-0.04*t) .* (sin(4*t) + 0.6*sin(9*t));
plot(t, y);
xlabel('t'); ylabel('y(t)'); title('음향 신호');
%b
u = 1.6 * exp(-0.04*t);
l = -1.6 * exp(-0.04*t);
%c
hold on;
plot(t, u, 'r--');
plot(t, l, 'g--');
legend('y(t)', 'u(t)', 'l(t)');
hold off;
%d
figure;
semilogy(t, abs(y));
xlabel('t'); ylabel('|y(t)|');
title('|y(t)| 로그 스케일');
%e
u_t0  = 1.6 * exp(-0.04*0);
u_t40 = 1.6 * exp(-0.04*40);
fprintf('t=0에서 u(t) = %.4f\n', u_t0);
fprintf('t=40에서 u(t) = %.4f\n', u_t40);


%문제 12번
clear; clc;
figure;

epoch = [1, 2, 5, 10, 20, 50, 100, 200];
loss  = [3.1, 2.4, 1.7, 1.2, 0.83, 0.36, 0.14, 0.06];
%a
subplot(1, 2, 1);
plot(epoch, loss, 'o-');
xlabel('epoch'); ylabel('loss'); title('일반 그래프');
%b
subplot(1, 2, 2);
semilogy(epoch, loss, 'o-');
xlabel('epoch'); ylabel('loss (log)'); title('semilogy 그래프');
%c
r = loss(2:end) ./ loss(1:end-1);
disp('비율 벡터 r:'); disp(r);
%d
mean_r = mean(r);
fprintf('평균 비율: %.4f\n', mean_r);
%e
if mean_r < 1
    disp('평균 비율이 1보다 작으므로 loss가 전반적으로 감소한다.');
end
평균 비율이 1보다 작으므로 loss가 전반적으로 감소한다고 판단할 수 있다.

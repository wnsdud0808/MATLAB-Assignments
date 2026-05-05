%문제 1번
clear; clc;
figure;

x = 0:0.05:6*pi;
y = sin(x) + 0.5*cos(3*x);

plot(x, y);
xticks(0:pi:6*pi);
xticklabels({'0','\pi','2\pi','3\pi','4\pi','5\pi','6\pi'});
title('y = sin(x) + 0.5cos(3x)');
xlabel('x');
ylabel('y');
grid on;

%문제 2번
clear; clc;
figure;

x = 1:1:50;
y = 3.^x;

subplot(1,2,1);
plot(x,y);
title('plot');
xlabel('x');
ylabel('y = 3^x');
grid on;

subplot(1,2,2);
semilogy(x,y);
title('semilogy');
xlabel('x');
ylabel('y = 3^x (log scale)');
grid on;
일반 plot에서는 x가 커질수록 y값이 폭발적으로 증가하여 x구간의 변화율을 거의 볼 수 없다. 근데 semilogy를 사용하여 y축이 로그스케일로 변환되어 지수함수가 직선처럼 나타나, 전체구간에서 증가 추세를 명확하게 비교할 수 있다.

%문제 3번
clear; clc;
figure;

score = [72, 85, 91, 66, 78, 88, 95, 54, 60, 73, 82, 90, 69, 77, 84, 92, 58, 63, 79, 87];

save('score.dat','score','-ascii');
data = load('score.dat');

subplot(1,2,1);
histogram(data,5);
title('구간수 = 5');
xlabel('점수');
ylabel('빈도수');

subplot(1,2,2);
histogram(data,10);
title('구간 수 = 10');
xlabel('점수');
ylabel('빈도수');

%문제 4번
clear; clc;
figure;

f = @(x) sin(x).*exp(-0.1*x);
fplot(f,[0,10*pi]);
title('f(x) = sin(x) e^{-0.1x}');
xlabel('x');
ylabel('f(x)');
grid on;

%문제 5번
clear; clc;
figure;

x = 0 : 0.1 : 10;
y1 = x.^2;
y2 = exp(0.5*x);

plotyy(x,y1,x,y2);
title('y1 = x^2  vs  y2 = e^{0.5x}');
xlabel('x');
y1 = x²은 다항식 증가로 완만하게 커지는 반면, y2 = e^(0.5x)는 지수적으로 빠르게 증가한다.
x가 커질수록 지수 함수의 증가 속도가 다항식보다 훨씬 빠르다.

%문제 6번
clear; clc;
figure;

t = 0:0.02:12*pi;
x = (1+0.03*t).*cos(t);
y = (1+0.03*t).*sin(t);
z = 0.2*t;

plot3(x,y,z);
title('원형나선형');
xlabel('x');
ylabel('y');
zlabel('z');
grid on;

%문제 7번
clear; clc;
figure;

[X, Y] = meshgrid(-4:0.1:4, -4:0.1:4);
Z = X.^2 - Y.^2;

mesh(X, Y, Z);
title('z = x^2 - y^2 (Saddle Surface)');
xlabel('x');
ylabel('y'); 
zlabel('z');
grid on;
z = x² - y²은 x 방향으로는 위로 볼록하고 y 방향으로는 아래로 볼록한 안장면(saddle surface) 형태를 가진다.
그래프의 중심(원점)이 최솟값도 최댓값도 아닌 안장점임을 mesh 그래프를 통해 확인할 수 있다.

%문제 8번
clear; clc;
figure;

[X, Y] = meshgrid(-2*pi:0.1:2*pi, -2*pi:0.1:2*pi);
Z = sin(X) .* cos(Y);

subplot(1,2,1);
mesh(X, Y, Z);
title('mesh: z = sin(x)cos(y)');
xlabel('x'); ylabel('y'); zlabel('z');

subplot(1,2,2);
contour(X, Y, Z, 20);
title('contour: z = sin(x)cos(y)');
xlabel('x'); ylabel('y');
colorbar;
contour 그래프는 z값이 같은 점들을 등고선으로 연결하여 함수의 최대·최솟값 위치, 값이 변하는 방향과 속도 등을 2D로 한눈에 파악할 수 있게 해준다.

%문제 9번
clear; clc;
figure;

t = 0:0.01:25;
y = exp(-0.15*t) .* cos(4*t);
env_up = exp(-0.15*t);
env_dn = -exp(-0.15*t);

% (a) 일반 plot
subplot(1,3,1);
plot(t, y);
title('y(t)');
xlabel('t'); ylabel('y');
grid on;

% (b) envelope 포함
subplot(1,3,2);
plot(t, y, t, env_up, 'r--', t, env_dn, 'r--');
title('envelope 포함');
xlabel('t'); ylabel('y');
legend('y(t)','위쪽 envelope','아래쪽 envelope');
grid on;

% (c) semilogy
subplot(1,3,3);
semilogy(t, abs(y));
title('|y(t)| (semilogy)');
xlabel('t'); ylabel('|y|');
grid on;
semilogy에서 |y(t)|는 완전히 직선이 되지 않고 cos 성분 때문에 진동하지만, 전체적인 감쇠 추세는 로그 스케일에서 직선으로 나타나 지수적 감쇠임을 확인할 수 있다.

%문제 10번
clear; clc;
figure;

[X,Y] = meshgrid(-6:0.1:6,-6:0.1:6);
Z = cos(X).*sin(Y).*exp(-0.05*(X.^2+Y.^2));

%(a)
subplot(1,2,1);
mesh(X,Y,Z);
title('mesh');
xlabel('x');
ylabel('y');
zlabel('z');
%(b)
subplot(1,2,2);
contour(X,Y,Z,20);
title('contour');
xlabel('x');
ylabel('y');
colorbar;
%(c)
[max_val, idx] = max(Z(:));        
[r, c] = ind2sub(size(Z), idx);  
fprintf('Z의 최대값: %.4f\n', max_val);
fprintf('위치: x = %.2f, y = %.2f\n', X(r,c), Y(r,c));

%문제 11번
clear; clc;
figure;

t = [0, 1, 2, 3, 4, 5, 6];
C = [12, 8.9, 6.6, 4.9, 3.6, 2.7, 2.0];

%(a)
subplot(1,2,1);
plot(t,C,'o-');
title('일반 plot');
xlabel('t');
ylabel('C');
grid on;
%(b)
subplot(1,2,2);
semilogy(t,C,'o-');
title('semilogy');
xlabel('t');
ylabel('C (log scale)');
grid on;
% (c) k 추정: log(C) = log(C0) - k*t 선형 관계 이용
p = polyfit(t, log(C), 1); % 1차 다항식 피팅
k = -p(1);                  % 기울기의 음수 = k
C0 = exp(p(2));             % y절편의 exp = C0
fprintf('추정된 k  = %.4f\n', k);
fprintf('추정된 C0 = %.4f\n', C0);

%문제 12번
clear; clc;
figure;

n = 1:1:30;
T1 = n;             
T2 = n .* log(n);   
T3 = n.^2;          
T4 = 2.^n;          

%(a) 일반 plot
subplot(1,2,1);
plot(n, T1, n, T2, n, T3, n, T4);
title('알고리즘 복잡도 비교 (일반)');
xlabel('n'); ylabel('T(n)');
legend('n','n\cdotlog(n)','n^2','2^n');
grid on;

%(b) semilogy
subplot(1,2,2);
semilogy(n, T1, n, T2, n, T3, n, T4);
title('알고리즘 복잡도 비교 (semilogy)');
xlabel('n'); ylabel('T(n) (log scale)');
legend('n','n\cdotlog(n)','n^2','2^n');
grid on;
일반 그래프에서는 2^n 값이 폭발적으로 커져서 나머지 세 함수(n, nlogn, n²)가 거의 0처럼 보여 구분이 불가능하다. semilogy에서는 각 함수가 서로 다른 기울기의 직선으로 나타나므로 성장률 비교에 더 적절하다.

%문제 16번
clear; clc;
figure;

t = 0:0.01:24;
T = 15 + 10*sin(pi*t/12);

plot(t, T);
title('하루 온도 변화');
xlabel('시간 (h)'); ylabel('온도 (°C)');
grid on;

% 최고/최저 표시
[T_max, idx_max] = max(T);
[T_min, idx_min] = min(T);

hold on;
plot(t(idx_max), T_max, 'rv', 'MarkerSize', 10);
plot(t(idx_min), T_min, 'b^', 'MarkerSize', 10);

%문제 17번
clear; clc;
figure;

t = 0:0.01:20;
v = 5*exp(-0.2*t);

%(1)
subplot(1,2,1);
plot(t, v);
title('(1) v(t) = 5e^{-0.2t}');
xlabel('t'); ylabel('v');
grid on;

%(2)
subplot(1,2,2);
semilogy(t, v);
title('(2) v(t) semilogy');
xlabel('t'); ylabel('v (log scale)');
grid on;
%(3)
일반 plot에서는 초반에 급격히 감소하다가 후반엔 거의 0에 수렴해 변화량이 잘 보이지 않는다. semilogy에서는 지수 감소가 직선으로 나타나므로 전체 구간에서 감소 속도를 명확하게 확인할 수 있다.

%문제 18번
clear; clc;

A = [4 -1 2; 1 3 -1; 2 -2 5];
b = [7;4;10];

%(a)
A1 = A^2;
A2 = A.^2;
disp('A^2:'); disp(A1);
disp('A.^2:'); disp(A2);
A^2은 행렬 거듭제곱(행렬곱), A.^2은 원소별 제곱이므로 결과가 다르다.

%(b) 행렬식
d = det(A);
fprintf('det(A) = %g\n',d);
disp('det(A) ≠ 0 이므로 역행렬이 존재한다.');

%(c)
x1 = inv(A)*b;
x2 = A\b;
disp('inv(A)*b:'); disp(x1);
disp('A\b:');      disp(x2);
inv(A)*b와 A\b의 결과가 모두 [1.0465, 1.7442, 2.2791]로 동일하다. 매트랩에서는 A\b으로 쓰는게 더 적절하다.
%(d)
x = A\b;
disp('연립방정식 Ax = b의 해:');
disp(x);

%문제 19번
clear; clc;

A = [2 -1; 3 4];
B = [1 0 -2; 3 5 1];
C = [6 -3 4; 15 14 -1];

% (a) AX = C - B 형태로 변형 후
AX + B = C 에서 양변에서 B를 빼면 AX = C - B 형태로 변형된다.
% (b)
X = A \ (C - B);
disp('X ='); disp(X);

% (c)
check = A*X + B;
disp('AX + B (검증):'); disp(check);
disp('C (원래 값):');   disp(C);

% (d) A\(C-B)를 사용하는 이유:
inv(A)를 명시적으로 계산하면 수치 오차가 누적될 수 있고 느림
A\(C-B)는 LU 분해 기반으로 더 안정적이고 빠름

%문제 20번
clear; clc;

X = [3 7 2 5; 5 9 4 6; 8 12 7 10; 10 15 9 13; 14 18 12 16];

% (a)
col_mean = mean(X);
disp('각 열의 평균:'); disp(col_mean);

% (b)
Xc = X - mean(X);
disp('중심화 행렬 Xc:'); disp(Xc);

% (c)
S = Xc' * Xc;
disp('S = Xc''*Xc:'); disp(S);

% (d) 대각원소: 각 변수의 제곱합 → 분산에 비례 (변동 크기)
%     비대각원소: 두 변수 간의 교차곱합 → 공분산에 비례 (선형 관계)
disp('대각원소: 각 열의 분산에 비례 / 비대각원소: 두 열 간 공분산에 비례');

%% 1번 문제

% 근 구하기
root1 = fzero(@sjy_24013841_func_1, 0);
root2 = fzero(@sjy_24013841_func_1, 1.0);

% 최솟값 구하기
x_min = fminbnd(@sjy_24013841_func_1, 0, 4);
f_val = sjy_24013841_func_1(x_min);

% 그래프
figure %그래프 겹쳐서 추가
fplot(@sjy_24013841_func_1, [0,4])
hold on
plot(root1, 0)
plot(root2, 0)
plot(x_min, f_val)
grid on
xlabel('x')
ylabel('f(x)')
title('f(x) = 0.3x - sin(2x)')
legend('f(x)', '근', '', '최솟값')

% 결과 출력
fprintf('근: %.4f, %.4f\n', root1, root2)
fprintf('최솟값: x = %.4f 에서 f(x) = %.4f\n', x_min, f_val)

% 전역 최솟값 증명
x_min1 = fminbnd(@sjy_24013841_func_1, 0, 2);
f_val1 = sjy_24013841_func_1(x_min1);

x_min2 = fminbnd(@sjy_24013841_func_1, 2, 4);
f_val2 = sjy_24013841_func_1(x_min2);

fprintf('구간 [0,2] 최솟값: f(%.4f) = %.4f\n', x_min1, f_val1)
fprintf('구간 [2,4] 최솟값: f(%.4f) = %.4f\n', x_min2, f_val2)
fprintf('둘 중 더 작은 값이 전역 최솟값\n')

%% 2번 문제
h = 100;
v0 = 50;
g = 9.81;
t = sjy_24013841_func_2(h, v0, g);
fprintf('t1 = %.4f초 → 올라가면서 처음으로 100m 통과\n', t(1))
fprintf('t2 = %.4f초 → 최고점 후 내려오면서 두번째로 100m 통과\n', t(2))

%% 3번문제

%(a)
% h = 3V / (pi*r^2)
% A = pi*r*sqrt(r^2 + (3V/(pi*r^2))^2)

%(b)(c)
%V = 10 in3에 대하여, fminbnd 함수를 사용하는 함수를 사용하여 면적 A를 최소화하는 r값을 계산하라.
global V
V =10;
r_min = fminbnd(@sjy_24013841_func_3, 0.1, 10);
A_min = sjy_24013841_func_3(r_min);
fprintf('최솟값 r = %.4f\n', r_min)
fprintf('최솟값 A = %.4f\n', A_min)
%상응하는 높이 h의 값은 얼마인가?
h_min = 3*V / (pi*r_min^2);
fprintf('상응하는 h = %.4f\n', h_min)
%r에 대한 A의 그래프를 그려서 해의 민감도를 조사하라.
figure %그래프 겹쳐서 추가
fplot(@sjy_24013841_func_3, [0.5, 4])
xlabel('r')
ylabel('A')
title('r에 대한 A의 그래프')
hold on
plot([0.5, 4], [A_min, A_min])
plot([0.5, 4], [A_min*1.1, A_min*1.1])

% 10% 증가 전까지 r 범위
f_10 = @(r) sjy_24013841_func_3(r) - A_min*1.1;
r_left = fzero(f_10, 0.1);
r_right = fzero(f_10, 3);
fprintf('r 범위: %.4f ~ %.4f\n', r_left, r_right)
fprintf('최적값에서 왼쪽으로 %.4f 벗어남\n', r_min - r_left)
fprintf('최적값에서 오른쪽으로 %.4f 벗어남\n', r_right - r_min)

%% 4번문제
figure %그래프가 겹쳐서 추가
f = @(x) 10*exp(-2*x);
fplot(f, [0, 2])
xlabel('x')
ylabel('f(x)')
title('f(x) = 10e^{-2x}')

%% 5번문제
f = @(x) 30*x.^2 - 300*x + 4;
%(a)함수 그리기
figure %그래프 겹쳐서 추가
fplot(f,[0,10])
xlabel('x')
ylabel('f(x)')
title('f(x) = 30x^2 - 300x + 4')
%(b)최솟값 구하기
x_min = fminbnd(f,0,10);
f_min = f(x_min);
fprintf('최솟값의 위치: x = %.4f\n',x_min)
fprintf('최솟값: f(x) = %.4f\n',f_min)

%% 6번문제
figure %그래프 겹쳐서 추가
h = @(z) 6*exp(z);
g = @(y) 3*cos(y);
f = @(x) x.^2;
c = @(x) h(g(f(x)));
fplot(c,[0,4])
xlabel('x')
ylabel('y')
title('6e^{3cos(x^2)}')

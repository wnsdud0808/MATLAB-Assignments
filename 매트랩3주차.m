%문제 1번
A = [1 4 2;2 4 100; 7 9 7; 3 pi 42];
B = log(A);
%a1 B의 두번째 행을 선택하라.
a1_1 = B(2,:)
%a2 B의 두번째 행의 합을 구하라.
a1_2 = sum(B(2,:))
%a3 B의 두번째 열과 A의 첫번째 열의 원소별 곱을 구하라.
a1_3 = B(:,2).*A(:,1)
%a4 위 결과 벡터의 최대값을 구하라.
a1_4 = max(a1_3)
%a5 원소별 나눗셈을 사용하여 A의 첫번째 행을 B의 세번째 열의 처음 세 원소로 나누고, 결과 벡터의 합을 구하라.
a1_5 = sum(A(1,:) ./ B(1:3, 3)')

%문제2번
v0 = 50;
A = 50; %50도
g = 9.81;
%충돌시간 t_hit 과 y_max
%t_hit
t_hit = (2*v0*sind(A)/g)
%y_max
t_mid = t_hit / 2;
y_max = (v0 * sind(A)) * t_mid - 0.5 * g * t_mid^2 
% 0 ≤ t ≤ thit 구간에서 x 대 y 그래프를 그려라.
t = 0 : 0.01 : t_hit;
x = (v0 * cosd(A)) * t;
y = (v0 * sind(A)) * t - 0.5 * g * t.^2;
plot(x,y)
xlabel('수평 거리 x (m)');      % x축 이름
ylabel('수직 높이 y (m)');      % y축 이름

%문제3번
x = -2:0.01:16;
y = (4*cos(x))./(x+exp(-0.75*x));
plot(x,y)
xlabel('x')
ylabel('f(x)')
title('함수 f(x)의 그래프')

%문제4번
%a1 5x3소비 행렬을 생성하라
a4_1 = [5 4 6;3 2 4;6 5 3;3 5 4;2 4 3]
%각 달의 총 소비량을 구하라
a4_2 = sum(a4_1)
%3개월 동안 각 재료별 총 소비량을 구하라.
a4_3 = sum(a4_1,2)
%전체 기간 동안의 총 소비량을 구하라
a4_4 = sum(a4_1,"all")

%문제5번
y1 = [5 0 -3 7 10];
y2 = [4 -7 9 2];
a5_1 = conv(y1,y2)
%몫과 나머지를 구하라
y1 = [5 -7 2 8];
y2 = [6 3 -2];
[a5_q,a5_r] = deconv(y1,y2) %a5_q = 몫, a5_r = 나머지
%x=5 일때 값을 구하라

y1 = [36 -8 0 2];
y2 = [36 -5 4 -3];
y1_num = polyval(y1,5); %y2_num = 분모
y2_den = polyval(y2,5); %y2_den = 분자
a5_3 = y1_num / y2_den

%6번문제 구조체배열
%1번다리
bridge(1).location = "Smith St.";
bridge(1).max_load = 80;
bridge(1).year_built = 1928;
bridge(1).maintenance_year = 2025;
%2번다리
bridge(2).location = "Hope Ave.";
bridge(2).max_load = 90;
bridge(2).year_built = 1950;
bridge(2).maintenance_year = 2027;
%3번다리
bridge(3).location = "Clark St.";
bridge(3).max_load = 85;
bridge(3).year_built = 1933;
bridge(3).maintenance_year = 2024;
%4번다리
bridge(4).location = "North Rd.";
bridge(4).max_load = 100;
bridge(4).year_built = 1960;
bridge(4).maintenance_year = 2023;
%(b) 문제 (a)에서 생성한 구조체 배열 요소 중 Clark St. 다리의 유지기한을 2024년에서 2026 년으로 수정하라.
bridge(3).maintenance_year = 2026;
%(c) 다음 다리 정보를 문제 (a)에서 생성한 구조체 배열에 추가하라.
bridge(5).location = "Shore Rd.";
bridge(5).max_load = 85;
bridge(5).year_built = 1997;
bridge(5).maintenance_year = 2022;

struct2table(bridge)

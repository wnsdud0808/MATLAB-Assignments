% 5번 문제: 거리 x에 따른 속도 u, v 그래프 작성
x = 0:0.01:2;
u = 3 * log10(70*x + 1);
v = 4 * cos(7*x);
plot(x, u, 'b-'); % -는 실선
hold on;          % 함수 2개가 같이 그려져야하니 hold on
plot(x, v, 'r--'); % --는 점선
hold off;
xlabel('거리 (mile)');
ylabel('속도 (mile/hr)');
legend('u (속도)', 'v (속도)');


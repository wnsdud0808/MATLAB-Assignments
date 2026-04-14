%%문제 1번
clear; clc;
x = input('실수 x를 입력하세요: ');
if x>0
    y = x^2;
else y = 0;
end
fprintf('y = %g\n',y);

%%문제 2번
clear; clc;
m = input('정수 m의 범위를 입력하세요 (1~4): ');
switch m
    case 1
        disp('January');
    case 2
        disp('February');
    case 3
        disp('March');
    case 4
        disp('April');
    otherwise
        disp('invalid month');
end

%%문제 3번
clear; clc;
x = [3 -5 0 8 -2 4 -7];
count = 0;
for i = 1:length(x)
    if x(i)<0
        count = count + 1;
    end
end
fprintf('음수 원소의 개수: %d\n',count);

%%문제 4번
clear; clc;
x = [4 -9 0 16 -1 25];
y = zeros(1,length(x));

for i = 1:length(x)
    if x(i)>0
        y(i) = sqrt(x(i));
    elseif x(i) == 0
        y(i) = 0;
    else
        y(i) = abs(x(i));
    end
end
disp(y)

%%문제 5번
clear; clc;
a = input('a를 입력하세요: ');
b = input('b를 입력하세요: ');
cmd = input('명령어를 입력하세요(add/sub/mul/div): ','s');
switch cmd
    case 'add'
        fprintf('결과: %g\n',a+b)
    case 'sub'
        fprintf('결과: %g\n',a-b)
    case 'mul'
        fprintf('결과: %g\n',a*b)
    case 'div'
        if b == 0
            disp('division by zero')
        else fprintf('결과: %g\n',a/b)
        end
    otherwise 
        disp('invalid command');
end

%%문제 6번
clear; clc;
N = input('양의 정수 N을 입력하세요: ');
total = 0;
for k = 1:N
    if mod(k,3) == 0 && mod(k,2) ~= 0
        total = total + k;
    end
end
fprintf('합: %d\n',total);

%%문제 7번
clear; clc;
N = input('양의 정수 N을 입력하세요: ');
a = zeros(1,N);
for k = 1:N
    if mod(k,2) ~= 0
        a(k) = k^2;
    else 
        a(k) = k^3;
    end
end
disp(a);

%%문제 8번
clear; clc;
price = [19 18 22 21 25 19 17 21 27 29];
shares = 1000; %처음 보유한 주식수
spent = 0; %구매에 사용한돈
earned = 0; %판매로 얻은 돈

for i = 1:10
    if price(i) < 20
        shares = shares + 100;
        spent = spent + 100 * price(i);
    elseif price(i) > 25
        shares = shares - 100;
        earned = earned + 100 * price(i);
    end
end
portfolio_gain = shares * price(10) - 1000 * price(1);

fprintf('(a) 주식 구매에 소비한 금액: $%g\n', spent);
fprintf('(b) 주식 판매로 얻은 금액: $%g\n', earned);
fprintf('(c) 10일 후 보유 주식 수: %d주\n', shares);
fprintf('(d) 포트폴리오 총 가치 증가분: $%g\n', portfolio_gain);

%%문제 9번
clear; clc;
conn = input('연결 형태를 입력하세요 (직렬/병렬): ', 's');
n = input('저항의 개수를 입력하세요: ');
R_vals = zeros(1, n);
for i = 1:n
    R_vals(i) = input('저항값을 입력하세요: ');
end

switch conn
    case '직렬'
        R = sum(R_vals);
        fprintf('직렬 등가 저항: %g Ω\n', R);
    case '병렬'
        R = 1 / sum(1 ./ R_vals);
        fprintf('병렬 등가 저항: %g Ω\n', R);
    otherwise
        disp('invalid input');
end

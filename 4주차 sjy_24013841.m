%1번 문제 함수
function y = sjy_24013841_func_1(x)
y = 0.3*x - sin(2 * x);
end

%2번문제 함수
function t = sjy_24013841_func_2(h, v0, g)
f = @(t) v0*t - 0.5*g*t.^2 - h;
t1 = fzero(f, 0.1);
t2 = fzero(f, 10);
t = [t1, t2];
end

%3번문제 함수
function A = sjy_24013841_func_3(R)
global V
h = 3*V ./ (pi*R.^2);
A = pi*R.*sqrt(R.^2 + h.^2);
end

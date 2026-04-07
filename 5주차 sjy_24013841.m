%1번문제
%실행코드
x = [-2 -1 0 1 2];
%1-1 각원소의 제곱
result1 = squareVec(x)
%1-2 평균을 반환하는 함수
result2 = meanVec(x)
%1-3 새 벡터를 반환하는 함수
result3 = mixedTransform(x)

%함수 정의
%1-1
function out = squareVec(x)
out = x.^2;
end
%1-2
function out = meanVec(x)
out = mean(x);
end
%1-3
function out = mixedTransform(x)
out = x;
out(x < 0) = abs(x(x<0));
out(x == 0) = 0;
out(x > 0) = 2*x(x>0) + 1;     
end

%2번문제
%2-1 이름 입력받기
name = input('학생 이름을 입력하세요: ','s');
%2-2 성적 입력
score = input('국어, 영어, 수학 점수를 입력하세요 (예: [88 92 79]): ');
%2-3 입력받은 세 점수의 평균을 계산하고, 다음 내용을 출력하시오
avg = mean(score);
fprintf('이름: %s\n',name);
fprintf('세 과목 점수: %d %d %d\n', score(1), score(2), score(3)); 
fprintf('평균: %.2f\n',avg);
%2-4
if avg >= 90
    fprintf('Excellent\n');
elseif avg >= 80
    fprintf('Good\n');
elseif avg >= 70
    fprintf('Fair\n');
else
    fprintf('Needs Improvement\n');
end

%3번문제 1열 키 2열 시험점수 3열 면접통과여부 1=통과 0=탈락
applicants = [165 72 1;
              172 85 0;
              168 91 1;
              181 77 1;
              174 69 0;
              169 88 1;];
%3-1 키가 170 이상인 지원자에 대한 논리 배열을 구하시오.
tall = applicants(:,1) >= 170 
% 3-2 시험점수가 80 이상인 지원자에 대한 논리 배열을 구하시오.
score = applicants(:,2) >= 80 
%3-3 면접까지 통과한 지원자에 대한 논리 배열을 구하시오
pass = applicants(:,3) == 1 
%3-4
finalIdx = find(tall & score & pass)
%3-5최종 합격자의 행 번호, 키, 시험점수, 면접통과 여부를 하나의 행렬로 만들어 출력
final = [finalIdx, applicants(finalIdx, :)]



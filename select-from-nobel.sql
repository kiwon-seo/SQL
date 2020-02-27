/*
SQL (BY SQLZOO)

CHAPTER2
SELECT from nobel

# Data 설명
nobel이라는 table 
column은 yr(수상연도), subject(분야), winner(수상자)

*/
--#14
/*
The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
Show the 1984 winners ordered by subject and winner name; but list Chemistry and Physics last.

Q) subject IN // 1984년의 수상자들을 열거하는데 Chemistry 와 Physics 분야는 마지막에 배치 

*/
SELECT winner, subject, subject IN ('Physics','Chemistry')
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'),subject,winner


*/
Point
1. Subject 칼럼이 존재할 때 Subject IN () 을 하게되면 있으면 1, 없으면 0의 데이터가 나오게 된다.
따라서 ORDER BY subject  IN ('Physics','Chemistry')을 하게 되면 Physics,Chemistry는 1의 데이터가 되므로
뒤에 배열되는 것이다.

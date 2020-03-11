/*
Eighth section of sqlzoo, Using NULL
*/

--#1
/*
List the teachers who have NULL for their department.
Q) 선생님의 부서가 NULL 값인 명단을 보여라.
*/
SELECT name
FROM teacher
WHERE dept IS NULL

POINT
1. WHERE dept IS NULL
WHERE (X) IS NULL 절로 공백인 행 추출


##### Left,Right,Outer,Inner JOIN 설명 중요!~!~!
Inner- 두 테이블의 교집합 (그냥 JOIN이 INNER JOIN)
Left- 왼쪽에 있는 모든 행과 오른쪽에 함께 있는 행을 얻는다
Light- Left의 반대
full outer- 왼쪽과 오른쪽의 합집합

#####
--#2
/*
Note the INNER JOIN misses the teacher with no department and the department with no teacher
*/
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
           
POINT
1. INNER JOIN이므로 teacher, dept 모두 교집합인 행만 

--#3
/*
Use a different JOIN so that all teachers are listed.
*/
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
          ON (teacher.dept=dept.id)

POINT
1. LEFT JOIN이므로 왼쪽 열인 teacher의 모든 행은 추출되며 오른쪽의 dept의 행은 해당 없으면 null값으로 기록.


--#5
##### COALESCE 설명 
COALESCE(x,y,z) = x if x is not NULL
COALESCE(x,y,z) = y if x is NULL and y is not NULL
COALESCE(x,y,z) = z if x and y are NULL but z is not NULL
COALESCE(x,y,z) = NULL if x and y and z are all NULL
/*
Use COALESCE to print the mobile number. Use the number '07986 444 2266' there is no number given. Show teacher name and mobile number or '07986 444 2266'
*/
SELECT name, COALESCE(mobile, '07986 444 2266')
FROM teacher

POINT
1. COALESCE 구문을 사용해서 선생님들 중에 mobile이 공란은 '07986 444 2266'로 자동 치환

--#6
/*
Use the COALESCE function and a LEFT JOIN to print the name and department name. Use the string 'None' where there is no department.
Q) COALESCE를 사용해 모든 선생님의 이름,부서를 보이는데 부서가 안적혀있으면 'None'으로 바꿔라.
*/
SELECT teacher.name, COALESCE(dept.name,'None') FROM teacher 
LEFT JOIN dept ON(teacher.dept= dept.id)

POINT
1. COALESE 사용해서 dept의 name이 없으면 'None'으로 자동 치환
2. LEFT JOIN 사용해서 teacher의 모든 행 추출


--#10
/*
Use CASE to show the name of each teacher followed by 'Sci' if the the teacher is in dept 1 or 2 show 'Art' if the dept is 3 and 'None' otherwise.
*/
SELECT teacher.name,
CASE
WHEN dept.id = 1 THEN 'Sci'
WHEN dept.id = 2 THEN 'Sci'
WHEN dept.id = 3 THEN 'Art'
ELSE 'None' END
FROM teacher LEFT JOIN dept ON (dept.id=teacher.dept)

POINT
1.CASE WHEN dept.id = 1 THEN 'Sci'
       WHEN dept.id = 2 THEN 'Sci'
       WHEN dept.id = 3 THEN 'Art'
ELSE 'None' END

CASE는 한번만 쓰는것!

마지막은 END로 꼭 끝낼 것!

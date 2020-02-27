SQL (BY SQLZOO)

CHAPTER1
SELECT from world

# Data 설명
world라는 table
column은 name(나라이름), continent(대륙), area(크기), population(인구수),	gdp(국내총생산)


--#6
/*
Q) '%'문제로 United라는 단어가 포함된 국가
*/
SELECT name
FROM world
WHERE name LIKE '%united%'

Point
1.'%abc' --> abc로 끝나는 단어
2.'abc%' --> abc로 시작하는 단어
3.'%abc%'--> abc를 포함한 단어

문자이기 때문에 양쪽에 ''를 써야하는 것을 잊지말자!!


--#8
/*
Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) 
or big by population (more than 250 million) but not both. 
Show name, population and area.

Q) XOR 문제로 big area XOR big population 을 푸는 문제이다.

*/
SELECT name,population,area FROM world
WHERE population >250000000 XOR area > 3000000

--#9
/*
Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. 
Use the ROUND function to show the values to two decimal places.
For South America show population in millions and GDP in billions to 2 decimal places.

Q) ROUND 함수를 쓰는 문제로 소수점을 반올림할때 사용된다.
*/
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America'

Point
1.ROUND(데이터,끝자릿수를 나타냄)

EX) 
1.ROUND(데이터,2)  --> 109.3578788.....을 109.36 처럼 3번째 소수점에서 반올림한다.(소수점 2번째까지 나타냄)
2.ROUND(데이터,0)  --> 109.3578788.....을 109처럼 1번째 소수점에서 반올림한다.
3.ROUND(데이터,-1) --> 109.3578788.....을 110처럼 1의자리에서 반올림한다.


--#12
/*
Show the name and the capital where the first letters of each match. 
Don't include countries where the name and the capital are the same word.

Q) LEFT & <> 문제로 name의 첫글자와 capital의 첫글자가 같지만 동일하지는 않은 나라를 보여라.

*/
SELECT name, capital FROM world
WHERE LEFT(name,1)=LEFT(capital,1) and name <> capital

Point
1.LEFT(데이터,n) --> 왼쪽에서 n만큼의 글자를 가져옴.
2.<> --> not equal을 의미함.


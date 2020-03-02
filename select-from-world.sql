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


/*
SQL (BY SQLZOO)
CHAPTER4
SELECT from SELECT
*/
--#3
/*
List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
Q) 아르헨티나,호주인 대륙의 나라들을 보여라. (Order by name)
*/
SELECT name FROM world
WHERE continent='europe' and (gdp/population) > (select gdp/population from world where name='united kingdom')

Point
1. (SELECT ~~~) --> SELECT 문 자체를 조건으로 만들어버리는 것.
위의 예가 아르헨, 호주인 나라의 대륙들이라는 집합을 만든것임.


--#7
/*
Find the largest country (by area) in each continent, show the continent, the name and the area:

Q) 각 Continent마다 가장 area가 큰 나라의 continent,name,area를 보여라.
*/
SELECT continent, name, area
FROM world x
WHERE area >= ALL
    (SELECT area FROM world y
    WHERE y.continent=x.continent
    AND area>0)

Point
1. world.x / world.y
world를 2가지로 나누어서 contintent가 같은 조건을 만들어줌.

2. ALL연산자
값을 서브쿼리에 의해 리턴되는 모든 값과 조건값을 비교하여 모든 값을 만족해야만 참이다.

--#8
/*
List each continent and the name of the country that comes first alphabetically.

Q) 각 대륙에서 알파벳순서 처음으로 오는 나라와 그 대륙을 보여라.
*/

SELECT continent, name
FROM world x
WHERE name <= ALL(SELECT name FROM world y WHERE y.continent = x.continent)

Point
1. 문자열을 부등호 처리하면 알파벳 순으로 계산함! ex) korea > america
2. world를 2가지로 나누어 continent가 같은 조건을 만들어줌

--#9
/*
Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents. Show name, continent and population.

Q) 모든 국가가 25000000 보다 작은 Population인 대륙을 찾아라. 그리고 이 대륙과 연관된 나라의 이름, continent,population을 보여라.
*/
SELECT name, continent, population
FROM world x
WHERE 25000000  > ALL(SELECT population FROM world y WHERE x.continent = y.continent AND y.population > 0)

Point
1.


--#10
/*
Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.

Q) 같은 대륙내의 어떤 나라보다 3배 이상의 Population인 나라의 이름과 continent를 보여라. 
*/
SELECT name, continent
FROM world x
WHERE population > ALL(SELECT population*3 FROM world y WHERE x.continent = y.continent AND population > 0 AND y.name != x.name)

                                            
   
                                            
                                            
                                            
                                                              


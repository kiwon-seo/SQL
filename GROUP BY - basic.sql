Using GROUP BY and HAVING.


GROUP BY 구문은 SUM ,COUNT 와 같이 GROUP 별 적용하기 위해 사용된다. 
HAVING 구문은 display되는 group에 filtering하기위해 사용된다. 

#1. For each continent show the number of countries

SELECT continent, count(name) FROM world
GROUP BY continent

continent 별로 국가의 수를 count

#2. For each continent show the total population

SELECT continent, SUM(population) from world
GROUP BY continent

continent 별로 인구의 수를 sum

point
1. sum 과 count의 차이점
- sum은 수를 더하는 것. ex) 미국 인구:10000, 한국 인구:3000 ..... sum 하면 13000~ 이렇게 되는 것.
- count는 개수를 더하는 것. ex) 미국,한국,영국,일본,중국,..... count 하면 5개~ 이렇게 되는 것.

#3. WHERE and GROUP BY. The WHERE filter takes place before the aggregating function. 
For each relevant continent show the number of countries that has a population of at least 200000000.

SELECT continent , count(name) from world
WHERE population >200000000
GROUP BY continent

#4.GROUP BY and HAVING. The HAVING clause is tested after the GROUP BY. You can test the aggregated values with a HAVING clause. 
Show the total population of those continents with a total population of at least half a billion.

SELECT continent,sum(population) from world
GROUP BY continent
HAVING sum(population) > 1000000000/2

point
1.쿼리의 처리 순서
SELECT
FROM
WHERE           --1
GROUP BY        --2
HAVING          --3
ORDER BY        --4

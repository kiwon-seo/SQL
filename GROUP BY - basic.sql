Using GROUP BY and HAVING.


GROUP BY 구문은 SUM ,COUNT 와 같이 GROUP 별 적용하기 위해 사용된다. 
HAVING 구문은 display되는 group에 filtering하기위해 사용된다. 

#1. For each continent show the number of countries

SELECT continent, count(name) FROM world
GROUP BY continent


#2. For each continent show the total population

SELECT continent, SUM(population) from world
GROUP BY continent

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

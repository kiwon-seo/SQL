/*
Sixth section of sqlzoo, Join
*/
Data 설명
# 
1) table game (경기 정보)
id(=goal table의 matchid)	mdate: 경기날짜 stadium: 경기장소	team1: 팀1	team2: 팀2

2) table goal (골 넣은 정보)
matchid(=game table의 id)	teamid: 골 넣은 선수의 팀	player: 골 넣은 선수의 이름	gtime: 골 넣은 시간

3) eteam (유로팀 정보)
id: 팀의 약자(ex: poland -> POL)	 teamname: 국가 이름	coach: 그 국가의 코치


--#3
/*
You can combine the two steps into a single query with a JOIN. 

SELECT *
  FROM game JOIN goal ON (id=matchid)
Show the player, teamid and mdate and for every German goal. teamid='GER'

*/
SELECT player, teamid, mdate
FROM game
  JOIN goal ON (game.id=goal.matchid AND teamid='GER')

POINT
1. JOIN 문을 활용하여 TABLE을 묶을 수 있다.
2. ON() 을 붙여서 어떤 열을 공통 기준으로 묶을 것인지를 정해줘야 한다.
3. 여기서는 game의 id랑 goal의 matchid랑 같게 묶어준다. -> game.id=goal.matchid


--#8
/*
The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.

Q) 독일을 상대로 넣은 모든 선수를 보여라.
*/
SELECT DISTINCT(player)
FROM game
  JOIN goal ON matchid = id
WHERE ((team1='GER' OR team2='GER') AND teamid != 'GER')

POINT
1. DISTINCT()를 사용함으로써 중복되는 선수의 이름을 삭제한다.
2. WHERE ((team1='GER' OR team2='GER') AND teamid != 'GER')
(team1='GER' OR team2='GER')을 하나의 조건으로 만들어줌 by using () -> team1,2 둘 중 하나에 GER가 있도록 하는 조건.

--#13
/*
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0.
You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/
SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 
       FROM game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate,team1,team2
    ORDER BY mdate, matchid, team1, team2
    
    
POINT
1. CASE   WHEN 구문
CASE WHEN condition1 THEN value1  -> Condition1 일때 value1값으로
       WHEN condition2 THEN value2  -> Condition2 일때 value2값으로
       ELSE def_value  -> Condition1,2 모두 아닐때 'def_value'로
  END  -> 마무리로 end를  꼭 써줘야한다.

2. case when ~~~ AS X -> CASE의 COLUMN명을 X라 지정.


EX) SELECT name, population
      ,CASE WHEN population<1000000 
            THEN 'small'
            WHEN population<10000000 
            THEN 'medium'
            ELSE 'large'
       END 
  FROM bbc
  
 
 ####### MORE JOIN
 
 Data 설명
# 
1) movie
id	title(영화제목)	yr(연도)	director(감독)	budget(예산)	gross ( 관객수)


2) actor
id(배우번호)	name(배우이름) 

3) casting
movieid(=movie.id)	actorid(=actor.id)	ord(cast list의 번호. 예를 들어  ord가 1이라면 cast list의 1번이란 뜻으로 주연배우란 뜻)

--#9
/*
List the films in which 'Harrison Ford' has appeared
Q) 해리슨 포드가 출연한 영화를 보여라
*/

SELECT title FROM casting JOIN actor on(actor.id=casting.actorid)
JOIN movie on(movie.id=casting.movieid)
WHERE actorid= (SELECT actor.id FROM actor WHERE name='Harrison Ford')

POINT
1. JOIN 문을 2개 써서 3개의 TABLE을 다 묶어버림.

--#10
/*
List the films where 'Harrison Ford' has appeared - but not in the star role.
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

Q) 해리슨 포드가 출연한 영화 중 STAR ROLE이 아닌 영화는?? STAR ROLE-> ORD=1
*/

마지막에 + 조건으로 WHERE ORD !=1 만 붙이면 된다.

--#12 Difficult!!!Difficult!!!Difficult!!!Difficult!!!Difficult!!!Difficult!!!Difficult!!!Difficult!!!Difficult!!!
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/
SELECT title, name FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting y
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews')

POINT
1. Casting을 x,y로 나누어서 이해하기 쉽게 조건 설정한것.

12번부터 해야할것 같다......




                                             

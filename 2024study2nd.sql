SELECT * from rest_area_animal;
SELECT * from rest_area_score;
SELECT * from rest_area_wifi;
SELECT * from rest_area_restroom;
SELECT * from rest_area_parking;

-- 고속도로 휴게소의 규모와 주차장 현황을 함께 출력 (휴게소명, 시설구분, 합계 , 대형, 소형, 장애인)
SELECT * from rest_area_score;
SELECT * from rest_area_parking ;
-- 휴게소명,시설구분 -> score // 합계,대형,소형, 장애인 -> parking 
-- 공통 -> 휴게소명
SELECT a.휴게소명,a.시설구분, b.합계, b.대형, b.소형, b.장애인
	from rest_area_score a left outer join rest_area_parking b on a.휴게소명 = b.휴게소명 

-- 1-1 다르게 푸는 법.
SELECT score.휴게소명,score.시설구분, parking.합계, parking.대형, parking.소형, parking. 장애인
from rest_area_score as score, rest_area_parking as parking
WHERE score.휴게소명 = parking.휴게소명


-- 2번 휴게소규모와 화장실 현황 (휴게소명, 시설구분, 남자_변기수, 여자_변기수)
SELECT * from rest_area_restroom ;
SELECT * from rest_area_score 

SELECT a.휴게소명,a.시설구분, b.남자_변기수, b.여자_변기수
	from rest_area_score a left outer join rest_area_restroom  b on a.휴게소명 = b.시설명 

-- 2-1 다르게 푸는법 뭐가 다르지? 왜 이렇게 해야하지 그냥 다른건가?
SELECT score.휴게소명, score.시설구분, restroom.남자_변기수, restroom.여자_변기수
from rest_area_score as score, rest_area_restroom as restroom 
where score.휴게소명 = restroom.시설명

 
-- 3번 고속도로 휴게소의 규모, 주차장, 화장실 현황을 함께 출력(휴게소명, 시설구분, 합계, 남자_변기수, 여자 변기수)
SELECT * from rest_area_score ;
SELECT * from rest_area_parking  ;
SELECT * from rest_area_restroom  ;

SELECT t.휴게소명, t.시설구분, p.합계, t.남자_변기수, t.여자_변기수 from
(SELECT a.휴게소명,a.시설구분, b.남자_변기수, b.여자_변기수
	from rest_area_score a left outer join rest_area_restroom  b on a.휴게소명 = b.시설명 
) t  LEFT OUTER JOIN rest_area_parking p ON t.휴게소명 = p.휴게소명

-- 이런식으로 from절에서 한꺼번에 table을 3개 엮을 수도 있음. 그래서 where절에서 and 조건을 2개걸면 됨.
SELECT score.휴게소명, score.시설구분, parking.합계,restroom.남자_변기수, restroom.여자_변기수
	from rest_area_score as score, rest_area_restroom as restroom, rest_area_parking as parking 
		where score.휴게소명 = restroom.시설명 and score.휴게소명=parking.휴게소명

-- 4번 휴게소 규모별로 주차장수 합계의 평균, 최소값, 최대값 출력		
SELECT s.시설구분,
		avg(p.합계),
		min(p.합계),
		max(p.합계)
		from rest_area_score s, rest_area_parking p
		WHERE s.휴게소명 = p.휴게소명
	group by s.시설구분
		
SELECT score.시설구분 , avg(parking.합계),min(parking.합계),max(parking.합계) from rest_area_score as score
inner join rest_area_parking as parking
on score.휴게소명 = parking.휴게소명 
group by score.시설구분

-- 이런식으로 어떤것을 groupby식으로 값을 구할 때는 윈도우함수를 활용해서 풀 수도 있음.
		
SELECT a.휴게소명, a.시설구분,
	avg(b.합계) over (partition by a.시설구분) as average,
	min(b.합계) over (partition by a.시설구분) as minimum,
	max(b.합계) over (partition by a.시설구분) as maximum 
from rest_area_score a inner join rest_area_parking b
	on a.휴게소명 = b.휴게소명 

	
-- 5번 만족도별로 대형 주차장수가 가장 많은 휴게소만 출력 ## 다시풀어봐야할 문제! rank에 대해서! 
-- 윈도우 함수 -> rank() over(partition by 집계기준 order by 정렬기준)
-- rank() 동일한 값에는 동일한 순위를 매김., dense_rank() 동일한 순위를 하나의 건수로 잡음. , row_number() 동일한 값이어도 하나의 고유한 순위를 매김
	
SELECT t.휴게소명, t.평가등급, t.대형 
	from (
		SELECT a.휴게소명, a.평가등급, b.대형,
			RANK() over (partition by a.평가등급 order by b.대형) as parking_rnk
		from rest_area_score a inner join rest_area_parking b
			on a.휴게소명 = b.휴게소명
		)t
WHERE  t.parking_rnk =1

-- --------------------------------------------------------------------------------
-- 전국 휴게소의 화장실 실태 조사
SELECT * from rest_area_restroom; 

-- 1번. 노선별 남자 변기수, 여자 변기수 최대값 출력
SELECT 노선,max(여자_변기수), max(남자_변기수) from rest_area_restroom 
	group by 노선 ;

-- 2번. 휴게소 중 total 변기수가 가장 많은 휴게소가 어디인지 출력
SELECT  시설명,
		남자_변기수 + 여자_변기수 as total
	from rest_area_restroom r  
		order by total DESC 

-- 3번. 노선별로 남자_변기수, 여자_변기수의 평균값 출력
SELECT 노선,avg(남자_변기수), avg(여자_변기수)
	from rest_area_restroom 
	group by 노선
		
-- 4번. 노선별로 total 변기수가 가장 많은곳만 출력
-- 윈도우함수 쓸 때, 랭크의 order 기준은 기존에 있던 칼럼에 한정되어서 써야함!!!!	
SELECT t.노선, t.total
	from (
		SELECT r.노선, r.남자_변기수 + r.여자_변기수 as total,
			rank() over(partition by 노선 order by r.남자_변기수 + r.여자_변기수) rnk 
			from rest_area_restroom r
		) t
WHERE rnk = 1
	

-- 5번. 노선별로 남자 변기수가 더 많은 곳, 여자 변기수가 더 많은 곳, 남녀 변기수가 동일한 곳의 count를 각각 구하여 출력
SELECT 노선,
		count(CASE when 남자_변기수 > 여자_변기수 then 1 end) male,
		count(CASE when 남자_변기수 < 여자_변기수 then 1 end) female,
		count(CASE when 남자_변기수 = 여자_변기수 then 1 end) equal
		from rest_area_restroom
	group by 노선

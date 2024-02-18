-- ------------------------------------------
-- 1번 평가등급이 최우수인 휴게소의 장애인 주차장수 출력 (휴게소명,시설구분, 장애인 주차장수 내림차순으로 출력)
SELECT a.휴게소명, a.시설구분 ,b.장애인 FROM rest_area_score a
	left outer join rest_area_parking b 
		on a.휴게소명 = b.휴게소명 
order by b.장애인 DESC 
	
-- 2번 평가등급이 우수인 휴게소의 장애인 주차장수 비율 출력 (휴게소명,시설구분,장애인 주차장수 비율 내림차순으로 출력)
SELECT a.휴게소명, a.시설구분 ,round(b.장애인/b.합계*100,2) as 비율 
	FROM rest_area_score a left outer join rest_area_parking b 
		on a.휴게소명 = b.휴게소명 
order by b.장애인/b.합계 DESC 
	
-- 3번. 휴게소의 시설구분별 주차장수 합계의 평균 출력
SELECT a.시설구분, avg(합계)
	from rest_area_score a
	left outer join rest_area_parking b on a.휴게소명 = b.휴게소명
	group by a.시설구분
	
-- 4번. 노선별로 대형차를 가장 많이 주차할 수 있는 휴게소 top3 
-- where 절에 들어갈 수 있는 것은 새롭게 만든 column 이 아니라 from에 있는 원래 데이터에서 조건으로만 됨.
	
SELECT t.노선, t.휴게소명,t.대형, t.rnk
	from (SELECT 휴게소명,노선,대형,
		rank() over(partition by 노선 order by 대형 DESC) as rnk
		from rest_area_parking) t
WHERE t.rnk <= 3

-- 5. 본부별로 소형차를 가장 많이 주차할 수 있는 휴게소 top3
SELECT t.본부, t.휴게소명,t.소형, t.rnk
	from (SELECT 휴게소명,본부,소형,
		rank() over(partition by 본부 order by 소형 DESC) as rnk
		from rest_area_parking) t
WHERE t.rnk <4

-- -------------------------------------
-- 1. 반려동물 놀이터가 있는 휴게소 중 wifi 사용이 가능한 곳 출력
SELECT * from rest_area_animal; 
select * from rest_area_wifi;

SELECT a.휴게소명 , t.가능여부
	from rest_area_animal a
	inner join 
		(SELECT 휴게소명, 가능여부	
			from rest_area_wifi  
		where 가능여부 = 'O') t ON a.휴게소명 = t.휴게소명

-- 2. 반려동물 놀이터가 있는 휴게소 중 운영시간이 24시간인 곳이 몇 군데인지 출력
SELECT count(*) from rest_area_animal 
	WHERE 운영시간 = '24:00'
	
-- 3. 본부별로 wifi 사용이 가능한 휴게소가 몇군데인지 출
-- trim은 공백을 제거한다.
SELECT trim(본부), count(가능여부) 
	from rest_area_wifi 
WHERE 가능여부 = 'O'
group by trim(본부)

-- 4. 3번 데이터를 휴게소가 많은 순서대로 정렬하여 출력
SELECT 본부, count(가능여부) 
	from rest_area_wifi 
WHERE 가능여부 = 'O'
group by 본부
order by count(가능여부) DESC; 

-- 5. 4번 데이터에서 휴게소 수가 25보다 많은 곳만 출력
SELECT 본부, count(가능여부) 
	from rest_area_wifi 
WHERE 가능여부 = 'O'
group by 본부
having count(가능여부) > 25
order by count(가능여부) DESC 

-- ----------------------------------------------
-- 1번 가장 비싼 음료 top5
SELECT * from price_info 
	order by price DESC limit 5;
	
-- 2번 월별 커피음료 매출 구하기 (매출=판매량*가격)
select substring(일자,1,7) as month , 
	sum(커피음료_페트) * (SELECT price from price_info WHERE product = '커피음료_페트') 페트매,
	sum(커피음료_병) * (SELECT price from price_info WHERE product = '커피음료_병') 병매출,
	sum(커피음료_중캔) * (SELECT price from price_info WHERE product = '커피음료_중캔') 중캔매출,
	sum(커피음료_소캔) * (SELECT price from price_info WHERE product = '커피음료_소캔') 소캔매출
	from store_order
group by SUBSTRING(일자,1,7) 

-- 3번 10월 3일의 주스 매출 구하기
select substring(일자,1,10) , 
	sum(주스_대페트) * (SELECT price from price_info WHERE product = '주스_대페트') 주스대페트매출,
	sum(주스_중페트) * (SELECT price from price_info WHERE product = '주스_중페트') 주스중페트매출,
	sum(주스_캔) * (SELECT price from price_info WHERE product = '주스_캔') 주스캔매출
	from store_order
WHERE substring(일자,1,10) LIKE  '%10-03'
group by SUBSTRING(일자,1,10) 

SELECT * from store_order ;

-- 4번 8월의 이온음료 매출 구하기
SELECT SUBSTRING(일자,1,7) as month ,
	sum(이온음료_대페트) * (SELECT price from price_info where product = '이온음료_대페트') 이온음료대페트매출,
	sum(이온음료_중페트) * (SELECT price from price_info where product = '이온음료_중페트') 이온음료중페트매출,
	sum(이온음료_캔) * (SELECT price from price_info where product = '이온음료_캔') 이온음료캔매출
	from store_order 
WHERE substring(일자,1,7) = '2020-08'	
group by SUBSTRING(일자,1,7)

-- 5번 9월의 차음료 판매수와 매출 구하기
SELECT substring(일자,1,7) as month, 
	sum(차음료),
	sum(차음료) * (SELECT price from price_info WHERE product = '차음료') 
	from store_order 
WHERE substring(일자,1,7) = '2020-09'
group by substring(일자,1,7)

SELECT * from store_order 

-- --------------------------------------
-- 1번. 비가 왔던 날만 출력
SELECT * from weather 
	WHERE 일강수량 != 0

-- 2번. 최고기온이 30도 이상이었던 날의 아이스음료 판매수 출력
SELECT a.일시 ,a.최고기온, b.아이스음료
	from weather a left outer join store_order b on a.일시 = b.일자
where a.최고기온 >= 30
order by a.일시

-- 3번. 최저기온이 20도 미만이었던 날의 건강음료 판매수 출력
SELECT a.일시 ,a.최저기온, b.건강음료
	from weather a left outer join store_order b on a.일시 = b.일자
where a.최저기온 < 20
order by a.일시
		
-- 4번. 비가 왔던 날의 숙취해소음료 판매수 출력
SELECT a.일시 ,a.일강수량, b.숙취해소음료
	from weather a left outer join store_order b on a.일시 = b.일자
where a.일강수량 !=0
order by a.일시
	
		
-- 5번. 4번 데이터에 매출 데이터 추가
SELECT a.일시 ,a.일강수량, b.숙취해소음료 * (SELECT price from price_info WHERE product = '숙취해소음료') as 매출
	from weather a left outer join store_order b on a.일시 = b.일자
where a.일강수량 !=0
order by a.일시

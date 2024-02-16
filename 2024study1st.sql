SELECT * from camping_information 

-- Camping DB를 활용한 문제
-- 1번 문제: 캠핑장의 사업장명과 소재지 전체 주소를 출력 (단, 사업자명은 NAME, 소재지전체주소는 ADDRESS로 출력)
SELECT 사업장명 NAME , 소재지전체주소 ADDRESS from camping_information 

-- 2번 문제: 1번 데이터에서 정상영업 하고 있는 캠핑장만 출력
SELECT 사업장명 NAME, 영업상태명 from camping_information 
	WHERE 영업상태구분코드 = 1
	
-- 3번 문제: 양양에 위치한 캠핑장은 몇개인지 출력
SELECT count(*) from camping_information 
	WHERE 소재지전체주소 LIKE '%양양%'
	
-- 4번 문제: 3번 데이터에서 폐업한 캠핑장은 몇개인지 출력
SELECT count(*) from camping_information 
	WHERE 소재지전체주소 LIKE '%양양%' AND 영업상태구분코드 =3
	
-- 5번 문제: 태안에 위치한 캠핑장의 사업장명 출력
SELECT count(*) from camping_information 
	WHERE 소재지전체주소 LIKE '%태안%'
	
-- 6번 문제: 5번 데이터에서 2020년에 폐업한 캠핑장만 출력
SELECT 사업장명,영업상태명, 폐업일자 from camping_information 
	WHERE 소재지전체주소 LIKE '%태안%' AND 폐업일자 like '2020%' 
	
-- 7번 문제: 제주도와 서울에 위치한 캠핑장은 몇개인지 출력
SELECT count(*) from camping_information 
	WHERE 소재지전체주소 LIKE '%서울%' or 소재지전체주소 like '%제주%'
	
-- -------------------------------------------------------------
-- 1번:해수욕장에 위치한 캠핑장의 사업장명과 인허가일자를 출력
SELECT * from camping_information ;
SELECT 사업장명,인허가일자 from camping_information 
	WHERE 사업장명 like '%해수욕장%'

-- 2번:제주도 해수욕장에 위치한 캠핑장의 소재지전체주소와 사업장명 출력
SELECT 사업장명,소재지전체주소 from camping_information 
	WHERE 사업장명 like '%해수욕장%' AND 소재지전체주소 like '%제주%'
	
-- 3번: 2번 데이터에서 인허가일자가 가장 최근인 곳의 인허가일자 출력
SELECT max(인허가일자) from camping_information 
	WHERE 사업장명 like '%해수욕장%' AND 소재지전체주소 like '%제주%'	
	
	
-- 4번: 강원도 해수욕장에 위치한 캠핑장 중 영업중인 곳만 출력
SELECT 사업장명,소재지전체주소,영업상태명 from camping_information 
	WHERE 사업장명 like '%해수욕장%' AND 소재지전체주소 like '%강원%' AND 영업상태구분코드 = 1
	
-- 5번: 4번 데이터중에서 인허가일자가 가장 오래된 곳의 인허가일자 출력
SELECT min(인허가일자) from camping_information 
	WHERE 사업장명 like '%해수욕장%' AND 소재지전체주소 like '%강원%' AND 영업상태구분코드 = 1
	
-- 6번: 해수욕장에 위치한 캠핑장 중 시설면적이 가장 넓은 곳의 시설면적 출력
SELECT 사업장명, 시설면적 from camping_information 
	WHERE 사업장명 like '%해수욕장%'
	order by 시설면적 DESC limit 1
	
-- 7번: 해수욕장에 위치한 캠핑장의 평균 시설면적 출력
SELECT round(avg(시설면적)) 평균시설면적 from camping_information 
	WHERE 사업장명 like '%해수욕장%'
	
-- --------------------------------------
SELECT * from camping_information ;

-- 1번: 캠핑장의 사업장명과 시설면적을 시설면적이 가장 넓은 순으로 출력
SELECT 사업장명,시설면적 from camping_information 
	order by 시설면적 DESC 
	
-- 2번: 1번 데이터에서 10위까지만 출력
SELECT 사업장명,시설면적 from camping_information 
	order by 시설면적 DESC limit 10
	
-- 3번: 경기도 캠핑장중에 면적이 가장 넓은 순으로 5개만 출력
SELECT 사업장명, 시설면적 from camping_information 
	WHERE 소재지전체주소 like '%경기%'
	order by 시설면적 DESC limit 5
	
-- 4번: 3번 데이터에서 1위는 제외
SELECT 사업장명, 시설면적 from camping_information 
	WHERE 소재지전체주소 like '%경기%'
	order by 시설면적 DESC limit 1,4
-- limit a,b -> a번째 인덱스(0부터 시작)에서 b개만큼 가져와라는 의미.
	
-- 5번: 영업중인 캠핑장 중에서 인허가일자가 가장 오래된 순으로 20개 출력
SELECT 사업장명,인허가일자 from camping_information 
	WHERE 영업상태구분코드 = 1 
	order BY 인허가일자 ASC limit 20
	
-- 6번: 2020년 10월 ~ 2021년 3월 사이에 폐업한 캠핑장의 사업장명과 소재지전체주소 출력
SELECT 사업장명, 소재지전체주소, 폐업일자 from camping_information 
	WHERE 영업상태구분코드 = 3 and 폐업일자 between '2020-10-01' AND '2021-03-31' 
	order by 폐업일자 aSC
-- between은 범위까지 포함임 (미만,초과의 개념 아님)
	
-- 7번: 폐업한 캠핑장 중에서 시설면적이 가장 컸던 곳의 사업장명과 시설면적 출력
SELECT 사업장명, 시설면적 from camping_information 
	WHERE 영업상태구분코드 = 3 
	order by 시설면적 DESC  limit 3

-- ---------------------
-- 1번: 각 지역별 캠핑장 수 출력 (단, 지역은 location으로 출력)
SELECT * from camping_information ;
SELECT substr(소재지전체주소,1,instr(소재지전체주소,' ')) location, count(*) from camping_information
	group by location
-- instr(문자열,위치) -> a에서 b라는 것이 시작하는 위치.	
-- substr(문자열,위치,길이) -> a에서  

-- 2번: 1번 데이터를 캠핑장 수가 많은 지역부터 출력
SELECT substr(소재지전체주소,1,instr(소재지전체주소,' ')) location, count(*) from camping_information
	group by location
	order by count(*) DESC 
	
-- 3번: 각 지역별 영업중인 캠핑장 수 출력
SELECT substr(소재지전체주소,1,instr(소재지전체주소,' ')) location, count(*) from camping_information
	WHERE 영업상태구분코드 = 1	
	group by location
	order by count(*) DESC 
	
-- 4번: 3번 데이터에서 캠핑장 수가 300개 이상인 지역만 출력
SELECT substr(소재지전체주소,1,instr(소재지전체주소,' ')) location, count(*) from camping_information
	WHERE 영업상태구분코드 = 1	
	group by location
	having count(*) >=300
	
-- 5번: 년도별 폐업한 캠핑장 수 출력 (단, 년도는 year로 출력)
SELECT substring(폐업일자,1,4) year, count(사업장명)  from camping_information
	WHERE 영업상태구분코드 = 3
	group by substring(폐업일자,1,4) 
	
	
-- 6번: 5번 데이터를 년도별로 내림차순하여 출력
SELECT substring(폐업일자,1,4) year, count(사업장명)  from camping_information
	WHERE 영업상태구분코드 = 3
	group by substring(폐업일자,1,4) 
	order by year DESC 

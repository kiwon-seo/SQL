select count(*) as 캠핑장수, substr(소재지전체주소,1,instr(소재지전체주소,' ')) as location
 from camping_info
 group by substr(소재지전체주소,1,instr(소재지전체주소,' '))
 order by 캠핑장수 DESC

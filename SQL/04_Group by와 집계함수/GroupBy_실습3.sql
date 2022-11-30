-- emp 테이블에서 입사년도별 평균 급여 구하기.  
select to_char(hiredate, 'yyyy') as hire_year, avg(sal) as avg_sal --, count(*) as cnt
from hr.emp
group by to_char(hiredate, 'yyyy')
order by 1;



-- floor은 소수점 버림 
select *, floor(sal/1000)*1000 as bin_range, sal/1000, floor(sal/1000)
from hr.emp; 


-- 1000미만, 1000-1999, 2000-2999와 같이 1000단위 범위내에 sal이 있는 레벨로 group by 하고 해당 건수를 구함. 
select * from hr.emp;

select floor(sal/1000)*1000 as bin_range, count(*) as cnt, sum(sal)
from hr.emp
group by floor(sal/1000)*1000
order by 1;




-- (복습) case when 조건 ~~ then ~~ else ~~ end
select *, case when job='SALESMAN' then sal 
			else 0 end as sales_sal
		, case when job='MANAGER' then sal 
			else 0 end as manager_sal
from hr.emp ;


-- job이 SALESMAN인 경우와 그렇지 않은 경우만 나누어서 평균/최소/최대 급여를 구하기. 

select *, 
case when job='SALESMAN' then 'SALESMAN'
			else 'OTHERS' end as gubun 
from hr.emp;


select case when job='SALESMAN' then 'SALESMAN'
			else 'OTHERS' end as gubun, avg(sal) as avg_sal, min(sal) as min_sal, max(sal) as max_sal
from hr.emp
group by case when job='SALESMAN' then 'SALESMAN'
			else 'OTHERS' end 












		
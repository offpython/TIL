-- 회사내 근무 기간 순위(hiredate) : 공동 순위가 있을 경우 차순위는 밀려서 순위 정함

select * from emp;

select *
	   , rank() over (order by hiredate) as hire_rank
from hr.emp;


-- 부서별로 가장 급여가 높은/낮은 순으로 순위: 공동 순위 시 차순위는 밀리지 않음.

select *
	   , dense_rank () over (partition by deptno order by sal desc) as sal_rank_desc
	   , dense_rank () over (partition by deptno order by sal) as sal_rank_asc
from hr.emp;

-- 부서별 가장 급여가 높은 직원 정보:  공동 순위는 없으며 반드시 고유 순위를 정함.  

select *
from(
	select elect *
		   , row_number () over (partition by deptno order by sal desc) as sal_rn
	from hr.emp
) a where sal_rn=1;

-- 부서별 급여 top 2 직원 정보: 공동 순위는 없으며 반드시 고유 순위를 정함. 

select *
from(
	select *
		   , row_number () over (partition by deptno order by sal desc) as sal_rn
	from hr.emp
) a where sal_rn<=2;


-- 부서별 가장 급여가 높은 직원과 가장 급여가 낮은 직원 정보. 공동 순위는 없으며 반드시 고유 순위를 정함
select * 
	  , case when sal_rn_desc = 1 then 'top'
	  		 when sal_rn_asc = 1 then 'bottop'
	  		 else 'middle' end as gubun
from (
	select *
		  , row_number () over (partition by deptno order by sal desc) as sal_rn_desc
		  , row_number () over (partition by deptno order by sal ) as sal_rn_asc
	from emp
) a where sal_rn_desc = 1 or sal_rn_asc = 1;

-- 부서별 가장 급여가 높은 직원과 가장 급여가 낮은 직원 정보 그리고 두 직원값의 급여차이도 함께 추출. 공동 순위는 없으며 반드시 고유 순위를 정함

with 
temp_01 as 
(
	select * 
		  , case when sal_rn_desc = 1 then 'top'
		  		 when sal_rn_asc = 1 then 'bottop'
		  		 else 'middle' end as gubun
	from (
		select *
			  , row_number () over (partition by deptno order by sal desc) as sal_rn_desc
			  , row_number () over (partition by deptno order by sal ) as sal_rn_asc
		from emp
	) a where sal_rn_desc = 1 or sal_rn_asc = 1
),
temp_02 as (
	select deptno, max(sal) as max_sal, min(sal) as min_sal
	from temp_01
	group by deptno
) 
select a.*, max_sal - min_sal as deiff_sal
from temp_01 a 
	join temp_02 b on a.deptno = b.deptno

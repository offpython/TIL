
select job, sum(sal) as sales_sum
from hr.emp a
group by job;

SALESMAN	5600.00
MANAGER	8275.00
ANALYST	3000.00
CLERK	3050.00
PRESIDENT	5000.00

-- deptno로 group by하고 job으로 pivoting 
select sum(case when job = 'SALESMAN' then sal end) as sales_sum
	 , sum(case when job = 'MANAGER' then sal end) as manager_sum
	 , sum(case when job = 'ANALYST' then sal end) as analyst_sum
	 , sum(case when job = 'CLERK' then sal end) as clerk_sum
	 , sum(case when job = 'PRESIDENT' then sal end) as president_sum
from emp;



-- deptno + job 별로 group by 		     
select deptno, job, sum(sal) as sal_sum, count(*)
from hr.emp
group by deptno, job
order by 1;

10	CLERK	1300.00	1
10	MANAGER	2450.00	1
10	PRESIDENT	5000.00	1
20	ANALYST	3000.00	1
20	CLERK	800.00	1
20	MANAGER	2975.00	1
30	CLERK	950.00	1
30	MANAGER	2850.00	1
30	SALESMAN	5600.00	4


-- deptno로 group by하고 job으로 pivoting 
select deptno, sum(sal) as sal_sum
	, sum(case when job = 'SALESMAN' then sal end) as sales_sum
	, sum(case when job = 'MANAGER' then sal end) as manager_sum
	, sum(case when job = 'ANALYST' then sal end) as analyst_sum
	, sum(case when job = 'CLERK' then sal end) as clerk_sum
	, sum(case when job = 'PRESIDENT' then sal end) as president_sum
from emp
group by deptno;



-- group by Pivoting시 조건에 따른 건수 계산 유형(count case when then 1 else null end)
select deptno, count(*) as cnt
	, count(case when job = 'SALESMAN' then 1 end) as sales_cnt
	, count(case when job = 'MANAGER' then 1 end) as manager_cnt
	, count(case when job = 'ANALYST' then 1 end) as analyst_cnt
	, count(case when job = 'CLERK' then 1 end) as clerk_cnt
	, count(case when job = 'PRESIDENT' then 1 end) as president_cnt
from emp
group by deptno;



-- group by Pivoting시 조건에 따른 건수 계산 시 잘못된 사례(count case when then 1 else null end)
select deptno, count(*) as cnt
	, count(case when job = 'SALESMAN' then 1 else 0 end) as sales_cnt
	, count(case when job = 'MANAGER' then 1 else 0 end) as manager_cnt
	, count(case when job = 'ANALYST' then 1 else 0 end) as analyst_cnt
	, count(case when job = 'CLERK' then 1 else 0 end) as clerk_cnt
	, count(case when job = 'PRESIDENT' then 1 else 0 end) as president_cnt
from emp
group by deptno;



-- group by Pivoting시 조건에 따른 건수 계산 시 sum()을 이용
select deptno, count(*) as cnt
	, sum(case when job = 'SALESMAN' then 1 else 0 end) as sales_cnt
	, sum(case when job = 'MANAGER' then 1 else 0 end) as manager_cnt
	, sum(case when job = 'ANALYST' then 1 else 0 end) as analyst_cnt
	, sum(case when job = 'CLERK' then 1 else 0 end) as clerk_cnt
	, sum(case when job = 'PRESIDENT' then 1 else 0 end) as president_cnt
from emp
group by deptno;

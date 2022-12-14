
-- 평균 급여 이상의 급여를 받는 직원
select * from hr.emp where sal >= (select avg(sal) from hr.emp);

-- 가장 최근 급여 정보
select * from hr.emp_salary_hist a where todate = (select max(todate) from hr.emp_salary_hist x where a.empno = x.empno);


-- 스칼라 서브쿼리
select ename, deptno, 
	(select dname from hr.dept x where x.deptno=a.deptno) as dname
from hr.emp a;

-- 인라인뷰 서브쿼리
select a.deptno, b.dname, a.sum_sal
from
(
	select deptno, sum(sal) as sum_sal 
	from hr.emp 
	group by deptno
) a 
join hr.dept b 
on a.deptno = b.deptno;

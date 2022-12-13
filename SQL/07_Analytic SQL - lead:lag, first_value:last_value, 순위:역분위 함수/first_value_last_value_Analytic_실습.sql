-- 부서별로 가장 hiredate가 오래된 사람의 sal 가져오기.
select empno, ename, deptno, hiredate, sal 
	, first_value (sal) over (partition by deptno order by hiredate) as first_hiredate_sal
from emp;


-- 부서별로 가장 hiredate가 최근인 사람의 sal 가져오기. windows절이 rows between unbounded preceding and unbounded following이 되어야 함. 
-- first value와 다르게 window가 설정되기 때문 

select empno, ename, deptno, hiredate, sal 
, last_value(sal) over (partition by deptno order by hiredate
						rows between unbounded preceding and unbounded following) as last_hiredate_sal_01
, last_value(sal) over (partition by deptno order by hiredate 
						rows between unbounded preceding and current row) as last_hiredate_sal_02
from emp;

-- last_value() over (order by asc) 대신 first_value() over (order by desc)를 적용 가능. 
select empno, ename, deptno, hiredate, sal 
, last_value(sal) over (partition by deptno order by hiredate rows between unbounded preceding and unbounded following) as last_hiredate_sal
, first_value(sal) over (partition by deptno order by hiredate desc) as last_hiredate_sal
from emp;


-- first_value()와 min() 차이 ! 
select empno, ename, deptno, hiredate, sal 
	, first_value(sal) over (partition by deptno order by hiredate) as first_hiredate_sal 
	, min(sal) over (partition by deptno order by hiredate) as min_sal
from emp;

-- ok (10,20,30은 중복이 제거되서 들어감)
select a.* from hr.dept a where a.deptno in (select deptno from hr.emp x where x.sal > 1000);

-- 수행 안됨 (> 서브쿼리 인자를 메인쿼리에 전달 불가)
select a.*, x.ename from hr.dept a where a.deptno in (select deptno from hr.emp x where x.sal > 1000 );

--ok  (> 반대개념은 가능)
select a.* from hr.dept a where exists (select deptno from hr.emp x where x.deptno=a.deptno and x.sal > 1000)

-- 서브쿼리의 반환값은 무조건 중복이 제거된 unique한 값 - 비상관 서브쿼리 
select * from nw.orders a where order_id in (select order_id from nw.order_items where amount > 100);

-- 서브쿼리의 반환값은 메이쿼리의 개별 레코드로 연결된 결과값에서 무조건 중복이 제거된 unique한 값 - 상관 서브쿼리
select * from nw.orders a where exists (select order_id from nw.order_items x where a.order_id = x.order_id and x.amount > 100);

-- 날짜 연산 
-- Date 타입에 숫자값을 더하거나/빼면 숫자값에 해당하는 일자를 더해거나/빼서 날짜 계산. 
select to_date('2022-01-01', 'yyyy-mm-dd') +  2 as date_01;

-- Date 타입에 곱하기나 나누기는 할 수 없음. 
select to_date('2022-01-01', 'yyyy-mm-dd') * 10 as date_01;

-- Timestamp 연산. +7을 하면 아래는 오류를 발생. 
select to_timestamp('2022-01-01 14:36:52', 'yyyy-mm-dd hh24:mi:ss') + 7;

-- Timestamp는 interval 타입을 이용하여 연산 수행. 
select to_timestamp('2022-01-01 14:36:52', 'yyyy-mm-dd hh24:mi:ss') + interval '7 hour' as timestamp_01;

select to_timestamp('2022-01-01 14:36:52', 'yyyy-mm-dd hh24:mi:ss') + interval '2 days' as timestamp_01;

select to_timestamp('2022-01-01 14:36:52', 'yyyy-mm-dd hh24:mi:ss') + interval '2 days 7 hours 30 minutes' as timestamp_01;

-- Date 타입에 interval을 더하면 Timestamp로 변환됨. 
select to_date('2022-01-01', 'yyyy-mm-dd') + interval '2 days' as date_01;

-- interval '2 days'와 같이 ' '내에는 days나 day를 혼용해도 되지만 interval '2' day만 허용. 
select to_date('2022-01-01', 'yyyy-mm-dd') + interval '2' day as date_01;

-- 날짜 간의 차이 구하기. 차이값은 정수형.  
select to_date('2022-01-03', 'yyyy-mm-dd') - to_date('2022-01-01', 'yyyy-mm-dd') as interval_01
	, pg_typeof(to_date('2022-01-03', 'yyyy-mm-dd') - to_date('2022-01-01', 'yyyy-mm-dd')) as type ;

-- Timestamp간의 차이 구하기. 차이값은 interval 
select to_timestamp('2022-01-01 14:36:52', 'yyyy-mm-dd hh24:mi:ss') 
     - to_timestamp('2022-01-01 12:36:52', 'yyyy-mm-dd hh24:mi:ss') as time_01
     , pg_typeof(to_timestamp('2022-01-01 08:36:52', 'yyyy-mm-dd hh24:mi:ss') 
     - to_timestamp('2022-01-01 12:36:52', 'yyyy-mm-dd hh24:mi:ss')) as type
;

-- date + date는 허용하지 않음. 
select to_date('2022-01-03', 'yyyy-mm-dd') +  to_date('2022-01-01', 'yyyy-mm-dd')

-- now(), current_timestamp, current_date, current_time 
-- interval을 년, 월, 일로 표시하기. justify_interval와 age 사용 차이
with 
temp_01 as (
select empno, ename, hiredate, now(), current_timestamp, current_date, current_time
	, date_trunc('second', now()) as now_trunc
	, now() - hiredate as 근속기간
from hr.emp
)
select *
	, date_part('year', 근속기간)
	, justify_interval(근속기간)
	, age(hiredate)
	, date_part('year', justify_interval(근속기간))||'년 '||date_part('month', justify_interval(근속기간))||'월' as 근속년월
	, date_part('year', age(hiredate))||'년 '||date_part('month', age(hiredate))||'월' as 근속년월_01
from temp_01;




/******************************************************
date_trunc 함수를 이용하여 년/월/일/시간/분/초 단위 절삭 
*******************************************************/

select trunc(99.9999, 2);

--date_trunc는 인자로 들어온 기준으로 주어진 날짜를 절삭(?),
select date_trunc('day', '2022-03-03 14:05:32'::timestamp)

-- date타입을 date_trunc해도 반환값은 timestamp타입임. 
select date_trunc('day', to_date('2022-03-03', 'yyyy-mm-dd')) as date_01;

-- 만약 date 타입을 그대로 유지하려면 ::date로 명시적 형변환 
select date_trunc('day', '2022-03-03'::date)::date as date_01

-- 월, 년으로 절단. 
select date_trunc('month', '2022-03-03'::date)::date as date_01;

-- week의 시작 날짜 구하기. 월요일 기준.
select date_trunc('week', '2022-03-03'::date)::date as date_01;

-- week의 마지막 날짜 구하기. 월요일 기준(일요일이 마지막 날짜)
select (date_trunc('week', '2022-03-03'::date) + interval '6 days')::date as date_01;

-- week의 시작 날짜 구하기. 일요일 기준.
select date_trunc('week', '2022-03-03'::date)::date -1 as date_01;

-- week의 마지막 날짜 구하기. 일요일 기준(토요일이 마지막 날짜)
select (date_trunc('week', '2022-03-03'::date)::date - 1 + interval '6 days')::date as date_01;

-- month의 마지막 날짜 
select (date_trunc('month', '2022-03-03'::date) + interval '1 month' - interval '1 day')::date;

-- 시분초도 절삭 가능. 
select date_trunc('hour', now());

--date_trunc는 년, 월, 일 단위로 Group by 적용 시 잘 사용됨.
drop table if exists hr.emp_test;

create table hr.emp_test
as
select a.*, hiredate + current_time
from hr.emp a;

select * from hr.emp_test;

-- 입사월로 group by
select date_trunc('month', hiredate) as hire_month, count(*)
from hr.emp_test
group by date_trunc('month', hiredate);

-- 시분초가 포함된 입사일일 경우 시분초를 절삭한 값으로 group by 
select date_trunc('day', hiredate) as hire_day, count(*)
from hr.emp_test
group by date_trunc('day', hiredate);
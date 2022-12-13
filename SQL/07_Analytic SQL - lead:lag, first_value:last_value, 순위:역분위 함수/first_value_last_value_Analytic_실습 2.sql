
-- 연속된 데이터 흐름에서 값이 Null일 경우 바로 값이 있는 바로 위의 데이터를 가져 오기. 
with ref_days
as (
	select generate_series('1996-07-04'::date , '1996-07-23'::date, '1 day'::interval)::date as ord_date
), 
temp_01 as (
	select date_trunc('day', b.order_date)::date as ord_date, sum(amount) as daily_sum
	from nw.order_items a
		join nw.orders b on a.order_id = b.order_id
	group by date_trunc('day', b.order_date)::date 
),
temp_02 as (
	select a.ord_date, b.daily_sum as daily_sum
	from ref_days a
		left join temp_01 b on a.ord_date = b.ord_date
), 
temp_03 as 
(
select *
, first_value(daily_sum) over (order by ord_date)
, case when daily_sum is null then 0
	else row_number() over () end as rnum
from temp_02
),
temp_04 as (
select *
	, max(lpad(rnum::text, 6, '0')||daily_sum) over (order by ord_date rows between unbounded preceding and current row) as temp_str
from temp_03 order by ord_date
)
select * 
	, substring(temp_str, 7)::float as inherited_daily_sum
from temp_04;
/* rows between unbounded preceding and current row */
select *, sum(unit_price) over (order by unit_price) as unit_price_sum from products;

select *, sum(unit_price) over (order by unit_price rows between unbounded preceding and current row) as unit_price_sum from products;

select *, sum(unit_price) over (order by unit_price rows unbounded preceding) as unit_price_sum from products;

/* 중앙합, 중앙 평균(Centered average) */
select product_id, product_name, category_id, unit_price
	, sum(unit_price) over (partition by category_id order by unit_price rows between 1 preceding and 1 following) as unit_price_sum 
	, avg(unit_price) over (partition by category_id order by unit_price rows between 1 preceding and 1 following) as unit_price_avg 
from products;

/* rows between current row and unbounded following */
select product_id, product_name, category_id, unit_price
, sum(unit_price) over (partition by category_id order by unit_price rows between current row and unbounded following) as unit_price_sum 
from products;


/* range와 rows의 차이 */
with
temp_01 as (
select c.category_id, date_trunc('day', b.order_date) as ord_date, sum(a.amount) sum_by_daily_cat
from order_items a
	join orders b on a.order_id = b.order_id 
	join products c on a.product_id = c.product_id 
group by c.category_id, date_trunc('day', b.order_date) 
order by 1, 2
)
select *
	, sum(sum_by_daily_cat) over (partition by category_id order by ord_date 
	                              rows between 2 preceding and current row)
	, sum(sum_by_daily_cat) over (partition by category_id order by ord_date 
	                              range between interval '2' day preceding and current row)
from temp_01;

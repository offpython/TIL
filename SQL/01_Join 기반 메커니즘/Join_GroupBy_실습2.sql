-- 고객명 Antonio Moreno이 1997년에 주문한 주문 정보를 주문 아이디, 주문일자, 배송일자, 배송 주소를 고객 주소와 함께 구할것.  

select * from nw.customers ;
select * from nw.orders ;


select a.contact_name, a.address, b.order_id, b.order_date, b.shipped_date, b.ship_address 
from nw.customers a
	join nw.orders b on a.customer_id = b.customer_id 
where a.contact_name = 'Antonio Moreno'
and b.order_date between to_date('19970101','yyyymmdd') and to_date('19971231','yyyymmdd') ;

-- Berlin에 살고 있는 고객이 주문한 주문 정보를 구할것
-- 고객명, 주문id, 주문일자, 주문접수 직원명, 배송업체명을 구할것. 

select * from nw.shippers;
select * from nw.orders ;
select * from nw.employees;

select a.customer_id, a.contact_name, b.order_id, b.order_date, c.first_name||' '||c.last_name as employee_name, d.company_name  as shipper_name
from nw.customers a
	join nw.orders b on a.customer_id = b.customer_id 
	join nw.employees c on b.employee_id = c.employee_id 
	join nw.shippers d on b.ship_via  = d.shipper_id 
where b.ship_city = 'Berlin';


--Beverages 카테고리에 속하는 모든 상품아이디와 상품명, 그리고 이들 상품을 제공하는 supplier 회사명 정보 구할것 

select * from nw.categories;
select * from nw.products;
select * from nw.suppliers ;

select a.category_id, a.category_name,  b.product_id, b.product_name, c.supplier_id, c.company_name 
from nw.categories a 
	join nw.products b on a.category_id = b.category_id 
	join nw.suppliers c on b.supplier_id = c.supplier_id 
where a.category_name = 'Beverages'
	

-- 고객명 Antonio Moreno이 1997년에 주문한 주문 상품정보를 고객 주소, 주문 아이디, 주문일자, 배송일자, 배송 주소 및
-- 주문 상품아이디, 주문 상품명, 주문 상품별 금액, 주문 상품이 속한 카테고리명, supplier명을 구할 것. 

select * from nw.customers  ;

select a.contact_name, a.address, b.order_id, b.order_date, b.shipped_date, b.ship_address, 
	   d.product_id, d.product_name, c.amount, e.category_name, f.contact_name 
from nw.customers a 
	join nw.orders b on a.customer_id = b.customer_id
	join nw.order_items c on b.order_id = c.order_id 
	join nw.products d on c.product_id = d.product_id 
	join nw.categories e on d.category_id = e.category_id 
	join nw.suppliers f on d.supplier_id  = f.supplier_id 
where b.order_date between to_date('19970101','yyyymmdd') and to_date('19971231', 'yyyymmdd')
and a.contact_name = 'Antonio Moreno';

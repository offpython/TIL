-- null을 가장 선두 순위로 처리
select a.*
	, rank() over (order by comm desc nulls first ) as comm_rank
	, row_number() over (order by comm desc nulls first) as comm_rnum
from hr.emp a;

-- null을 가장 마지막 순위로 처리
select a.*
	, rank() over (order by comm desc nulls last ) as comm_rank
	, row_number() over (order by comm desc nulls last) as comm_rnum
from hr.emp a;

-- null을 전처리하여 순위 정함. 
select a.*
	, rank() over (order by COALESCE(comm, 0) desc ) as comm_rank
	, row_number() over (order by COALESCE(comm, 0) desc) as comm_rnum
from hr.emp a;

select a.*
	, rank() over (order by comm desc) as comm_rank
	, row_number() over (order by comm desc) as comm_rnum
from hr.emp a;


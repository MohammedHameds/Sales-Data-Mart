select
	product_key,
	product_id,
	standard_cost
from dim_product
where is_current = 1
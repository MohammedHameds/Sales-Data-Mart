select 
    ProductID as product_id,
	Name as product_name,
	Color,
	ReorderPoint as reorder_point,
	StandardCost as standard_cost,
	ProductSubcategoryID,
	ProductModelID

from Production.Product
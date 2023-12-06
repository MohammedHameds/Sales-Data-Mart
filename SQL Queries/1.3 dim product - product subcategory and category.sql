select
	psc.ProductSubcategoryID,
	psc.Name as product_subcategory,
	pc.name as product_category
from [Production].[ProductSubcategory] as psc
	left join [Production].[ProductCategory] as pc
		on psc.ProductCategoryID = pc.ProductCategoryID
union all 
select null,null,null



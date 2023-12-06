select 
   pm.ProductModelID,
   pm.Name as model_name,
   pd.Description as product_description

from Production.ProductModel as pm
     left join Production.ProductModelProductDescriptionCulture as pdi
           on pm.ProductModelID = pdi.ProductModelID

     left join Production.ProductDescription as pd
           on pdi.ProductDescriptionID = pd.ProductDescriptionID


where pdi.CultureID = 'en' or pdi.CultureID is null

union all  
select null,null,null

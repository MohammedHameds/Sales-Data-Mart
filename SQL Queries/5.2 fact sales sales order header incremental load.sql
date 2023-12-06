select
	SalesOrderID,
	SalesOrderNumber,
	convert(date, OrderDate) as OrderDate,
	CustomerID,
	TerritoryID,
	TaxAmt,
	Freight
from Sales.SalesOrderHeader
where OnlineOrderFlag = 1
and ModifiedDate >= ? -- user variable, last update date
and ModifiedDate < ? -- system variabl, StartTime
order by sales_order_id
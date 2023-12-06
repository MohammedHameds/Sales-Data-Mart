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
order by SalesOrderID
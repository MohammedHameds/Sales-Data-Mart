select
	p.BusinessEntityID as personid,
	cast( 
		( isnull(p.FirstName, '') +' ' + isnull(p.MiddleName, '') +' '+ isnull(p.LAStName, '') ) 
	as nvarchar(150)) as customer_name,
	a2.AddressLine1 as address1,
	a2.AddressLine2 as address2,
	a2.City,
	-- a2.PostalCode,
	pp.PhoneNumber as phone
from Person.Person as p
	LEFT JOIN Person.BusinessEntityAddress as a1 
		on p.BusinessEntityID = a1.BusinessEntityID and a1.AddressTypeID = 2 -- there are few customers with multiple address types (2,5)
	LEFT JOIN Person.Address as a2 
		on a2.AddressID = a1.AddressID 
	LEFT JOIN Person.PersonPhone as pp
		on p.BusinessEntityID = pp.BusinessEntityID
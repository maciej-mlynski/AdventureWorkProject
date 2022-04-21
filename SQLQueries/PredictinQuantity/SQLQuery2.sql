USE AdventureWorks2019
GO

SELECT
	
	ps.Name,p.Color, p.Size,s.UnitPriceDiscount, DATEDIFF(MONTH, '2011-05-31',MIN(sh.OrderDate)) as MonthsFromMay, MONTH(sh.OrderDate) as MonthOfSale, FLOOR((DATEDIFF(MONTH, MIN(p.SellStartDate),MIN(sh.OrderDate))-1)/12) as YearsOfAveliability,
	MIN(p.Weight) as Weight, MIN(p.Class) as Class, AVG(p.StandardCost) as StanstadCost, MIN(p.ListPrice) as ListPrice, 
	s.UnitPrice * (1-s.UnitPriceDiscount) as FinalSellPrice , (s.UnitPrice * (1-s.UnitPriceDiscount))/AVG(p.StandardCost) as PriceToCost,
	SUM(s.OrderQty) as OrdersQuantity,
	'06.2011-06.2012' as YearsOfAnalyze
FROM Production.Product as p
	JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
	JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE pc.Name = 'Bikes' AND sh.OrderDate < COALESCE(p.SellEndDate, '2014-05-30') AND sh.OrderDate <= '2012-05-29'
GROUP BY GROUPING SETS((ps.Name, s.UnitPrice,s.UnitPriceDiscount, p.Size, p.Color, MONTH(sh.OrderDate)))
ORDER BY ps.Name, p.Color, p.Size


SELECT
	
	p.ProductID,pc.Name, p.Color, p.Size, p.StandardCost, s.UnitPriceDiscount, s.UnitPrice, sh.SubTotal, s.OrderQty, sh.SalesOrderID, sh.OrderDate
FROM Production.Product as p
	JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
	JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE sh.OrderDate < COALESCE(p.SellEndDate, '2014-05-30') AND sh.OrderDate < '2012-05-29' AND sh.SalesOrderID =  46323





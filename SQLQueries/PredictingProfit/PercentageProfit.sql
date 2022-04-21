USE AdventureWorks2019
GO

SELECT
	ps.Name, p.Size, p.Color, p.Class, p.Weight,
	p.StandardCost,  CASE WHEN s.UnitPriceDiscount > 0 THEN 1 ELSE 0 END as isDiscounted, 
	YEAR(sh.OrderDate) as OrderYear ,   YEAR(sh.OrderDate) - YEAR(p.SellStartDate) as AveliablePeriod,
	(s.UnitPrice * (1-s.UnitPriceDiscount) - p.StandardCost) / p.StandardCost as PercentProfit
FROM Production.Product as p
	JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
	JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE pc.Name = 'Bikes' AND sh.OrderDate < COALESCE(p.SellEndDate, '2014-05-30')
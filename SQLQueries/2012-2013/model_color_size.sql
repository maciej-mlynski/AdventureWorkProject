USE AdventureWorks2019

SELECT
	SUBSTRING(p.Name, 0, CHARINDEX(' ', p.Name)) as ModelName, p.Color, p.Size
	, SUM(s.UnitPrice*(1-s.UnitPriceDiscount)*s.OrderQty) as totalSellAmt , SUM(p.StandardCost*s.OrderQty) as totalCosts, SUM(s.OrderQty) as totalQuantity,
	SUM((s.UnitPrice*(1-s.UnitPriceDiscount) - p.StandardCost) * s.OrderQty) as totalGrossProfit
	
FROM Production.Product as p
	JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
	JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE sh.OrderDate  >= '2012-05-30 00:00:00.000' AND sh.OrderDate < '2013-05-29 00:00:00.000' AND pc.Name = 'Bikes' AND p.ProductID IN (SELECT 
																														p.ProductID
																													FROM Production.Product as p
																														JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
																														JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
																														JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
																														JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
																													WHERE sh.OrderDate >= '2013-05-30 00:00:00.000' AND p.SellEndDate IS NULL )

GROUP BY GROUPING SETS (SUBSTRING(p.Name, 0, CHARINDEX(' ', p.Name)), (SUBSTRING(p.Name, 0, CHARINDEX(' ', p.Name)), p.Color), p.Color, (SUBSTRING(p.Name, 0, CHARINDEX(' ', p.Name)), p.Color, p.Size))

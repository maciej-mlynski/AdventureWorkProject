USE AdventureWorks2019
GO

SELECT
	sh.SalesOrderID, SUM(s.OrderQty) as TotalOrderQty, MIN(sh.SubTotal) as SubTotAmt, COUNT(sh.SalesOrderID) as ItemsQty
FROM Production.Product as p
	JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
	JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE sh.OrderDate  >= '2012-05-30 00:00:00.000' AND sh.OrderDate < '2013-05-29 00:00:00.000' AND s.UnitPrice * s.OrderQty < sh.SubTotal
GROUP BY sh.SalesOrderID
HAVING Max(sh.SubTotal) = MIN(sh.SubTotal)



SELECT
	s.SalesOrderID , p.Name,s.OrderQty, p.StandardCost, s.UnitPrice,
	sh.TotalDue, sh.SubTotal
FROM Production.Product as p
	JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
	JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
	JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
	JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE sh.OrderDate  >= '2012-05-30 00:00:00.000' AND sh.OrderDate < '2013-05-29 00:00:00.000' AND s.UnitPrice*(1-s.UnitPriceDiscount) * s.OrderQty = sh.SubTotal AND pc.Name = 'Bikes' AND p.ProductID IN (SELECT 
																														p.ProductID
																													FROM Production.Product as p
																														JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
												 																		JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
																														JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
																														JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
																													WHERE sh.OrderDate >= '2013-05-30 00:00:00.000' AND p.SellEndDate IS NULL )
ORDER BY sh.SalesOrderID


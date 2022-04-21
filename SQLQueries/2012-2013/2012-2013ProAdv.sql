USE AdventureWorks2019;
GO


SELECT 
	p.ProductID, p.ListPrice, p.StandardCost, p.Color, p.Size, p.Weight, p.Style, p.class, p.Name as BikeName, SUBSTRING(p.Name, 0, CHARINDEX(' ', p.Name)) as ModelName
	,ps.Name as SubName
	,pc.Name as CatName
	, s.UnitPrice, s.UnitPriceDiscount, s.OrderQty, s.SalesOrderID
	,sh.TotalDue, sh.SubTotal, sh.TerritoryID, sh.OrderDate
	,p.SellStartDate, p.SellEndDate
FROM Production.Product as p
JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
WHERE sh.OrderDate >= '2012-05-30 00:00:00.000' AND sh.OrderDate < '2013-05-30 00:00:00.000' AND p.ProductID NOT IN (SELECT 
																														p.ProductID
																													FROM Production.Product as p
																														JOIN Sales.SalesOrderDetail as s ON s.ProductID = p.ProductID
																														JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
																														JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
																														JOIN Sales.SalesOrderHeader as sh ON s.SalesOrderID = sh.SalesOrderID
																													WHERE sh.OrderDate >= '2013-05-30 00:00:00.000')
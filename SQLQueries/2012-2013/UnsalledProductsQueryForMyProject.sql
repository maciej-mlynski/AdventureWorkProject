USE AdventureWorks2019;
GO

SELECT
	p.ProductID, p.ListPrice, p.StandardCost, p.Color, p.Size, p.SizeUnitMeasureCode, p.Weight, p.WeightUnitMeasureCode, p.Style, p.class,
	ps.Name as SubCatName,
	pc.Name as CatName
FROM Production.Product as p
LEFT JOIN Production.ProductSubcategory as ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory as pc ON ps.ProductCategoryID = pc.ProductCategoryID
WHERE p.ProductID NOT IN (
			SELECT sd.ProductID FROM Sales.SalesOrderDetail as sd
	) AND ListPrice > 0


CREATE DATABASE SalesDB;
SELECT *
FROM sales_data_sample;
SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    COUNTRY,
    SALES
FROM sales_data_sample;
SELECT
    CUSTOMERNAME,
    COUNTRY,
    SALES
FROM sales_data_sample
WHERE COUNTRY = 'USA';
SELECT
    CUSTOMERNAME,
    SALES
FROM sales_data_sample
ORDER BY SALES DESC;
SELECT
    COUNTRY,
    SUM(SALES) AS TotalSales
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY TotalSales DESC;
SELECT
    PRODUCTLINE,
    COUNT(*) AS NumberOfOrders
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY NumberOfOrders DESC;
SELECT
    DEALSIZE,
    AVG(SALES) AS AverageSales
FROM sales_data_sample
GROUP BY DEALSIZE
ORDER BY AverageSales DESC;
SELECT
    STATUS,
    SUM(SALES) AS TotalSales
FROM sales_data_sample
GROUP BY STATUS
ORDER BY TotalSales DESC;
SELECT
    COUNTRY,
    SUM(SALES) AS TotalSales
FROM sales_data_sample
GROUP BY COUNTRY
HAVING SUM(SALES) > 500000
ORDER BY TotalSales DESC;
SELECT
    COUNTRY,
    COUNT(*) AS TotalOrders,
    SUM(SALES) AS TotalSales,
    AVG(SALES) AS AverageSales,
    MAX(SALES) AS HighestSale,
    MIN(SALES) AS LowestSale
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY TotalSales DESC;
SELECT *
FROM sales_data_sample
WHERE SALES =
(
    SELECT MAX(SALES)
    FROM sales_data_sample
);
SELECT *
FROM sales_data_sample
WHERE SALES >
(
    SELECT AVG(SALES)
    FROM sales_data_sample
);
SELECT
    PRODUCTLINE,
    SUM(SALES) AS TotalSales
FROM sales_data_sample
GROUP BY PRODUCTLINE
HAVING SUM(SALES) =
(
    SELECT MAX(ProductRevenue)
    FROM
    (
        SELECT SUM(SALES) AS ProductRevenue
        FROM sales_data_sample
        GROUP BY PRODUCTLINE
    ) AS RevenueTable
);
SELECT
    CUSTOMERNAME,
    SUM(SALES) AS TotalSpent,
    RANK() OVER (ORDER BY SUM(SALES) DESC) AS CustomerRank
FROM sales_data_sample
GROUP BY CUSTOMERNAME;
SELECT
    ORDERNUMBER,
    CUSTOMERNAME,
    SALES,
    ROW_NUMBER() OVER (ORDER BY SALES DESC) AS RowNum
FROM sales_data_sample;
SELECT
    COUNTRY,
    ORDERNUMBER,
    SALES,
    ROW_NUMBER() OVER
    (
        PARTITION BY COUNTRY
        ORDER BY SALES DESC
    ) AS CountryRank
FROM sales_data_sample;
SELECT TOP 10
    CUSTOMERNAME,
    SUM(SALES) AS TotalSales
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY TotalSales DESC;
SELECT
    PRODUCTLINE,
    SUM(SALES) AS Revenue
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY Revenue DESC;
SELECT
    YEAR(ORDERDATE) AS SalesYear,
    SUM(SALES) AS Revenue
FROM sales_data_sample
GROUP BY YEAR(ORDERDATE)
ORDER BY SalesYear;
SELECT
    COUNTRY,
    SUM(SALES) AS Revenue
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY Revenue DESC;
SELECT
    CUSTOMERNAME,
    COUNT(ORDERNUMBER) AS NumberOfOrders,
    SUM(SALES) AS TotalSpent,
    AVG(SALES) AS AverageOrderValue
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY TotalSpent DESC;
SELECT
    DEALSIZE,
    SUM(SALES) AS Revenue
FROM sales_data_sample
GROUP BY DEALSIZE
ORDER BY Revenue DESC;

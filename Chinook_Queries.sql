SELECT * 

FROM Customer; 

SELECT * 

FROM Customer 

WHERE Country = 'USA'; 

SELECT * 

FROM Customer 

ORDER BY LastName; 

SELECT 

    FirstName, 

    LastName, 

    Country 

FROM Customer; 

Aggregate Functions; 

SELECT COUNT(*) AS TotalCustomers 

FROM Customer; 

SELECT 

    Country, 

    COUNT(*) AS NumberOfCustomers 

FROM Customer 

GROUP BY Country 

ORDER BY NumberOfCustomers DESC; 

SELECT 

    SUM(Total) AS TotalRevenue 

FROM Invoice; 

SELECT 

    AVG(Total) AS AverageInvoice 

FROM Invoice; 

SELECT 

    Country, 

    COUNT(*) AS TotalCustomers 

FROM Customer 

GROUP BY Country 

HAVING COUNT(*) > 1; 

SELECT 

    c.FirstName, 

    c.LastName, 

    i.InvoiceDate, 

    i.Total 

FROM Customer c 

INNER JOIN Invoice i 

ON c.CustomerId = i.CustomerId; 

SELECT 

    c.FirstName, 

    c.LastName, 

    SUM(i.Total) AS TotalSpent 

FROM Customer c 

JOIN Invoice i 

ON c.CustomerId = i.CustomerId 

GROUP BY c.FirstName, c.LastName 

ORDER BY TotalSpent DESC; 

SELECT 

    t.Name, 

    SUM(il.Quantity) AS UnitsSold 

FROM Track t 

JOIN InvoiceLine il 

ON t.TrackId = il.TrackId 

GROUP BY t.Name 

ORDER BY UnitsSold DESC; 

SELECT 

    ar.Name, 

    SUM(il.Quantity) AS TotalSales 

FROM InvoiceLine il 

JOIN Track t 

ON il.TrackId = t.TrackId 

JOIN Album al 

ON t.AlbumId = al.AlbumId 

JOIN Artist ar 

ON al.ArtistId = ar.ArtistId 

GROUP BY ar.Name 

ORDER BY TotalSales DESC; 

SELECT * 

FROM Invoice 

WHERE Total = 

( 

    SELECT MAX(Total) 

    FROM Invoice 

); 

SELECT * 

FROM Invoice 

WHERE Total > 

( 

    SELECT AVG(Total) 

    FROM Invoice 

); 

SELECT 

    c.FirstName, 

    c.LastName, 

    SUM(i.Total) AS TotalSpent 

FROM Customer c 

JOIN Invoice i 

ON c.CustomerId = i.CustomerId 

GROUP BY c.FirstName, c.LastName 

HAVING SUM(i.Total) = 

( 

    SELECT MAX(CustomerTotal) 

    FROM 

    ( 

        SELECT SUM(Total) AS CustomerTotal 

        FROM Invoice 

        GROUP BY CustomerId 

    ) AS Spending 

); 

SELECT 

    CustomerId, 

    SUM(Total) AS TotalSpent, 

    RANK() OVER (ORDER BY SUM(Total) DESC) AS CustomerRank 

FROM Invoice 

GROUP BY CustomerId; 

SELECT 

    InvoiceId, 

    CustomerId, 

    Total, 

    ROW_NUMBER() OVER (ORDER BY Total DESC) AS RowNum 

FROM Invoice; 

SELECT 

    CustomerId, 

    InvoiceId, 

    Total, 

    ROW_NUMBER() OVER 

    ( 

        PARTITION BY CustomerId 

        ORDER BY Total DESC 

    ) AS InvoiceRank 

FROM Invoice; 

WITH RankedInvoices AS 

( 

    SELECT 

        CustomerId, 

        InvoiceId, 

        Total, 

        ROW_NUMBER() OVER 

        ( 

            PARTITION BY CustomerId 

            ORDER BY Total DESC 

        ) AS InvoiceRank 

    FROM Invoice 

) 

SELECT * 

FROM RankedInvoices 

WHERE InvoiceRank = 1;
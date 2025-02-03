--View all properties
select * from Property

--Show paid property sales
SELECT P.PropertyID, P.Location, S.SaleDate, C.Name
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
JOIN Client C ON S.ClientID = C.ClientID
WHERE S.Payment_Status = 'Paid'

--Average prices per property
SELECT AVG(Price) AS average_price FROM Property

--Total expenses per property
SELECT P.PropertyID, P.Country, P.Location ,SUM(E.Amount) AS TotalExpenses
FROM Expense E
JOIN Property P ON E.PropertyID = P.PropertyID
GROUP BY P.PropertyID, P.Country, P.Location

--Real Estate Sales with Expenses
SELECT P.PropertyID, P.Location, SUM(E.Amount) AS TotalExpenses, S.SaleDate, S.Payment_Status
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
LEFT JOIN Expense E ON P.PropertyID = E.PropertyID
GROUP BY P.PropertyID, P.Location , S.SaleDate, S.Payment_Status

--Clients and Sales
SELECT C.ClientID,C.Name, C.Occupation, COUNT(S.SaleID) AS NumberOfSales
FROM Client C
JOIN Sales S ON C.ClientID = S.ClientID
GROUP BY C.ClientID, C.Name, C.Occupation

--Total sales per client
SELECT C.Name, SUM(P.Price) AS TotalSpent
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
JOIN Client C ON S.ClientID = C.ClientID
GROUP BY C.ClientID, C.Name

--Properties sold in a given year
SELECT P.PropertyID, P.Location, S.SaleDate
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
WHERE YEAR(S.SaleDate) = 2023

--Highest priced properties
SELECT top 5 P.PropertyID, P.Location, P.Price, S.SaleDate
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
ORDER BY P.Price DESC

--Expenses paid for specific purposes (such as maintenance or renovation)
SELECT E.ExpenseType, SUM(E.Amount) AS TotalExpense
FROM Expense E
JOIN Property P ON E.PropertyID = P.PropertyID
WHERE E.ExpenseType = 'Maintenance'
GROUP BY E.ExpenseType

--Properties with customer and sales details
SELECT P.PropertyID, P.Location, P.Price, C.Name AS ClientName, C.Occupation, S.SaleDate, S.Payment_Status
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
JOIN Client C ON S.ClientID = C.ClientID

--Properties not yet sold (Pending Sales)
SELECT P.PropertyID, P.Location, P.Price, S.SaleDate
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
WHERE S.Payment_Status = 'Pending'

--Number of properties sold per city
SELECT P.Location, COUNT(S.SaleID) AS SoldProperties
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
WHERE S.Payment_Status = 'Paid'
GROUP BY P.Location

--Properties that have been paid for but not yet sold
SELECT P.PropertyID, P.Location, P.Price, S.SaleDate
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
WHERE S.Payment_Status = 'Paid'

--Comparison of sales by property type
SELECT P.Type, COUNT(S.SaleID) AS TotalSales
FROM Sales S
JOIN Property P ON S.PropertyID = P.PropertyID
GROUP BY P.Type

--Properties with the most rooms
SELECT TOP 5 PropertyID, Location, Bedrooms, Bathrooms, Price
FROM Property
ORDER BY Bedrooms DESC, Bathrooms DESC










--1: Which countries have the most Invoices?

SELECT BillingCountry,COUNT(BillingCountry) AS Invoice_Number
FROM Invoice
GROUP BY BillingCountry
ORDER BY Invoice_Number DESC;

--2: Which city has the best customers? 

SELECT TOP 5 BillingCity,SUM(Total) AS InvoiceTotal
FROM Invoice
GROUP BY BillingCity
ORDER BY InvoiceTotal DESC;

--3: Who is the best customer?
SELECT TOP 5 Customer.FirstName, Customer.LastName, Invoice.Total
FROM Customer
JOIN invoice ON Customer.CustomerId = Invoice.CustomerId
ORDER BY Invoice.Total DESC;

--4: Use your query to return the email, first name, last name, and Genre of all Rock Music listeners.
SELECT DISTINCT Email, FirstName, LastName
FROM Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
JOIN Invoiceline ON Invoice.InvoiceId = InvoiceLine.InvoiceId
WHERE TrackId IN(
	SELECT TrackId FROM Track
	JOIN Genre ON Track.GenreId = Genre.GenreId
	WHERE Genre.name LIKE 'Rock'
)
ORDER BY Email;

-- 5: Genre type distribution in USA 
select TOP 10 Genre.Name,Invoice.BillingCountry,count(*) Num_of_invoices
from Invoice
join InvoiceLine
on Invoice.InvoiceId = InvoiceLine.InvoiceId
join Track
On InvoiceLine.TrackId = Track.TrackId
join Genre
on Track.GenreId = Genre.GenreId
GROUP BY Genre.Name,Invoice.BillingCountry
HAVING Invoice.BillingCountry='USA'
ORDER BY Num_of_invoices DESC;



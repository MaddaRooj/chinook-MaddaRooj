-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT c.FirstName, c.LastName, c.CustomerId, c.Country 
FROM Customer c 
WHERE c.Country != 'USA';

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

SELECT c.FirstName, c.LastName, c.CustomerId, c.Country 
FROM Customer c 
WHERE c.Country = 'Brazil';

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.FirstName, c.LastName, c.CustomerId as CustomerId, i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Invoice i
LEFT JOIN Customer c ON c.CustomerId = i.CustomerId

-- sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT *
FROM Employee
WHERE Title = 'Sales Support Agent'

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT DISTINCT BillingCountry
FROM Invoice

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT e.FirstName, e.LastName, i.InvoiceId
FROM Invoice i
LEFT JOIN Customer c ON c.CustomerId = i.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
ORDER BY e.LastName

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT c.FirstName as CustomerFirstName, c.LastName as CustomerLastName, c.Country, e.FirstName as SalesRepFN, e.LastName as SalesRepLN, i.[Total] as InvoiceTotal
FROM Invoice i 
LEFT JOIN Customer c ON i.CustomerId = c.CustomerId
LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId

-- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

SELECT COUNT(InvoiceId) AS TotalInvoices
FROM Invoice 
WHERE YEAR(InvoiceDate) = '2009'
OR Year(InvoiceDate) = '2011';

-- total_sales_{year}.sql: What are the respective total sales for each of those years?



-- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT COUNT(InvoiceLineId) AS LineItemsForID37 
FROM InvoiceLine
WHERE InvoiceId = 37

-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT InvoiceId, COUNT(InvoiceLineId) as LineItems
FROM InvoiceLine
GROUP BY InvoiceId
ORDER BY InvoiceId

-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT t.[Name] AS TrackName, i.InvoiceLineId
FROM InvoiceLine i 
LEFT JOIN Track t ON t.TrackId = i.TrackId
ORDER BY InvoiceLineId

-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT t.[Name] AS TrackName, a.[Name] AS ArtistName, i.InvoiceLineId
FROM InvoiceLine i 
LEFT JOIN Track t ON t.TrackId = i.TrackId
LEFT JOIN Album al ON t.AlbumId = al.AlbumId
LEFT JOIN Artist a ON a.ArtistId = al.ArtistId
ORDER BY InvoiceLineId

-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT COUNT(i.InvoiceId) AS NumberOfInvoices, i.BillingCountry
FROM Invoice i 
GROUP BY i.BillingCountry

-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.

SELECT p.[Name] AS PlaylistName, COUNT(t.TrackId) AS NumberOfTracks
FROM Playlist p 
LEFT JOIN PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
LEFT JOIN Track t ON pt.TrackId = t.TrackId
GROUP BY p.[Name]

-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT t.[Name] AS TrackName, ar.[Name] AS Artist, al.[Title] AS AlbumName, mt.[Name] AS MediaType, g.[Name] AS Genre
FROM Track t
LEFT JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeId
LEFT JOIN Genre g ON g.GenreId = t.GenreId
LEFT JOIN Album al ON al.AlbumId = t.AlbumId
LEFT JOIN Artist ar ON al.ArtistId = ar.ArtistId
ORDER BY al.Title

-- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

SELECT e.EmployeeId, COUNT(i.InvoiceId) AS TotalInvoices
FROM Invoice i
LEFT JOIN Customer c ON c.CustomerId = i.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId
ORDER BY e.EmployeeId

-- top_2009_agent.sql: Which sales agent made the most in sales in 2009?


SELECT e.EmployeeId, COUNT(i.InvoiceId) AS TotalInvoices
FROM Invoice i
LEFT JOIN Customer c ON c.CustomerId = i.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
WHERE YEAR(i.InvoiceDate) = '2009'
GROUP BY e.EmployeeId
ORDER BY TotalInvoices DESC

-- Hint: Use the MAX function on a subquery.

-- top_agent.sql: Which sales agent made the most in sales over all?

SELECT e.FirstName AS SalesAgentFN, e.LastName AS SalesAgentLN, SUM(i.Total) AS TotalSales
FROM Invoice i 
LEFT JOIN Customer c ON c.CustomerId = i.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
GROUP BY e.FirstName, e.LastName
ORDER BY TotalSales DESC

-- sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

SELECT e.FirstName AS SalesAgentFN, e.LastName AS SalesAgentLN, COUNT(c.CustomerId) AS #OfCustomers
FROM Customer c 
LEFT JOIN Employee e ON c.SupportRepId = e.EmployeeId
GROUP BY e.FirstName, e.LastName 

-- sales_per_country.sql: Provide a query that shows the total sales per country.

SELECT COUNT(i.InvoiceId) AS #OfSales, i.BillingCountry
FROM Invoice i 
GROUP BY i.BillingCountry

-- top_country.sql: Which country's customers spent the most?

SELECT SUM(Total) AS TotalSpent, BillingCountry 
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalSpent DESC

-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

SELECT COUNT(il.TrackId) AS UnitsSold, t.TrackId, t.[Name] AS TrackName 
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY t.TrackId, t.[Name]
ORDER BY UnitsSold DESC


-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.

SELECT TOP 5 COUNT(il.TrackId) AS UnitsSold, t.TrackId, t.[Name] AS TrackName 
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
GROUP BY t.TrackId, t.[Name]
ORDER BY UnitsSold DESC

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

SELECT TOP 3 COUNT(al.ArtistId) AS UnitsSoldByArtist, a.ArtistId, a.[Name] AS TrackName 
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
LEFT JOIN Album al ON al.AlbumId = t.AlbumId
LEFT JOIN Artist a ON a.ArtistId = al.ArtistId
GROUP BY a.ArtistId, a.[Name]
ORDER BY UnitsSoldByArtist DESC

-- top_media_type.sql: Provide a query that shows the most purchased Media Type.

SELECT TOP 3 COUNT(mt.MediaTypeId) AS UnitsSoldByMediaType, mt.MediaTypeId, mt.[Name] AS MediaType 
FROM InvoiceLine il
LEFT JOIN Track t ON il.TrackId = t.TrackId
LEFT JOIN Invoice i ON il.InvoiceId = i.InvoiceId
LEFT JOIN MediaType mt ON t.MediaTypeId = mt.MediaTypeId
GROUP BY mt.MediaTypeId, mt.[Name]
ORDER BY UnitsSoldByMediaType DESC
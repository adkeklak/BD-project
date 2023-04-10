GO
CREATE VIEW Drivers
AS
	SELECT FirstName ,LastName 
	FROM Employees 
	WHERE DepartmentID = 'Driver'

GO

GO
CREATE VIEW TicketTypes
AS
	SELECT Name, Price FROM Tickets

GO 

GO
CREATE VIEW Vehicle_Types
AS 
	SELECT VehicleType, COUNT(*) AS Quantity
	FROM Vehicles LEFT JOIN Buses ON Vehicles.VehicleID = Buses.VehicleID 
	LEFT JOIN Trams ON Vehicles.VehicleID = Trams.VehicleID
	GROUP BY VahicleType
	
GO

GO
CREATE VIEW NewHires
AS
	SELECT * FROM Employees 
	WHERE HireDate > GETDATE() - DATEADD(MONTH,-2,GETDATE())
GO


GO
CREATE VIEW TicketsLastMonth
AS
	SELECT SUM(Price) AS Profit FROM TicketHistory
	WHERE HireDate > GETDATE() - DATEADD(MONTH,-1,GETDATE())
GO

GO
CREATE VIEW NumberOfUsedHolidasy
AS
	SELECT EmployeeID ,SUM(DATEDIFF(EndDate, StartDate)) AS UsedHolidays FROM Holidays
	
GO

GO
CREATE VIEW Profit
AS
	SELECT (SELECT SUM(price) FROM TicketHistory - SELECT SUM(salary) FROM SalaryHistory) AS Profit
	
GO

GO
CREATE VIEW SalaryOfEmployee
AS
	SELECT EmployeeID, SUM(salary) AS Salary FROM SalaryHistory
GO

GO
CREATE VIEW PopularityOfStop
AS
	SELECT Stops.Name, SUM(*) AS NumberOfLinesConnected FROM Stops JOIN Connections ON Stops.StopID = Connections.StopID
GO

GO
CREATE VIEW TicketSalesByDay
AS
	SELECT TicketsHistory.Time AS DATE, SUM(price) AS Profit FROM TicketsHistory
	GROUP BY TicketsHistory.Time
GO

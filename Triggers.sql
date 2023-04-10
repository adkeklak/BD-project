GO
CREATE TRIGGER VehicleInsert
ON Vehicles
AFTER INSERT
AS
BEGIN
	UPDATE inserted
	SET Lastinspected = GETDATE()
	WHERE VehicleID IN (SELECT VehicleID FROM inserted)
END
GO

GO
CREATE TRIGGER OnNewLine
ON Lines
AFTER INSERT
AS
BEGIN
	UPDATE Tickets
	SET Price = Price * 1.05
END
GO

GO
CREATE TRIGGER DecreaceSalary
ON SalaryHistory
AFTER INSERT
AS
BEGIN
	IF(SELECT SUM(Salary) FROM inserted > 500000)
	BEGIN
		UPDATE Employees
		SET Salary = Salary * 0.80
		WHERE Position IN ('Boss', 'Managment')
	END
END
GO

GO
CREATE TRIGGER NoHoliday
ON Holidays
INSTEAD OF INSERT
AS
BEGIN
	DECLARE curs CURSOR FOR SELECT * FROM inserted
	OPEN curs
	DECLARE @ID INT
	DECLARE @Sdate DATE
	DECLARE @Edate DATE
	FETCH curs INTO @ID, @Sdate, @Edate

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF( ((SELECT * FROM Holidays WHERE @Sdate BETWEEN StartDate AND EndDate) IS EMPTY)
		AND (SELECT * FROM Holidays WHERE @Edate BETWEEN StartDate AND EndDate) IS EMPTY))
		BEGIN
		INSERT INTO Holidays VALUES(@ID, @Sdate, @Edate)
		END
		FETCH cur INTO @ID, @Sdate, @Edate
	END


	CLOSE curs
	DEALLOCATE curs

END
GO

GO
CREATE TRIGGER FireEmployee
ON Employees
AFTER DELETE
AS
BEGIN

	DECLARE curs CURSOR FOR SELECT FirstName, LastName FROM deleted
	OPEN curs
	DECLARE @Fname NVARCHAR(50)
	DECLARE @Lname NVARCHAR(50)
	FETCH curs INTO @Fname, @Lname

	WHILE (@@FETCH_STATUS = 0)
	BEGIN

		PRINT 'Employee' + @Fname + ' ' + @Lname + ' got fired'
		FETCH curs INTO @Fname, @Lname
	END
END
GO
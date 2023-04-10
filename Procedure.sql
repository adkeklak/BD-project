GO
CREATE PROCEDURE Add_Employee(
 @ID INT = NULL,
 @first_name VARCHAR(50) = NULL,
 @second_name VARCHAR(50) = NULL,
 @PESEL CHAR(11) = NULL,
 @gender NVARCHAR(50) = NULL,
 @birth_date DATE = NULL,
 @hire_date DATE = NULL,
 @salary MONEY = NULL,
 @phone_number CHAR(9),
 @address VARCHAR(50) = NULL,
 @department VARCHAR(50) = NULL,
 @position VARCHAR(50) = NULL,
 @out BIT OUTPUT
)
AS
DECLARE @error_msg NVARCHAR(100)
	IF @ID is NULL OR @first_name IS NULL OR @second_name IS NULL OR @PESEL IS NULL OR @gender IS NULL 
	   OR @birth_date IS NULL OR @hire_date IS NULL OR @salary IS NULL OR @address IS NULL 
       OR @department IS NULL OR @position IS NULL
	BEGIN 
		SET @error_msg = 'Invalid data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
		RETURN
	END

	BEGIN TRY
		INSERT INTO Employees VALUES
			(@ID, @first_name, @second_name, @PESEL, @gender, @birth_date, @hire_date, @salary, @phone_number, @address, @department, @position)
	END TRY
	BEGIN CATCH
		SET @error_msg = 'Problem with data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
	END CATCH
	
RETURN

GO

GO

CREATE PROCEDURE Add_Line(
 @ID INT = NULL,
 @StartID INT = NULL,
 @EndID INT = NULL,
 @Night BIT = NULL,
 @out BIT OUTPUT
)
AS
DECLARE @error_msg NVARCHAR(100)
	IF @ID is NULL OR @StartID IS NULL OR @EndID IS NULL
	BEGIN 
		SET @error_msg = 'Invalid data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
		RETURN
	END
    
    IF (SELECT * From Stops Where StopID = @StartID) IS NULL
	BEGIN 
		SET @error_msg = 'Invalid data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
		RETURN
	END
    
    IF (SELECT * From Stops Where StopID = @EndID) IS NULL
	BEGIN 
		SET @error_msg = 'Invalid data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
		RETURN
	END


	BEGIN TRY
		INSERT INTO Lines VALUES
			(@ID, @StartID, @EndID, @Night)
	END TRY
	BEGIN CATCH
		SET @error_msg = 'Problem with data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
	END CATCH
	
RETURN

GO

CREATE PROCEDURE Give_Holiday(
 @ID INT = NULL,
 @Start DATE = NULL,
 @End DATE = NULL,
 @out BIT OUTPUT
)
AS
DECLARE @error_msg NVARCHAR(100)

	IF @ID is NULL OR @Start IS NULL OR @End IS NULL
	BEGIN 
		SET @error_msg = 'Invalid data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
		RETURN
	END

	BEGIN TRY
		INSERT INTO Holidays VALUES
			(@ID, @Start, @End)
	END TRY
	BEGIN CATCH
		
		SET @error_msg = 'Cant give holiday at that time'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
	END CATCH
	
RETURN

GO

GO

CREATE PROCEDURE IncreaceTicketPrice(
 @Change FLOAT = NULL, -- procentowa zmiana stawki za godzine biletu
 @out BIT OUTPUT
)
AS
DECLARE @error_msg NVARCHAR(100)
	IF @change is NULL
	BEGIN 
		SET @error_msg = 'Invalid data'
		SET @out = 1
		RAISERROR(@error_msg, 16, 1)
		RETURN
	END

	UPDATE Tickets
	SET Price = Price * @Change

	
RETURN

GO

GO

CREATE PROCEDURE GiveSalary
AS
	
	DECLARE curs CURSOR FOR SELECT EmployeeID, Salary FROM Employees
	OPEN curs
	DECLARE @ID INT
	DECLARE @Salary MONEY
	DECLARE @Date DATE
	SET @DATE = GETDATE()
	FETCH curs INTO @ID, @Salary

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO SalaryHistory VALUES(@ID, @DATE, @Salary)
		
		FETCH cur INTO @ID, @Salary
	END

	CLOSE curs
	DEALLOCATE curs
GO

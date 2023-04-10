CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	PESEL CHAR(11) UNIQUE NOT NULL, 
	Gender VARCHAR(50),
	BirthDate DATE NOT NULL,
	HireDate DATE NOT NULL,
  	Salary MONEY NOT NULL,
	PhoneNumber CHAR(9),
	Address VARCHAR(50) NOT NULL,
	Department VARCHAR(50) NOT NULL,
  	Position VARCHAR(50) NOT NULL,

)

CREATE TABLE Holidays (
	EmployeeID INT NOT NULL,
	StartDate DATE not NULL,
	EndDate DATE NOT NULL,

	PRIMARY KEY (EmployeeID, StartDate),
	FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
)

CREATE TABLE SalaryHistory (
	EmployeeID INT NOT NULL,
	SalaryDate DATE NOT NULL,
  	Amount MONEY NOT NULL,

	PRIMARY KEY (EmployeeID, SalaryDate),
	FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)
)

CREATE TABLE Vehicles (
	VehicleID INT PRIMARY KEY,
	Producer VARCHAR(50) NOT NULL,
	NumberOfSeats INT NOT NULL,
	NumberOfStandingPlaces INT NOT NULL,
	PurchaseDate DATE NOT NULL,
  	LastInspected DATE
)

CREATE TABLE Trams(
	VehicleID INT NOT NULL,
	TramModel VARCHAR(50) NOT NULL,

	FOREIGN KEY (VehicleID) REFERENCES Vehicles (VehicleID)
)

CREATE TABLE Buses(
	VehicleID INT NOT NULL,
	BusModel VARCHAR(50) NOT NULL,
	DoubleDecker BIT NOT NULL,

	FOREIGN KEY (VehicleID) REFERENCES Vehicles (VehicleID)
)


CREATE TABLE Stops (
	StopID INT PRIMARY KEY,
	StopName NVARCHAR(60) NOT NULL,
	TramStop BIT NOT NULL,
	BusStop BIT NOT NULL
)

CREATE TABLE Lines (
	LineID INT PRIMARY KEY,
  	StartStopID INT NOT NULL,
  	EndStopID INT NOT NULL,
	Night BIT NOT NULL,
  
  	FOREIGN KEY (StartStopID) REFERENCES Stops(StopID),
  	FOREIGN KEY (EndStopID) REFERENCES Stops(StopID)
)

CREATE TABLE Connection (
	LineID INT NOT NULL,
  	StopID INT NOT NULL,
  	StopNumber INT NOt NULL,
  
	PRIMARY KEY (LineID, StopID),
	FOREIGN KEY (StopID) REFERENCES Stops(StopID),
  	FOREIGN KEY (LineID) REFERENCES Lines(LineID)
)

CREATE TABLE Tickets (
	TicketID INT PRIMARY KEY,
	Name VARCHAR(75) NOT NULL,
	Time INT NOT NULL, -- czas trwania biletu w godzinach
	Price MONEY NOT NULL
)

CREATE TABLE TicketsHistory (
	TicketID INT NOT NULL,
	Price MONEY NOT NULL,
  	Time DATE NOT NULL,
  
  	FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
)





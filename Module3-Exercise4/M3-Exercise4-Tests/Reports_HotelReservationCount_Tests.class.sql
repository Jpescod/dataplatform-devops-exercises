EXEC tSQLt.NewTestClass 'Reports_HotelReservationCount_Tests';
GO
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test get 1 hotel reservation for 1 hotel] 
AS
BEGIN

--Mock tables
	EXEC tSQLt.FakeTable 
		@TableName = N'Reservations', 
		@SchemaName = N'Booking';
	EXEC tSQLt.FakeTable 
		@TableName = N'Hotels', 
		@SchemaName = 'Vendors';		
--
--test Data
	INSERT INTO Vendors.Hotels	(HotelId,Name,HotelState,CostPerNight,AdditionalColumns)
		VALUES	(400,N'UnreachableHotel','ZZ',999,NULL)
	INSERT INTO Booking.Reservations (ReservationId,CustomerId,HotelId,AdditionalColumns)	
		VALUES	(1,1,400, NULL)

		
	SELECT TOP(0) A.* INTO #Expected FROM Marketing.HotelReservationCount A RIGHT JOIN Marketing.HotelReservationCount X ON 1=0;


	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				  VALUES (400, 'UnreachableHotel', 'ZZ', 1);
				  
	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Marketing.HotelReservationCount
--

  EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO
CREATE PROCEDURE Reports_HotelReservationCount_Tests.[test get many hotel reservation for 1 hotel] 
AS
BEGIN

--Mock tables
	EXEC tSQLt.FakeTable 
		@TableName = N'Reservations', 
		@SchemaName = N'Booking';
	EXEC tSQLt.FakeTable 
		@TableName = N'Hotels', 
		@SchemaName = 'Vendors';		
--
--test Data
	INSERT INTO Vendors.Hotels	(HotelId,Name,HotelState,CostPerNight,AdditionalColumns)
		VALUES	(400,N'UnreachableHotel','ZZ',999,NULL),
				(500,N'ReachableHotel','ZY',800,NULL)
	INSERT INTO Booking.Reservations (ReservationId,CustomerId,HotelId,AdditionalColumns)	
		VALUES	(1,1,400, NULL),
				(2,2,400, NULL),
				(1,3,500, NULL)

		
	SELECT TOP(0) A.* INTO #Expected FROM Marketing.HotelReservationCount A RIGHT JOIN Marketing.HotelReservationCount X ON 1=0;


	INSERT INTO #Expected (HotelId, HotelName, HotelState, ReservationCount) 
				  VALUES (400, 'UnreachableHotel', 'ZZ', 2);
				  
	SELECT HotelId, HotelName, HotelState, ReservationCount
	INTO #Actual
	FROM Marketing.HotelReservationCount where HotelName = 'UnreachableHotel'
--

  EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END
GO
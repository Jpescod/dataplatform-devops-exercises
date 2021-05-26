EXEC tSQLt.NewTestClass 'Marketing_GetGreeting_Tests';
GO

CREATE PROCEDURE Marketing_GetGreeting_Tests.[test Greeting John Smith returns Dear J. Smith]
AS
BEGIN
	declare @Firstname nvarchar(100)='John'
	declare @LastName nvarchar(100)='Smith'
	declare @Expected nvarchar(100) 
	set @Expected= 'Dear J. Smith'

	declare @Actual nvarchar(100) 
	set @Actual= Marketing.GetGreeting(@Firstname,@LastName)

	Exec tSQLt.AssertEqualsString @Expected, @Actual
END
GO
CREATE PROCEDURE Marketing_GetGreeting_Tests.[test Greeting Jane Doe returns Dear J. Doe]
AS
BEGIN
	declare @Firstname nvarchar(100)='Jane'
	declare @LastName nvarchar(100)='Doe'
	declare @Expected nvarchar(100) 
	set @Expected= 'Dear J. Doe'

	declare @Actual nvarchar(100) 
	set @Actual= Marketing.GetGreeting(@Firstname,@LastName)

	Exec tSQLt.AssertEqualsString @Expected, @Actual
END
GO
CREATE PROCEDURE Marketing_GetGreeting_Tests.[test Greeting Null first name returns Dear Friend]
AS
BEGIN
	declare @Firstname nvarchar(100)=null
	declare @LastName nvarchar(100)='Smith'
	declare @Expected nvarchar(100) 
	set @Expected= 'Dear Friend'

	declare @Actual nvarchar(100) 
	set @Actual= Marketing.GetGreeting(@Firstname,@LastName)

	Exec tSQLt.AssertEqualsString @Expected, @Actual
END
GO
CREATE PROCEDURE Marketing_GetGreeting_Tests.[test Greeting Null last name returns Hi Amy]
AS
BEGIN
	declare @Firstname nvarchar(100)='Amy'
	declare @LastName nvarchar(100)= null
	declare @Expected nvarchar(100) 
	set @Expected= 'Hi Amy'

	declare @Actual nvarchar(100) 
	set @Actual= Marketing.GetGreeting(@Firstname,@LastName)

	Exec tSQLt.AssertEqualsString @Expected, @Actual
END
GO
--No last name (null)
--No first name (Blank)
--No last name (Blank)
--First Name with apostraphy
--Last name with apostraphy
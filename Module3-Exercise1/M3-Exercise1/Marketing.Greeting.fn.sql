create or alter function Marketing.GetGreeting(@Firstname as nvarchar(100), @LastName as nvarchar(100))
Returns nvarchar(100)
begin
	Declare @Return as nvarchar(100)
	if (@Firstname is null)
	begin
		set @Return = 'Dear Friend' 
	end
	else 
	Begin
		if (@LastName  is null)
		begin
			set @Return ='Hi '+ @Firstname
		end
		else
		begin
			set @Return = 'Dear ' + SUBSTRING(@Firstname,1,1)+'. '+@LastName
		end
	end
	return @Return
end 
go

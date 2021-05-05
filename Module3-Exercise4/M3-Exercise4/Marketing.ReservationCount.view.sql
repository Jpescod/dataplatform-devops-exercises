CREATE VIEW Marketing.HotelReservationCount AS
SELECT 
	res.HotelId, 
	hotel.Name AS HotelName, 
	hotel.HotelState, 
	COUNT(res.ReservationId) AS ReservationCount
FROM Vendors.Hotels hotel
	RIGHT JOIN Booking.Reservations res
	ON res.HotelId = hotel.HotelId
GROUP BY 
	res.HotelId, 
	hotel.Name, 
	hotel.HotelState
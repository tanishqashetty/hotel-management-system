/*
 Write the SQL code to create two (2) stored procedures to populate transactional tables
*/

CREATE PROCEDURE InsertinEmployee
     @empName VARCHAR(50),
     @empPhone INT,
     @empRole VARCHAR(50),
     @empJoinDate DATE,
     @hotelName VARCHAR(50)

AS DECLARE @hotelID INT
SET @hotelID=(SELECT hotelID FROM Hotel WHERE hotelName= @hotelName)

IF @hotelID IS NULL 
BEGIN
PRINT'The hotel does not exist';
THROW 55463, 'Please try again',1;
END

BEGIN TRANSACTION T1
INSERT INTO Employee(empName, empPhone, empJoinDate, empRole, hotelID)
VALUES(@empName, @empPhone, @empJoinDate, @empRole, @hotelID)
COMMIT TRANSACTION T1



EXEC InsertinEmployee
@empName='Megan M',
@empPhone= 213560090,
@empRole= 'Receptionist',
@empJoinDate='2021-04-08',
@hotelName='Westin Grand'
GO;

SELECT * FROM Hotel
SELECT * FROM Employee
GO;
/*----------------------------------------------------------------*/

CREATE PROCEDURE InsertRoomGuest
@guestName VARCHAR(50),
@hotelName VARCHAR(50),
@roomPrice INT

AS DECLARE @roomID INT, @guestID INT
SET @roomID = (SELECT roomID FROM Room WHERE roomPrice=@roomPrice AND hotelID=(SELECT hotelID FROM Hotel WHERE hotelName=@hotelName))

SET @guestID= (SELECT guestID FROM Guest WHERE guestName=@guestName)

BEGIN TRANSACTION T2
INSERT INTO Room_Guest(roomID, guestID)
VALUES(@roomID, @guestID)
COMMIT TRANSACTION T2

IF @roomID IS NULL 
BEGIN
PRINT'The room ID does not exist';
THROW 55463, 'Please try again',1;
END

IF @guestID IS NULL 
BEGIN
PRINT'The guest ID does not exist';
THROW 55465, 'Please try again',1;
END

EXEC InsertRoomGuest
@guestName='Jim Smith',
@hotelName='Four Seasons San Francisco',
@roomPrice=750
GO;

/*
Write the SQL code to create two (2) triggers
*/

/*----------------------------------------------------------------

This is a trigger that stop the deletion of any value in the hotel table
*/

CREATE TRIGGER prevent_deletion
ON Hotel
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Deletion from Hotel table is not allowed.', 16, 1);
    ROLLBACK TRANSACTION;
END;

DELETE FROM Hotel WHERE hotelID=1
GO;
/* Here, I have created a trigger that will set the availability status of the room to 'No' when there is a new reservation made on the reservation table
*/

CREATE TRIGGER ReserveRoom
ON Reservation
AFTER INSERT
AS
BEGIN
    UPDATE Room
    SET availabilityStatus = 'No'
    WHERE Room.roomID IN (SELECT roomID FROM inserted)
END;
GO

INSERT INTO Reservation(guestID, hotelID, reservationDate,duration, cost)
VALUES(2,1,'2023-03-03',5,750)
GO


/* Write the SQL code to create two (2) computed columns
*/

/* Computing the number of days an employee has been a part of the hotel */

ALTER TABLE Employee
ADD DaysSinceJoining AS DATEDIFF(day, empJoinDate, GETDATE());


/* Computing the check out date based on the reservation date and duration */

ALTER TABLE Reservation
ADD CheckoutDate AS DATEADD(day, Duration, ReservationDate);

/* Write the SQL code to create two (2) different complex queries. */

/* I am writing a query where the number of occupants are being generated for each room and the corresponding hotel name is displayed based on the roomID */

SELECT Room_Guest.roomID, COUNT(Room_Guest.guestID)as NumberOfOccupants , Hotel.hotelName as HotelResiding
FROM Room_Guest 
INNER JOIN Room ON Room_Guest.roomID=Room.roomID 
INNER JOIN Hotel ON Room.hotelID=Hotel.hotelID 
GROUP BY Room_Guest.roomID, Hotel.hotelName;
GO

/* I am writing a query to find the top 3 hotels with the highest average room prices */
SELECT TOP 3
  h.hotelName,
  AVG(r.roomPrice) AS avgRoomPrice
FROM
  Hotel h
  INNER JOIN Room r ON h.hotelID = r.hotelID
GROUP BY
  h.hotelName
ORDER BY
  avgRoomPrice DESC;
  GO




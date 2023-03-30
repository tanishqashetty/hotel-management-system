CREATE DATABASE HotelManagement


CREATE TABLE Hotel (
  hotelID INT PRIMARY KEY IDENTITY(1,1),
  hotelName VARCHAR(255) NOT NULL,
  hotelAddress VARCHAR(255) NOT NULL,
  hotelContact VARCHAR(255) NOT NULL,
  hotelEmail VARCHAR(255),
  totalRooms INT NOT NULL,
  hotelWebsite VARCHAR(255) NOT NULL
);

CREATE TABLE Room (
  roomID INT PRIMARY KEY IDENTITY(1,1),
  hotelID INT NOT NULL,
  roomType VARCHAR(255) NOT NULL,
  availabilityStatus VARCHAR(255) NOT NULL,
  roomPrice INT NOT NULL,
  roomFloor VARCHAR(255)
  FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID)
);


CREATE TABLE Room_Service (
  serviceID INT PRIMARY KEY IDENTITY(1,1),
  items VARCHAR(255) ,
  quantity INT,
  serviceDate DATE,
);

CREATE TABLE Guest (
  guestID INT PRIMARY KEY IDENTITY(1,1),
  guestName VARCHAR(255) NOT NULL,
  guestPhone VARCHAR(255) NOT NULL,
  guestEmail VARCHAR(255) NOT NULL,
  guestAddress VARCHAR(255)
);

CREATE TABLE Amenities (
  amenityID INT PRIMARY KEY IDENTITY(1,1),
  roomID INT NOT NULL,
  amenityPrice INT NOT NULL,
  amenityName VARCHAR(255) NOT NULL,
  FOREIGN KEY (roomID) REFERENCES Room(roomID)
);

CREATE TABLE Reservation (
  reservationID INT PRIMARY KEY IDENTITY(1,1),
  guestID INT NOT NULL,
  hotelID INT NOT NULL,
  reservationDate DATE,
  duration INT NOT NULL,
  cost INT NOT NULL,
  FOREIGN KEY (guestID) REFERENCES Guest(guestID),
  FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID)
);

CREATE TABLE Payment (
  paymentID INT PRIMARY KEY IDENTITY(1,1),
  reservationID INT NOT NULL,
  amount INT NOT NULL,
  method VARCHAR(255) NOT NULL,
  FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID)
);

CREATE TABLE Bill (
  billID INT PRIMARY KEY IDENTITY(1,1),
  paymentID INT NOT NULL,
  roomID INT NOT NULL,
  totalAmt VARCHAR(255) NOT NULL,
  FOREIGN KEY (roomID) REFERENCES Room(roomID),
  FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
);

CREATE TABLE Employee (
  empID INT PRIMARY KEY IDENTITY(101,1),
  hotelID INT NOT NULL,
  empPhone INT NOT NULL,
  empName VARCHAR(255) NOT NULL,
  empRole VARCHAR(255),
  empJoinDate DATE,
  FOREIGN KEY (hotelID) REFERENCES Hotel(hotelID)
);

CREATE TABLE Maintainence_Req (
  requestID INT PRIMARY KEY IDENTITY(1,1),
  requestType VARCHAR(255) NOT NULL,
  requestDate DATE,
);


CREATE TABLE Room_MaintainenceReq(
    roomID int NOT NULL,
    requestID int NOT NULL,
    PRIMARY KEY (roomID,requestID),
    FOREIGN KEY (roomID ) REFERENCES Room(roomID ),
    FOREIGN KEY (requestID ) REFERENCES Maintainence_Req(requestID )
    );

CREATE TABLE Room_RoomService(
    roomID int NOT NULL,
    serviceID int NOT NULL,
    PRIMARY KEY (roomID,serviceID),
    FOREIGN KEY (roomID ) REFERENCES Room(roomID ),
    FOREIGN KEY (serviceID ) REFERENCES Room_Service(serviceID )
    );

CREATE TABLE Room_Guest(
    roomID int NOT NULL,
    guestID int NOT NULL,
    FOREIGN KEY (roomID ) REFERENCES Room(roomID ),
    FOREIGN KEY (guestID ) REFERENCES Guest(guestID )
    );
  DROP TABLE Room_Guest
    

INSERT INTO Hotel(hotelName, hotelAddress, hotelContact, hotelEmail, totalRooms,hotelWebsite)
VALUES('The Plaza', '10th Street, New York', '+1-289-567-098','plaza@ny.com',30,'www.theplaza.com')

INSERT INTO Hotel(hotelName, hotelAddress, hotelContact, hotelEmail, totalRooms,hotelWebsite)
VALUES('Westin Grand', 'Pine Street, Seattle', '+1-206-321-098','westinseattle@westin.com',150,'www.westinseattle.com')

INSERT INTO Hotel(hotelName, hotelAddress, hotelContact, hotelEmail, totalRooms,hotelWebsite)
VALUES('Taj Mahal Palace', 'Colaba, Mumbai', '+91-2225634567','thetajmahalpalace@tajhotels.com',400,'www.tajmahalpalace.com')

INSERT INTO Hotel(hotelName, hotelAddress, hotelContact, hotelEmail, totalRooms,hotelWebsite)
VALUES('Four Seasons San Francisco', 'Powell Street, San Francisco', '+1-222-568-0567','foruseasonssf@fourseasons.com',120,'www.fourseasonssf.com')

INSERT INTO Hotel(hotelName, hotelAddress, hotelContact, hotelEmail, totalRooms,hotelWebsite)
VALUES('Oberoi, Mumbai', 'Marine Drive, Mumbai', '+91-222789-0523','oberoimumbai@eastindiahotels.com',120,'www.oberoumumbai.com')


INSERT INTO Room(hotelID, roomType, availabilityStatus, roomPrice, roomFloor)
VALUES(3, 'Standard', 'Yes',127,'1')

INSERT INTO Room(hotelID, roomType, availabilityStatus, roomPrice, roomFloor)
VALUES(4, 'Presidential Suite', 'No',750,'9')

INSERT INTO Room(hotelID, roomType, availabilityStatus, roomPrice, roomFloor)
VALUES(1, 'Deluxe', 'Yes',230,'2')

INSERT INTO Room(hotelID, roomType, availabilityStatus, roomPrice, roomFloor)
VALUES(1, 'Standard', 'Yes',100,'5')

INSERT INTO Room(hotelID, roomType, availabilityStatus, roomPrice, roomFloor)
VALUES(2, 'Deluxe', 'No',130,'3')



INSERT INTO Room_Service( items, quantity, serviceDate)
VALUES( 'Towels', 2,'2022-01-23')

INSERT INTO Room_Service( items, quantity, serviceDate)
VALUES( 'Tea & Coffee Sachets', 10,'2022-08-10')

INSERT INTO Room_Service( items, quantity, serviceDate)
VALUES( 'Bathing Soap', 4,'2022-05-23')

INSERT INTO Room_Service( items, quantity, serviceDate)
VALUES('Towels & Napkins', 2,'2022-03-13')

INSERT INTO Room_Service( items, quantity, serviceDate)
VALUES('Breakfast in Bed', 1,'2022-04-11')



INSERT INTO Guest (guestName, guestPhone, guestEmail, guestAddress)
VALUES ('John Doe', '555-555-5555', 'johndoe@example.com',  '123 Main St');

INSERT INTO Guest (guestName, guestPhone, guestEmail )
VALUES ('Jane Doe', '555-555-5556', 'janedoe@example.com' );

INSERT INTO Guest (guestName, guestPhone, guestEmail, guestAddress)
VALUES ('Jim Smith', '555-555-5557', 'jimsmith@example.com', '789 Oak St');

INSERT INTO Guest (guestName, guestPhone, guestEmail, guestAddress)
VALUES ('Sara Johnson', '555-555-5558', 'sarajohnson@example.com', '246 Pine St');

INSERT INTO Guest (guestName, guestPhone, guestEmail, guestAddress)
VALUES ('Tom Brown', '555-555-5559', 'tombrown@example.com', '369 Maple St');


INSERT INTO Amenities (roomID, amenityPrice, amenityName)
VALUES (1, 50, 'Breakfast');

INSERT INTO Amenities (roomID, amenityPrice, amenityName)
VALUES (4, 75, 'Spa');

INSERT INTO Amenities (roomID, amenityPrice, amenityName)
VALUES (2, 100, 'Gym');

INSERT INTO Amenities (roomID, amenityPrice, amenityName)
VALUES (5, 25, 'Pool');

INSERT INTO Amenities (roomID, amenityPrice, amenityName)
VALUES (4, 75, 'Parking');


INSERT INTO Reservation (guestID, hotelID, reservationDate, duration, cost)
VALUES (1, 1, '2023-02-12', 3, 200);

INSERT INTO Reservation (guestID, hotelID, reservationDate, duration, cost)
VALUES (2, 1, '2023-02-13', 4, 250);

INSERT INTO Reservation (guestID, hotelID, reservationDate, duration, cost)
VALUES (3, 2, '2023-02-14', 5, 300);

INSERT INTO Reservation (guestID, hotelID, reservationDate, duration, cost)
VALUES (4, 2, '2023-02-15', 2, 150);

INSERT INTO Reservation (guestID, hotelID, reservationDate, duration, cost)
VALUES (5, 3, '2023-02-16', 3, 200);




INSERT INTO Payment (reservationID, amount, method)
VALUES (1, 200, 'Credit Card');

INSERT INTO Payment (reservationID, amount, method)
VALUES (2, 250, 'Debit Card');

INSERT INTO Payment (reservationID, amount, method)
VALUES (3, 300, 'PayPal');

INSERT INTO Payment (reservationID, amount, method)
VALUES (4, 150, 'Cash');

INSERT INTO Payment (reservationID, amount, method)
VALUES (5, 200, 'Credit Card');


INSERT INTO Bill (paymentID, roomID, totalAmt)
VALUES (1, 1, '200');

INSERT INTO Bill (paymentID, roomID, totalAmt)
VALUES (2, 1, '250');

INSERT INTO Bill (paymentID, roomID, totalAmt)
VALUES (3, 2, '300');

INSERT INTO Bill (paymentID, roomID, totalAmt)
VALUES (4, 4, '150');

INSERT INTO Bill (paymentID, roomID, totalAmt)
VALUES (5, 3, '200');



INSERT INTO Employee (hotelID, empPhone, empName, empRole, empJoinDate)
VALUES (1, 1234567890, 'John Doe', 'Manager', '2022-01-01');

INSERT INTO Employee (hotelID, empPhone, empName, empRole, empJoinDate)
VALUES (2, 1234567891, 'Jane Doe', 'Receptionist', '2022-02-01');

INSERT INTO Employee (hotelID, empPhone, empName, empRole, empJoinDate)
VALUES (1, 1234567892, 'Jim Smith', 'Housekeeper', '2022-03-01');

INSERT INTO Employee (hotelID, empPhone, empName, empRole, empJoinDate)
VALUES (3, 1234567893, 'Sarah Johnson', 'Chef', '2022-04-01');

INSERT INTO Employee (hotelID, empPhone, empName, empRole, empJoinDate)
VALUES (5, 1234567894, 'Alex Brown', 'Security', '2022-05-01');


INSERT INTO Maintainence_Req ( requestType, requestDate)
VALUES
  ( 'Light fixture repair', '2022-01-01'),
  ( 'Plumbing issue', '2022-02-01'),
  ( 'Carpet replacement', '2022-03-01'),
  ( 'AC repair', '2022-04-01'),
  ( 'Painting', '2022-05-01');


INSERT INTO Room_RoomService (roomID, serviceID)
VALUES
  (1, 1),
  (1, 2),
  (3, 2),
  (4, 3),
  (5, 4);

INSERT INTO Room_MaintainenceReq (roomID, requestID)
VALUES (1, 2), (2, 5), (3, 5), (4, 2), (5, 3);

INSERT INTO Room_Guest(roomID, guestID)
VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);


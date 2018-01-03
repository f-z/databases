-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2016-10-02 01:15:00.086

-- tables
-- Table: car
CREATE TABLE car (
    carID int(4) NOT NULL,
    carType varchar(15) NOT NULL,
    carColor varchar(10) NOT NULL,
    carYear int(4) NOT NULL,
    driverNeeded bool NOT NULL,
    hotelID int(4) NOT NULL,
    CONSTRAINT car_pk PRIMARY KEY (carID)
);

-- Table: carRental
CREATE TABLE carRental (
    TimeFrom time NOT NULL,
    TimeTo time NOT NULL,
    carCount int(2) NOT NULL,
    reservationID int(10) NOT NULL,
    carID int(4) NOT NULL,
    CONSTRAINT carRental_pk PRIMARY KEY (reservationID,carID)
);

-- Table: guest
CREATE TABLE guest (
    gID int(4) NOT NULL,
    gFName varchar(15) NOT NULL,
    gMI varchar(1) NOT NULL,
    gLName varchar(25) NOT NULL,
    gEmail varchar(15) NOT NULL,
    gPassportNo varchar(15) NOT NULL,
    gPhoneNo int(14) NOT NULL,
    gStreet varchar(25) NOT NULL,
    gCity varchar(15) NOT NULL,
    gState varchar(2) NOT NULL,
    gZip int(5) NOT NULL,
    gCountry varchar(25) NOT NULL,
    CONSTRAINT guest_pk PRIMARY KEY (gID)
);

-- Table: hotel
CREATE TABLE hotel (
    hotelID int(4) NOT NULL,
    hotelName varchar(15) NOT NULL,
    hotelAddress varchar(25) NOT NULL,
    hotelZip varchar(5) NOT NULL,
    hotelCity varchar(15) NOT NULL,
    hotelState varchar(2) NOT NULL,
    hotelStarRating int(7) NOT NULL,
    hotelURL varchar(25) NOT NULL,
    CONSTRAINT hotel_pk PRIMARY KEY (hotelID)
);

-- Table: reservation
CREATE TABLE reservation (
    reservationID int(10) NOT NULL,
    dateFrom date NOT NULL,
    dateTo date NOT NULL,
    amountPaid double(6,2) NOT NULL,
    numGuests int(2) NOT NULL,
    parkingNeeded bool NOT NULL,
    gID int(4) NOT NULL,
    CONSTRAINT reservation_pk PRIMARY KEY (reservationID)
);

-- Table: restaurReservation
CREATE TABLE restaurReservation (
    rTimeFrom time NOT NULL,
    rTimeTo time NOT NULL,
    tableCount int(2) NOT NULL,
    reservationID int(10) NOT NULL,
    restaurID int(4) NOT NULL,
    CONSTRAINT restaurReservation_pk PRIMARY KEY (reservationID,restaurID)
);

-- Table: restaurant
CREATE TABLE restaurant (
    restaurID int(4) NOT NULL,
    restaurName varchar(25) NOT NULL,
    michelinStars int(3) NOT NULL,
    `table` int(3) NOT NULL,
    hotelID int(4) NOT NULL,
    cuisine varchar(15) NOT NULL,
    CONSTRAINT restaurant_pk PRIMARY KEY (restaurID)
);

-- Table: room
CREATE TABLE room (
    roomNo int(5) NOT NULL,
    roomFloor int(2) NOT NULL,
    roomType varchar(15) NOT NULL,
    CONSTRAINT room_pk PRIMARY KEY (roomNo)
);

-- Table: roomReservation
CREATE TABLE roomReservation (
    roomCount int(2) NOT NULL,
    checkedIn bool NOT NULL,
    reservationID int(10) NOT NULL,
    roomNo int(5) NOT NULL,
    CONSTRAINT roomReservation_pk PRIMARY KEY (reservationID,roomNo)
);

-- Table: roomType
CREATE TABLE roomType (
    roomType varchar(15) NOT NULL,
    roomStdRate double(5,2) NOT NULL,
    roomTypeDesc varchar(35) NOT NULL,
    smoking bool NOT NULL,
    view varchar(10) NOT NULL,
    hotelID int(4) NOT NULL,
    CONSTRAINT roomType_pk PRIMARY KEY (roomType)
);

-- Table: spa
CREATE TABLE spa (
    spaID int(4) NOT NULL,
    spaName varchar(25) NOT NULL,
    spaService varchar(25) NOT NULL,
    priceSpaService double(5,2) NOT NULL,
    hotelID int(4) NOT NULL,
    CONSTRAINT spa_pk PRIMARY KEY (spaID)
);

-- Table: spaReservation
CREATE TABLE spaReservation (
    spaResID int(10) NOT NULL,
    sTimeFrom time NOT NULL,
    sTimeTo time NOT NULL,
    reservationID int(10) NOT NULL,
    spaID int(4) NOT NULL,
    CONSTRAINT spaReservation_pk PRIMARY KEY (reservationID,spaID)
);

-- foreign keys
-- Reference: car_hotel (table: car)
ALTER TABLE car ADD CONSTRAINT car_hotel FOREIGN KEY car_hotel (hotelID)
    REFERENCES hotel (hotelID)
    ON DELETE RESTRICT;

-- Reference: reservation_guest (table: reservation)
ALTER TABLE reservation ADD CONSTRAINT reservation_guest FOREIGN KEY reservation_guest (gID)
    REFERENCES guest (gID)
    ON DELETE RESTRICT;

-- Reference: restaurReservation_reservation (table: restaurReservation)
ALTER TABLE restaurReservation ADD CONSTRAINT restaurReservation_reservation FOREIGN KEY restaurReservation_reservation (reservationID)
    REFERENCES reservation (reservationID)
    ON DELETE RESTRICT;

-- Reference: restaurReservation_restaurant (table: restaurReservation)
ALTER TABLE restaurReservation ADD CONSTRAINT restaurReservation_restaurant FOREIGN KEY restaurReservation_restaurant (restaurID)
    REFERENCES restaurant (restaurID);

-- Reference: restaurant_hotel (table: restaurant)
ALTER TABLE restaurant ADD CONSTRAINT restaurant_hotel FOREIGN KEY restaurant_hotel (hotelID)
    REFERENCES hotel (hotelID)
    ON DELETE RESTRICT;

-- Reference: roomReservation_reservation (table: roomReservation)
ALTER TABLE roomReservation ADD CONSTRAINT roomReservation_reservation FOREIGN KEY roomReservation_reservation (reservationID)
    REFERENCES reservation (reservationID)
    ON DELETE RESTRICT;

-- Reference: roomReservation_room (table: roomReservation)
ALTER TABLE roomReservation ADD CONSTRAINT roomReservation_room FOREIGN KEY roomReservation_room (roomNo)
    REFERENCES room (roomNo);

-- Reference: roomType_hotel (table: roomType)
ALTER TABLE roomType ADD CONSTRAINT roomType_hotel FOREIGN KEY roomType_hotel (hotelID)
    REFERENCES hotel (hotelID)
    ON DELETE RESTRICT;

-- Reference: room_roomType (table: room)
ALTER TABLE room ADD CONSTRAINT room_roomType FOREIGN KEY room_roomType (roomType)
    REFERENCES roomType (roomType);

-- Reference: spaReservation_reservation (table: spaReservation)
ALTER TABLE spaReservation ADD CONSTRAINT spaReservation_reservation FOREIGN KEY spaReservation_reservation (reservationID)
    REFERENCES reservation (reservationID)
    ON DELETE RESTRICT;

-- Reference: spaReservation_spa (table: spaReservation)
ALTER TABLE spaReservation ADD CONSTRAINT spaReservation_spa FOREIGN KEY spaReservation_spa (spaID)
    REFERENCES spa (spaID)
    ON DELETE RESTRICT;

-- Reference: spa_hotel (table: spa)
ALTER TABLE spa ADD CONSTRAINT spa_hotel FOREIGN KEY spa_hotel (hotelID)
    REFERENCES hotel (hotelID)
    ON DELETE RESTRICT;

-- Reference: valetReservation_Copy_of_restaurant (table: carRental)
ALTER TABLE carRental ADD CONSTRAINT valetReservation_Copy_of_restaurant FOREIGN KEY valetReservation_Copy_of_restaurant (carID)
    REFERENCES car (carID)
    ON DELETE RESTRICT;

-- Reference: valetReservation_reservation (table: carRental)
ALTER TABLE carRental ADD CONSTRAINT valetReservation_reservation FOREIGN KEY valetReservation_reservation (reservationID)
    REFERENCES reservation (reservationID)
    ON DELETE RESTRICT;

-- End of file.


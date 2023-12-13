DROP TABLE IF EXISTS
`train2`.`Cargo_carriage`,
`train2`.`Carriage`,
`train2`.`CommercialUse_carriage`,
`train2`.`Connected_Path`,
`train2`.`Detailed_Path`,
`train2`.`ITX`,
`train2`.`In_flight_Meal_ID`,
`train2`.`Ktx`,
`train2`.`MaintenanceID`,
`train2`.`MaintenanceRecord`,
`train2`.`Mugunghwa`,
`train2`.`Passenger_Fare`,
`train2`.`Path`,
`train2`.`Route`,
`train2`.`Saemaeul`,
`train2`.`Service_Fare`,
`train2`.`Special_Fare`,
`train2`.`Station`,
`train2`.`Timetable`,
`train2`.`cargo_compartment_fare`,
`train2`.`container_fare`,
`train2`.`locomotive`,
`train2`.`passengers_carriage`,
`train2`.`seat`,
`train2`.`train`,
`train2`.`Actual_Run`,
`train2`.`Additional_Service_ID`,
`train2`.`Cargo_Fare`,
`train2`.`Fare`,
`train2`.`Normal_Fare`,
`train2`.`Season_Fare`,
`train2`.`company_user`,
`train2`.`individual_user`,
`train2`.`refund`,
`train2`.`payment`,
`train2`.`service_payment`,
`train2`.`ticket_payment`,
`train2`.`user`,
`train2`.`user_id`,
`train2`.`user_password`,
`train2`.`cargo_payment`;



/*
<경로 테이블(Path)>
경로ID (Path_ID, PK)
시작역ID (Start_Station_ID, FK)
종료역ID (End_Station_ID, FK)
시간표ID (Timetable_ID, FK)

<시간표 테이블(Timetable)>
시간표ID (Timetable_ID, PK)
출발시간 (Departure_Time)
도착시간 (Arrival_Time)
결제ID (Payment_ID, FK)

<역 테이블(Station)>
역ID (Station_ID, PK)
역명 (Station_Name)
위치 (Location)

<실제운행 테이블(Actual_Run)>
운행ID (Run_ID, PK)
운행날짜 (Run_Date)
실제출발시간 (Actual_Departure_Time)
실제도착시간 (Actual_Arrival_Time)
역ID (Station_ID, FK)

<연결경로 테이블(Connected_Path)>
연결ID (Connection_ID, PK)
경로ID(Path_ID,FK)
순서(Number)
중간역(Inter_Station_ID,FK)

<상세경로 테이블(Detailed_Path)>
상세ID (Detail_ID, PK)
경로ID (Path_ID, FK)
출발역ID(Departure_Station_ID,FK)
도착역ID(Arrival_Station_ID,FK)
간격(Interval)

<노선 테이블(Route)>
노선ID (Route_ID, PK)
노선명 (Route_Name)
시작역ID (Start_Station_ID, FK)
종료역ID (End_Station_ID, FK)

*/


CREATE TABLE IF NOT EXISTS `train2`.`Station` (
  `Station_ID` INT NOT NULL,
  `Station_Name` INT NOT NULL,
  `Location` INT NOT NULL,
  PRIMARY KEY (`Station_ID`)
);

CREATE TABLE IF NOT EXISTS `train2`.`Path` (
  `Path_ID` INT NOT NULL,
  `Start_Station_ID` INT NOT NULL,
  `End_Station_ID` INT NOT NULL,
  PRIMARY KEY (`Path_ID`),
  FOREIGN KEY (Start_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (End_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Timetable` (
  `Timetable_ID` INT NOT NULL,
  `Departure_Time` INT NOT NULL,
  `Arrival_Time` INT NOT NULL,
  `Path_ID` INT NOT NULL,
  PRIMARY KEY (`Timetable_ID`),
  FOREIGN KEY (Path_ID) REFERENCES `train2`.`Path`(`Path_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Connected_Path` (
  `Path_ID` INT NOT NULL,
  `order` INT NOT NULL,
  `Departure_Station_ID` INT NOT NULL,
  `End_Station_ID` INT NOT NULL,
  PRIMARY KEY (`Path_ID`, `order`),
  FOREIGN KEY (Path_ID) REFERENCES `train2`.`Path`(`Path_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (Departure_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (End_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Detailed_Path` (
  `Path_ID` INT NOT NULL,
  `Departure_Station_ID` INT NOT NULL,
  `End_Station_ID` INT NOT NULL,
  PRIMARY KEY (`Path_ID`),
  FOREIGN KEY (Path_ID) REFERENCES `train2`.`Path`(`Path_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (Departure_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (End_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Route` (
  `Route_ID` INT NOT NULL,
  `Route_Name` INT NOT NULL,
  `Start_Station_ID` INT NOT NULL,
  `End_Station_ID` INT NOT NULL,
  PRIMARY KEY (`Route_ID`),
  FOREIGN KEY (Route_ID) REFERENCES `train2`.`Path`(`Path_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (Start_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (End_Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Actual_Run` (
  `Actual_Run_ID` INT NOT NULL,
  `Run_Date` INT NOT NULL,
  `Actual_Departure_Time` INT NOT NULL,
  `Actual_Arrival_Time` INT NOT NULL,
  `Station_ID` INT NOT NULL,
  PRIMARY KEY (`Actual_Run_ID`),
  FOREIGN KEY (Station_ID) REFERENCES `train2`.`Station`(`Station_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/*
좌석 SeatID, SeatNum, SeatClass, TrainID(Fk)
열차 TrainID, Traintype,
기관차 LocomotiveID, ManufactureYear, Manufacturer, MaintenanceID
객차 CarriageID, ManufactureYear, Manufacturer, MaintenanceID
정비_ID MaintenanceID, MaintenanceRecordID
정비기록 MaintenanceRecordID, MaintenanceDate, Mechanic, MaintenanceDetails
KTX Ktx_ID, TrainNum
ITX Itx_ID, TrainNum
새마을 Saemaeul_ID, TrainNum
무궁화 Mugunghwa_ID, TrainNum
승객용 ForPassengers_ID, Capacity
화물용 ForCarriage_ID, CarriageNum, MaximumWeight
상업용 CommercialUse_ID, ProductName, ProductInfo
*/
USE train2;

CREATE TABLE IF NOT EXISTS `train2`.`train` (
  `TrainID` INT NOT NULL,
  `Traintype` INT NOT NULL,
  PRIMARY KEY (`TrainID`)
);

CREATE TABLE IF NOT EXISTS `train2`.`seat` (
  `SeatID` INT NOT NULL,
  `SeatNum` INT NOT NULL,
  `SeatClass` INT NOT NULL,
  `TrainID` INT NOT NULL,
  `Timetable_id` INT NOT NULL,
  PRIMARY KEY (`SeatID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (Timetable_id) REFERENCES `train2`.`Timetable`(`Timetable_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`locomotive` (
  `LocomotiveID` INT NOT NULL,
  `TrainID` INT NOT NULL,
  `Order` INT NOT NULL,
  `ManufactureYear` INT NOT NULL,
  `Manufacturer` INT NOT NULL,
  PRIMARY KEY (`LocomotiveID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Carriage` (
  `CarriageID` INT NOT NULL,
  `TrainID` INT NOT NULL,
  `Order` INT NOT NULL,
  `ManufactureYear` INT NOT NULL,
  `Manufacturer` INT NOT NULL,
  PRIMARY KEY (`CarriageID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`MaintenanceID` (
  `MaintenanceID` INT NOT NULL,
  `MaintenanceRecordID` INT NOT NULL,
  `LocomotiveID` INT,
  `CarriageID` INT,
  PRIMARY KEY (`MaintenanceID`),
  FOREIGN KEY (CarriageID) REFERENCES `train2`.`Carriage`(`CarriageID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (LocomotiveID) REFERENCES `train2`.`locomotive`(`LocomotiveID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`MaintenanceRecord` (
  `MaintenanceRecordID` INT NOT NULL,
  `MaintenanceID` INT NOT NULL,
  `MaintenanceDate` INT NOT NULL,
  `Mechanic` INT NOT NULL,
  `MaintenanceDetails` VARCHAR(255),
  PRIMARY KEY (`MaintenanceRecordID`),
  FOREIGN KEY (MaintenanceID) REFERENCES `train2`.`MaintenanceID`(`MaintenanceID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`passengers_carriage` (
  `passengers_carriage_ID` INT NOT NULL,
  `CarriageID` INT NOT NULL,
  `Capacity` INT NOT NULL,
  `Model_ID` INT NOT NULL,
  PRIMARY KEY (`passengers_carriage_ID`),
  FOREIGN KEY (CarriageID) REFERENCES `train2`.`Carriage`(`CarriageID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Cargo_carriage` (
  `Cargo_carriage_ID` INT NOT NULL,
  `CarriageID` INT NOT NULL,
  `Capacity` INT NOT NULL,
  `Model_ID` INT NOT NULL,
  PRIMARY KEY (`Cargo_carriage_ID`),
  FOREIGN KEY (CarriageID) REFERENCES `train2`.`Carriage`(`CarriageID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`CommercialUse_carriage` (
  `CommercialUse_carriage_ID` INT NOT NULL,
  `CarriageID` INT NOT NULL,
  `Capacity` INT NOT NULL,
  `Model_ID` INT NOT NULL,
  PRIMARY KEY (`CommercialUse_carriage_ID`),
  FOREIGN KEY (CarriageID) REFERENCES `train2`.`Carriage`(`CarriageID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Saemaeul` (
  `Saemaeul_ID` INT NOT NULL,
  `TrainID` INT NOT NULL,
  PRIMARY KEY (`Saemaeul_ID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Mugunghwa` (
  `Mugunghwa_ID` INT NOT NULL,
  `TrainID` INT NOT NULL,
  PRIMARY KEY (`Mugunghwa_ID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Ktx` (
  `Ktx_ID` INT NOT NULL,
  `TrainID` INT NOT NULL,
  PRIMARY KEY (`Ktx_ID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`ITX` (
  `ITX_ID` INT NOT NULL,
  `TrainID` INT NOT NULL,
  PRIMARY KEY (`ITX_ID`),
  FOREIGN KEY (TrainID) REFERENCES `train2`.`Train`(`TrainID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
/*

-- 요금 테이블 --
    요금ID (Fare_ID INT PRIMARY KEY)
    서비스타입ID (Service_Type_ID INT)
    화물ID (Cargo_ID INT)
    승객타입ID (Passenger_Type_ID INT)
    Amount DECIMAL(10, 2)
    FOREIGN KEY (Service_Type_ID) REFERENCES Service_Type (Service_Type_ID)
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo (Cargo_ID)
    FOREIGN KEY (Passenger_Type_ID) REFERENCES Passenger_Type (Passenger_Type_ID)

-- 할인 테이블 --
    할인ID (Promotion_ID INT PRIMARY KEY)
    요금ID (Fare_ID INT)
    Discount DECIMAL(5, 2),
    FOREIGN KEY (Fare_ID) REFERENCES Fare (Fare_ID)


-- 서비스 타입 테이블 --
    서비스타입ID (Service_Type_ID INT PRIMARY KEY)
    서비스 이름 (Service_Name VARCHAR(50))

-- 부가서비스 테이블 --
    부가서비스ID (Additional_Service_ID INT PRIMARY KEY)
    서비스타입ID (Service_Type_ID INT)
    서비스이름 (Service_Name VARCHAR(50))
    FOREIGN KEY (Service_Type_ID) REFERENCES Service_Type (Service_Type_ID)


-- 기내식 테이블 --
    기내식ID (In_flight_Meal_ID INT PRIMARY KEY)
    서비스타입ID (Service_Type_ID INT)
    음식타입 (Meal_Type VARCHAR(50))
    FOREIGN KEY (Service_Type_ID) REFERENCES Service_Type (Service_Type_ID)

-- 화물 테이블 --
    화물ID (Cargo_ID INT PRIMARY KEY)
    화물타입 (Cargo_Type VARCHAR(50))

-- 화물칸 테이블 --
    화물칸ID (Cargo_Cabin_ID INT PRIMARY KEY)
    화물ID (Cargo_ID INT)
    칸타입 (Cabin_Type VARCHAR(50))
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo (Cargo_ID)

-- 컨테이너 테이블 --
    컨테이너ID (Container_ID INT PRIMARY KEY)
    화물ID (Cargo_ID INT)
    컨테이너타입 (Container_Type VARCHAR(50))
    FOREIGN KEY (Cargo_ID) REFERENCES Cargo (Cargo_ID)

-- 승객 타입 테이블 --
    승객타입ID (Passenger_Type_ID INT PRIMARY KEY)
    승객타입이름 (Passenger_Type_Name VARCHAR(50))
 */



CREATE TABLE IF NOT EXISTS `train2`.`Fare` (
  `Fare_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  PRIMARY KEY (`Fare_ID`)
);

CREATE TABLE IF NOT EXISTS `train2`.`Passenger_Fare` (
  `Fare_ID` INT NOT NULL,
  `Fare_detail_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  PRIMARY KEY (`Fare_ID`),
  FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Fare`(Fare_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Cargo_Fare` (
  `Fare_ID` INT NOT NULL,
  `Cargo_detail_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  PRIMARY KEY (`Fare_ID`),
  FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Fare` (Fare_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Service_Fare` (
  `Fare_ID` INT NOT NULL,
  `Service_Detail_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  PRIMARY KEY (`Fare_ID`),
  FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Fare` (Fare_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Normal_Fare` (
  `Fare_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  `Condition` INT NOT NULL,
  `Service_Name` VARCHAR(50),
  PRIMARY KEY (`Fare_ID`),
  FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Passenger_Fare` (Fare_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Special_Fare` (
  `Fare_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  `Condition` INT NOT NULL,
  `Service_Name` VARCHAR(50),
  PRIMARY KEY (`Fare_ID`),
  FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Passenger_Fare` (Fare_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Season_Fare` (
  `Fare_ID` INT NOT NULL,
  `Amount` DECIMAL(10, 2),
  `Condition` INT NOT NULL,
  `Service_Name` VARCHAR(50),
  PRIMARY KEY (`Fare_ID`),
  FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Passenger_Fare` (Fare_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`cargo_compartment_fare`
(
    `Fare_ID`   INT NOT NULL,
    `Amount`    DECIMAL(10, 2),
    `Condition` INT NOT NULL,
    `Service_Name` VARCHAR(50),
    PRIMARY KEY (`Fare_ID`),
    FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Cargo_Fare` (Fare_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`container_fare`
(
    `Fare_ID`   INT NOT NULL,
    `Amount`    DECIMAL(10, 2),
    `Condition` INT NOT NULL,
    `Service_Name` VARCHAR(50),
    PRIMARY KEY (`Fare_ID`),
    FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Cargo_Fare` (Fare_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`In_flight_Meal_ID`
(
    `Fare_ID`   INT NOT NULL,
    `Amount`    DECIMAL(10, 2),
    `Condition` INT NOT NULL,
    `Service_Name` VARCHAR(50),
    PRIMARY KEY (`Fare_ID`),
    FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Service_Fare` (Fare_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`Additional_Service_ID`
(
    `Fare_ID`   INT NOT NULL,
    `Amount`    DECIMAL(10, 2),
    `Condition` INT NOT NULL,
    `Service_Name` VARCHAR(50),
    PRIMARY KEY (`Fare_ID`),
    FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Service_Fare` (Fare_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`user`
(
    `user_id`   INT NOT NULL,
    `name`    VARCHAR(20),
    PRIMARY KEY (`user_id`)
);

CREATE TABLE IF NOT EXISTS `train2`.`user_id`
(
    `user_id`   INT NOT NULL,
    `user_id_word`    VARCHAR(20),
    PRIMARY KEY (`user_id`),
    FOREIGN KEY (user_id) REFERENCES `train2`.`user` (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`user_password`
(
    `user_id`   INT NOT NULL,
    `user_password`    VARCHAR(20),
    PRIMARY KEY (`user_id`),
    FOREIGN KEY (user_id) REFERENCES `train2`.`user` (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`individual_user`
(
    `user_id`   INT NOT NULL,
    `user_name`    VARCHAR(20),
    `user_age`   INT NOT NULL,
    PRIMARY KEY (`user_id`),
    FOREIGN KEY (user_id) REFERENCES `train2`.`user` (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`company_user`
(
    `user_id`   INT NOT NULL,
    `user_name`    VARCHAR(20),
    `company_num` INT NOT NULL,
    PRIMARY KEY (`user_id`),
    FOREIGN KEY (user_id) REFERENCES `train2`.`user` (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `train2`.`payment`
(
    `payment_id`   INT NOT NULL,
    `Fare_ID`    INT NOT NULL,
    `seatID` INT NOT NULL,
    `user_id` INT NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (Fare_ID) REFERENCES `train2`.`Fare` (Fare_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Fare_ID) REFERENCES `train2`.`seat` (seatID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES `train2`.`user` (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`ticket_payment`
(
    `payment_id`   INT NOT NULL,
    `type`    VARCHAR(20),
    `amount`   INT NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (payment_id) REFERENCES `train2`.`payment` (payment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`service_payment`
(
    `payment_id`   INT NOT NULL,
    `type`    VARCHAR(20),
    `amount`   INT NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (payment_id) REFERENCES `train2`.`payment` (payment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`cargo_payment`
(
    `payment_id`   INT NOT NULL,
    `type`    VARCHAR(20),
    `amount`   INT NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (payment_id) REFERENCES `train2`.`payment` (payment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `train2`.`refund`
(
    `payment_id`   INT NOT NULL,
    `type`    VARCHAR(20),
    `amount`   INT NOT NULL,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (payment_id) REFERENCES `train2`.`payment` (payment_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
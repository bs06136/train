USE train;

DELIMITER //
CREATE PROCEDURE InsertStation(IN StationName VARCHAR(255), IN Location VARCHAR(255), IN PlatformCount INT)
BEGIN
    INSERT INTO Station(StationName, Location, PlatformCount) VALUES (StationName, Location, PlatformCount);
END //
DELIMITER ;

-- DetailedRoute 테이블에 새로운 레코드가 삽입될 때마다 Connected_Route 테이블에 대응하는 레코드가 자동으로 삽입
DELIMITER //
CREATE TRIGGER AfterInsertDetailedRoute
AFTER INSERT ON DetailedRoute
FOR EACH ROW
BEGIN
    DECLARE StartStation INT;
    DECLARE EndStation INT;

    SELECT StartID, EndID INTO StartStation, EndStation FROM DetailedRoute WHERE DetailedRouteID = NEW.DetailedRouteID;

    INSERT INTO Connected_Route(RouteID, num, DetailedRouteID)
    VALUES (NEW.DetailedRouteID, 1, NEW.DetailedRouteID),
           (NEW.DetailedRouteID, 2, StartStation),
           (NEW.DetailedRouteID, 3, EndStation);
END //
DELIMITER ;

-- Promotion 및 Fare에 데이터를 삽입할 때 자동으로 할인 및 요금 정보를 적용
DELIMITER //
CREATE PROCEDURE ApplyPromotionAndFare(IN promoID INT, IN fareID INT)
BEGIN
    DECLARE discountValue INT;
    DECLARE fareValue INT;

    -- Promotion 테이블에서 할인율 조회
    SELECT discount INTO discountValue FROM Promotion WHERE PromotionID = promoID;

    -- Fare 테이블에서 기본 요금 조회
    SELECT Fare INTO fareValue FROM Fare WHERE FareID = fareID;

    -- 할인된 요금을 Fare 테이블에 업데이트
    UPDATE Fare SET Fare = fareValue - (fareValue * discountValue / 100) WHERE FareID = fareID;
END //
DELIMITER ;

-- 트리거 생성
DELIMITER //
CREATE TRIGGER AfterInsertPromotionAndFare
AFTER INSERT ON Promotion
FOR EACH ROW
BEGIN
    DECLARE fareID INT;

    -- Fare 테이블에 새로운 일반 요금 추가
    INSERT INTO Fare (Fare) VALUES (10000);

    -- 방금 추가된 Fare의 FareID 가져오기
    SELECT MAX(FareID) INTO fareID FROM Fare;

    -- 새로 추가된 Promotion과 Fare 정보를 프로시저를 통해 업데이트
    CALL ApplyPromotionAndFare(NEW.PromotionID, fareID);
END //
DELIMITER ;

-- 새로운 화물 데이터가 삽입될 때 자동으로 프로시저와 트리거를 사용하여 결제 정보를 추가
DELIMITER //
CREATE PROCEDURE CreateCargoPayment(IN cargoID INT, IN routeID INT, IN fareID INT, IN paymentAmount DECIMAL(10, 2), IN paymentDate DATE)
BEGIN
    -- 화물 결제 정보를 CargoPayment 테이블에 추가
    INSERT INTO CargoPayment (CargoID, RouteID, FareID, PaymentAmount, PaymentDate)
    VALUES (cargoID, routeID, fareID, paymentAmount, paymentDate);

    -- 화물 결제 정보를 Payment 테이블에 추가
    INSERT INTO Payment (RouteID, FareID)
    VALUES (routeID, fareID);
END //
DELIMITER ;

-- 트리거 생성
DELIMITER //
CREATE TRIGGER AfterInsertCargo
AFTER INSERT ON Cargo
FOR EACH ROW
BEGIN
    DECLARE routeID INT;
    DECLARE fareID INT;

    -- Cargo, Route 및 Fare 테이블에 새로운 데이터 추가
    SET routeID = 1; -- 적절한 노선 ID로 설정
    SET fareID = 1;  -- 적절한 요금 ID로 설정

    -- 새로 추가된 Cargo 및 관련 정보를 프로시저를 통해 결제 정보로 추가
    CALL CreateCargoPayment(NEW.CargoID, routeID, fareID, NEW.CargoWeight * NEW.CargoType, CURRENT_DATE);
END //
DELIMITER ;

-- 화물 예약 및 처리 함수
DELIMITER //
CREATE FUNCTION ReserveAndProcessCargoBulk(cargoDataList TEXT)
RETURNS INT
NO SQL
BEGIN
    DECLARE cargoID INT;
    DECLARE routeID INT;
    DECLARE fareID INT;
    DECLARE paymentAmount DECIMAL(10, 2);

    -- 임시 테이블 생성
    CREATE TEMPORARY TABLE IF NOT EXISTS TempCargoData (
        CargoType INT,
        CargoWeight INT
    );

    -- 화물 정보 삽입
    INSERT INTO Cargo (CargoType, CargoWeight)
    SELECT CargoType, CargoWeight FROM TempCargoData;

    -- 새로 추가된 화물 정보의 ID 가져오기
    SELECT LAST_INSERT_ID() INTO cargoID;

    -- 화물 운송 노선 정보 삽입 (가정: 노선은 고정 값)
    INSERT INTO Route (StartID, EndID) VALUES (1, 2);

    -- 새로 추가된 노선 정보의 ID 가져오기
    SELECT LAST_INSERT_ID() INTO routeID;

    -- 화물 요금 정보 삽입 (가정: 요금은 고정 값)
    INSERT INTO Fare (Fare) VALUES (100);

    -- 새로 추가된 요금 정보의 ID 가져오기
    SELECT LAST_INSERT_ID() INTO fareID;

    -- 화물 운송 비용 계산
    SET paymentAmount = (SELECT SUM(CargoWeight * CargoType) FROM TempCargoData);

    -- 화물 결제 정보를 CargoPayment 테이블에 추가
    INSERT INTO CargoPayment (CargoID, RouteID, FareID, PaymentAmount, PaymentDate)
    VALUES (cargoID, routeID, fareID, paymentAmount, CURRENT_DATE);

    -- 화물 결제 정보를 Payment 테이블에 추가
    INSERT INTO Payment (RouteID, FareID)
    VALUES (routeID, fareID);

    -- 임시 테이블 삭제
    DROP TEMPORARY TABLE IF EXISTS TempCargoData;

    -- 예약한 화물 정보의 ID 반환
    RETURN cargoID;
END //
DELIMITER ;



-- 새로운 물품 분실 정보 삽입 시 처리
DELIMITER //
CREATE PROCEDURE HandleLostItem(IN ownerName VARCHAR(255), IN itemInfo TEXT, IN dateInfo DATE, IN foundLocation INT, IN processingStatus VARCHAR(50))
BEGIN
    -- 물품 분실 정보 삽입
    INSERT INTO LostItems (OwnerName, ItemInfo, DateInfo, FoundLocation, ProcessingStatus)
    VALUES (ownerName, itemInfo, dateInfo, foundLocation, processingStatus);
END //
DELIMITER ;

--  새로운 사고 정보 삽입 시 처리
DELIMITER //
CREATE PROCEDURE HandleAccident(IN stationID INT, IN accidentTime DATETIME, IN weather VARCHAR(255),
    IN accidentType VARCHAR(255), IN injuredCount INT, IN actionTaken TEXT)
    -- 사고 정보 삽입
BEGIN
    INSERT INTO AccidentInfo (StationID, AccidentTime, Weather, AccidentType, InjuredCount, ActionTaken)
    VALUES (stationID, accidentTime, weather, accidentType, injuredCount, actionTaken);
END //
DELIMITER ;

-- LostItems 테이블에 새로운 데이터가 삽입될 때 처리
DELIMITER //
CREATE TRIGGER AfterInsertLostItem
AFTER INSERT ON LostItems
FOR EACH ROW
BEGIN
    -- 새로 추가된 LostItems 데이터에 대한 처리 프로시저 호출
    CALL HandleLostItem(NEW.OwnerName, NEW.ItemInfo, NEW.DateInfo, NEW.FoundLocation, NEW.ProcessingStatus);
END //
DELIMITER ;

-- AccidentInfo 테이블에 새로운 데이터가 삽입될 때 처리
DELIMITER //
CREATE TRIGGER AfterInsertAccident
AFTER INSERT ON AccidentInfo
FOR EACH ROW
BEGIN
    -- 새로 추가된 AccidentInfo 데이터에 대한 처리 프로시저 호출
    CALL HandleAccident(NEW.StationID, NEW.AccidentTime, NEW.Weather, NEW.AccidentType, NEW.InjuredCount, NEW.ActionTaken);
END //
DELIMITER ;

-- 환불 정보를 기록하는 프로시저
DELIMITER //
CREATE FUNCTION RecordRefund(paymentID INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    -- 환불 정보를 Refund 테이블에 추가
    INSERT INTO Refund (PaymentID) VALUES (paymentID);
    RETURN TRUE;
END //
DELIMITER ;

-- 결제 정보를 업데이트하여 환불 여부를 나타내는 프로시저
DELIMITER //
CREATE PROCEDURE UpdatePaymentForRefund(IN paymentID INT)
BEGIN
    -- 결제 정보를 업데이트하여 환불 여부를 나타냄
    UPDATE Payment SET Refunded = TRUE WHERE PaymentID = paymentID;
END //
DELIMITER ;

-- 환불 처리 함수
DELIMITER //
CREATE FUNCTION ProcessRefund(paymentID INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    -- 결제 정보 업데이트
    CALL UpdatePaymentForRefund(paymentID);

    -- 환불 정보 기록
    CALL RecordRefund(paymentID);

    -- 성공적으로 환불 처리되었음을 반환
    RETURN TRUE;
END //
DELIMITER ;
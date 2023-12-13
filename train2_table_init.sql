-- 역 테이블 데이터 삽입
INSERT INTO Station (Station_Name, Location)
VALUES ('서울역','서울 용산구 한강대로 405'),
      ('광명역','경기 광명시 광명역로 21'),
       ('대전역','대전 동구 중앙로 215'),
       ('대구역','대구 북구 태평로 161'),
       ('울산역','울산 울주군 삼남읍 울산역로 177'),
       ('부산역','부산 동구 중앙대로 206'),
       ('전주역','전북 전주시 덕진구 동부대로 680'),
       ('강릉역','강원 강릉시 용지로 176'),
       ('신경주역','경북 경주시 건천읍 경주역로 80'),
       ('광주역','광주 북구 무등로 235'),
('정동진역','강원 정동진');

-- 시간표 테이블 데이터 삽입
INSERT INTO Timetable (Departure_Time, Arrival_Time) VALUES
('09:00:00', '11:00:00',1),
('10:30:00', '13:00:00',2),
('13:45:00', '16:30:00',3),
('15:20:00', '18:10:00',4),
('17:40:00', '20:15:00',5),
('19:15:00', '22:00:00',6),
('21:00:00', '23:30:00',7),
('23:10:00', '02:00:00',8),
('02:30:00', '05:15:00',9),
('04:45:00', '07:30:00',10);

-- 경로 테이블 데이터 삽입
INSERT INTO Path (Start_Station_ID, End_Station_ID, Timetable_ID) VALUES
(1, 5, 1),
(2, 8, 2),
(3, 7, 3),
(4, 10, 4),
(5, 9, 5),
(6, 4, 6),
(7, 3, 7),
(8, 2, 8),
(9, 1, 9),
(10, 6, 10);

-- 실제운행 테이블 데이터 삽입
INSERT INTO Actual_Run (Run_Date, Actual_Departure_Time, Actual_Arrival_Time, Station_ID) VALUES
('2023-12-01', '09:05:00', '11:10:00', 1),
('2023-12-01', '10:35:00', '13:05:00', 2),
('2023-12-01', '13:50:00', '16:35:00', 3),
('2023-12-01', '15:25:00', '18:15:00', 4),
('2023-12-01', '17:45:00', '20:20:00', 5),
('2023-12-01', '19:20:00', '22:05:00', 6),
('2023-12-01', '21:05:00', '23:35:00', 7),
('2023-12-01', '23:15:00', '02:05:00', 8),
('2023-12-01', '02:35:00', '05:20:00', 9),
('2023-12-01', '04:50:00', '07:35:00', 10);

-- 연결경로 테이블 데이터 삽입
INSERT INTO Connected_Path (Path_ID, Number, Inter_Station_ID) VALUES
(1, 1, 2),
(1, 2, 3),
(1, 3, 4),
(2, 4, 5),
(2, 5, 6),
(2, 6, 7),
(3, 7, 8),
(3, 8, 9),
(3, 9, 10),
(4, 10, 11);

-- 상세경로 테이블 데이터 삽입
INSERT INTO Detailed_Path (Path_ID, Departure_Station_ID, Arrival_Station_ID, Interval) VALUES
(1, 1, 5, '00:30:00'),
(2, 2, 8, '00:30:00'),
(3, 3, 7, '00:30:00'),
(4, 4, 10, '00:30:00'),
(5, 5, 9, '00:30:00'),
(6, 6, 4, '00:30:00'),
(7, 7, 3, '00:30:00'),
(8, 8, 2, '00:30:00'),
(9, 9, 1, '00:30:00'),
(10, 10, 6, '00:30:00');

-- 노선 테이블 데이터 삽입
INSERT INTO Route (Route_Name, Start_Station_ID, End_Station_ID) VALUES
('노선1', 1, 5),
('노선2', 2, 8),
('노선3', 3, 7),
('노선4', 4, 10),
('노선5', 5, 9),
('노선6', 6, 4),
('노선7', 7, 3),
('노선8', 8, 2),
('노선9', 9, 1),
('노선10', 10, 6);



-- 서비스 타입 데이터 삽입
INSERT INTO Service_Type (Service_Type_ID, Service_Name) VALUES
(1, '서비스1'),
(2, '서비스2'),
(3, '서비스3');

-- 화물 데이터 삽입
INSERT INTO Cargo (Cargo_ID, Cargo_Type) VALUES
(1, '화물1'),
(2, '화물2'),
(3, '화물3');

-- 승객 타입 데이터 삽입
INSERT INTO Passenger_Type (Passenger_Type_ID, Passenger_Type_Name) VALUES
(1, '일반요금'),
(2, '특수요금'),
(3, '정기권');

-- 요금 데이터 삽입
INSERT INTO Fare (Fare_ID, Service_Type_ID, Cargo_ID, Passenger_Type_ID, Amount) VALUES
(1, 1, 2, 1, 100.00),
(2, 2, 1, 3, 75.50),
(3, 3, 3, 2, 120.75);

-- 할인 데이터 삽입
INSERT INTO Promotion (Promotion_ID, Fare_ID, Discount) VALUES
(1, 1, 0.10),
(2, 2, 0.15),
(3, 3, 0.05);

-- 부가서비스 데이터 삽입
INSERT INTO Additional_Service (Additional_Service_ID, Service_Type_ID, Service_Name) VALUES
(1, 1, '부가서비스1'),
(2, 2, '부가서비스2'),
(3, 3, '부가서비스3');

-- 기내식 데이터 삽입
INSERT INTO In_flight_Meal (In_flight_Meal_ID, Service_Type_ID, Meal_Type) VALUES
(1, 1, '기내식1'),
(2, 2, '기내식2'),
(3, 3, '기내식3');

-- 화물칸 데이터 삽입
INSERT INTO Cargo_Cabin (Cargo_Cabin_ID, Cargo_ID, Cabin_Type) VALUES
(1, 1, '칸1'),
(2, 2, '칸2'),
(3, 3, '칸3');

-- 컨테이너 데이터 삽입
INSERT INTO Container (Container_ID, Cargo_ID, Container_Type) VALUES
(1, 1, '컨테이너1'),
(2, 2, '컨테이너2'),
(3, 3, '컨테이너3');
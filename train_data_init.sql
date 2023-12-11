
INSERT INTO Station(StationName, Location, PlatformCount)
VALUES ('서울역','서울 용산구 한강대로 405',10),
      ('광명역','경기 광명시 광명역로 21',10),
       ('대전역','대전 동구 중앙로 215', 10),
       ('대구역','대구 북구 태평로 161',4),
       ('울산역','울산 울주군 삼남읍 울산역로 177',2),
       ('부산역','부산 동구 중앙대로 206',10),
       ('전주역','전북 전주시 덕진구 동부대로 680',4),
       ('강릉역','강원 강릉시 용지로 176',2),
       ('신경주역','경북 경주시 건천읍 경주역로 80',4),
       ('광주역','광주 북구 무등로 235',8);

INSERT INTO Passenger (PassengerID) VALUES
(1),
(2),
(3),
(4),
(5);


INSERT INTO Train (TrainID, Num) VALUES
(1, 101),
(2, 102),
(3, 103),
(4, 104),
(5, 105);

-- 역차 정보 추가
INSERT INTO Train_compartment (TrainID, Num, compartment_type_id, seat_num) VALUES
(1, 1, 1, 50),
(2, 1, 1, 30),
(3, 1, 1, 20),
(4, 1, 1, 40),
(5, 1, 1, 25);

INSERT INTO DetailedRoute (StartID, EndID)
VALUES
(1, 2), -- 서울역 -> 광명역
(1, 8), -- 서울역 -> 강릉역
(1, 9), -- 서울역 -> 신경주역
(2, 1), -- 광명역 -> 서울역
(2, 3), -- 광명역 -> 대전역
(3, 2), -- 대전역 -> 광명역
(3, 9), -- 대전역 -> 신경주역
(3, 7), -- 대전역 -> 전주역
(7, 3), -- 전주역 -> 대전역
(7, 10), -- 전주역 -> 광주역
(10, 7), -- 광주역 -> 전주역
(10, 6), -- 광주역 -> 부산역
(6, 10), -- 부산역 -> 광주역
(6, 9), -- 부산역 -> 신경주역
(9, 1), -- 신경주역 -> 서울역
(9, 3), -- 신경주역 -> 대전역
(9, 8), -- 신경주역 -> 강릉역
(9, 6), -- 신경주역 -> 부산역
(8, 1), -- 강릉역 -> 서울역
(8, 9), -- 강릉역 -> 신경주역
(4, 3), -- 대구역 -> 대전역
(4, 9), -- 대구역 -> 신경주역
(3, 4), -- 대전역 -> 대구역
(9, 4), -- 신경주역 -> 대구역
(5, 9), -- 울산역 -> 신경주역
(5, 6), -- 울산역 -> 부산역
(9, 5), -- 신경주역 -> 울산역
(6, 5); -- 부산역 -> 울산역


INSERT INTO Timetable (TrainID, departure_time, arrival_time, operating_day,DetailedRouteID)
VALUES
-- Train 1 1 - 10
	(1, '08:00:00', '10:30:00', '2023-01-01', 3),
	(1, '14:00:00', '16:30:00', '2023-01-01', 18),
	(1, '09:00:00', '11:30:00', '2023-01-02', 13),
	-- Train 2 1 - 7
	(2, '09:30:00', '12:00:00', '2023-01-01', 1),
	(2, '16:30:00', '19:00:00', '2023-01-01', 5),
	(2, '10:30:00', '13:00:00', '2023-01-02', 8),
	-- Train 3 2 - 5
	(3, '10:00:00', '12:30:00', '2023-01-01', 4),
	(3, '17:00:00', '19:30:00', '2023-01-01', 3),
	(3, '11:00:00', '13:30:00', '2023-01-02', 27),
	-- Train 4 2 - 6
	(4, '10:30:00', '13:00:00', '2023-01-01', 4),
	(4, '17:30:00', '20:00:00', '2023-01-01', 3),
	(4, '11:30:00', '14:00:00', '2023-01-02', 18),
	-- Train 5 2 - 10
	(5, '11:00:00', '13:30:00', '2023-01-01', 5),
	(5, '18:00:00', '20:30:00', '2023-01-01', 8),
	(5, '12:00:00', '14:30:00', '2023-01-02', 10);

INSERT INTO Seat (TrainID, CarriageNum, SeatInformation, TimeID) VALUES
(1, 1, 0, 1),
(1, 1, 0, 2),
(1, 1, 0, 3),
(2, 1, 0, 4),
(2, 1, 0, 5),
(2, 1, 0, 6);

INSERT INTO Promotion (PromotionID, discount)
VALUES
(1, 10),  -- 10% 할인
(2, 15),  -- 15% 할인
(3, 5),   -- 5% 할인
(4, 20),  -- 20% 할인
(5, 25),  -- 25% 할인
(6, 30),  -- 30% 할인
(7, 35),  -- 35% 할인
(8, 40),  -- 40% 할인
(9, 45),  -- 45% 할인
(10, 50); -- 50% 할인

INSERT INTO Fare (FareID, Fare)
VALUES
(1, 10000),  -- 일반 요금
(2, 12000),  -- 일반 요금
(3, 9000),   -- 일반 요금
(4, 15000),  -- 일반 요금
(5, 8000),   -- 일반 요금
(6, 11000),  -- 일반 요금
(7, 20000),  -- 화물 요금
(8, 25000),  -- 화물 요금
(9, 30000),  -- 화물 요금
(10, 35000); -- 화물 요금

INSERT INTO CargoCustomer (CustomerID) VALUES
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL),
(NULL);

INSERT INTO Cargo (CargoType, CargoWeight) VALUES
(1, 500),   -- 타입 1, 무게 500
(2, 750),   -- 타입 2, 무게 750
(3, 300),   -- 타입 3, 무게 300
(4, 900),   -- 타입 4, 무게 900
(1, 450),   -- 타입 1, 무게 450
(2, 600),   -- 타입 2, 무게 600
(3, 350),   -- 타입 3, 무게 350
(4, 800),   -- 타입 4, 무게 800
(1, 550),   -- 타입 1, 무게 550
(2, 700);   -- 타입 2, 무게 700


INSERT INTO lostitems(OwnerName, ItemInfo, DateInfo, FoundLocation/*stationID*/, ProcessingStatus)
VALUE ('김민수', '검은색 삼성 갤럭시 S21휴대폰','2023-11-08',1,'폐기'),
     ('이지은', '갈색 루이비통 가죽 지갑','2023-11-18',3,'회수'),
      (NULL, '하트모양 키링이 달린 열쇠','2023-11-19',4,'보관'),
      ('최유진', '파란색 아디다스 백팩','2023-11-21',6,'보관'),
      ('장하은', '분홍색 가죽 카드지갑','2023-11-30',2,'보관'),
      ('강지후', '에어팟프로','2023-11-30',1,'회수'),
      (NULL, '노란색 단우산','2023-12-01',10,'보관'),
      (NULL, '투명한 플라스틱 물병','2023-12-03',9,'보관'),
      ('황수민', '초록색 국민은행 카드','2023-12-05',1,'폐기'),
      ('조은지', '애플펜슬','2023-12-08',7,'회수');

INSERT INTO AccidentInfo(StationID, AccidentTime, Weather, AccidentType, InjuredCount, ActionTaken)
VALUE (2, '2023-11-10 08:00:00','비','지연',0,'정상운행'),
     (5, '2023-11-15 08:30:00','비','지연',0,'지연운행'),
      (6, '2023-11-20 12:45:00','강풍','탈선',0,'운행중지'),
      (1, '2023-11-25 18:20:00','맑음','신호고장',0,'재정비'),
      (3, '2023-11-30 22:10:00','흐림','지연',0,'정상운행'),
      (2, '2023-12-05 04:30:00','비','지연',0,'지연운행'),
      (8, '2023-12-08 14:15:00','눈','지연',0,'지연운행'),
      (10, '2023-12-10 10:00:00','맑음','신호고장',0,'재정비'),
      (9, '2023-12-11 20:45:00','흐림','지연',0,'정상운행'),
      (7, '2023-12-12 09:00:00','강풍','지연',0,'지연운행');


INSERT INTO employee(WorkScheduleID,EmployeeName,Salary,Position,ContactNumber,HireDate,EmployeeInfo)
VALUE (1,'이한솔',4000,'승무원','010-0000-0000','2020-12-01','1995년 출생. 숙명여대 경제학과 졸업'),
     (2,'노영권',4000,'승무원','010-1111-1111','2021-01-01','1999년 출생. 가천대 컴퓨터공학과 졸업'),
      (3,'박연하',4000,'기관사','010-2222-2222','2018-07-01','1991년 출생. 국민대 기계공학과 졸업'),
      (4,'송민정',4000,'승무원','010-3333-3333','2021-02-01','1998년 출생. 가천대 일어일문학과 졸업'),
      (5,'이신영',5000,'기관사','010-4444-4444','2023-03-01','1995년 출생. 성신여대 경제학과 졸업'),
      (6,'이다영',3000,'미화원','010-5555-5555','2022-11-01','2001년 출생. 숭실대 무역학과 졸업'),
      (7,'조주원',4000,'승무원','010-6666-6666','2022-11-01','2002년 출생. 중앙대 소프트웨어학과 졸업'),
      (8,'이종현',5000,'미화원','010-7777-7777','2008-11-01','1979년 출생. 세종대 경영학과 졸업'),
      (9,'이성민',5000,'승무원','010-8888-8888','2012-06-01','1986년 출생. 경희대 경영학과 졸업'),
      (10,'한누리',6000,'기관사','010-9999-9999','2013-12-01','1986년 출생. 서경대 물리학과 졸업');

 INSERT INTO attendancerecord(EmployeeID, AttendanceDateTime,AttendanceStatus,AttendanceLocation)
 VALUE (1,'2023-12-01 09:32:15','정상','서울역'),
      (2,'2023-12-02 15:21:40','지각','광주역'),
       (3,'2023-12-03 07:48:03','정상','서울역'),
       (4,'2023-12-04 12:05:28','정상','울산역'),
       (5,'2023-12-05 16:37:51','정상','서울역'),
       (6,'2023-12-06 06:59:12','정상','부산역'),
       (7,'2023-12-07 13:43:09','정상','전주역'),
       (8,'2023-12-08 10:18:37','정상','전주역'),
       (9,'2023-12-09 17:12:45','정상','강릉역'),
       (10,'2023-12-10 08:27:19','정상','대전역');

 INSERT INTO customerconsultationrecord(EmployeeID,CustomerName,ConsultationDate,ConsultationType,ConsultationContent,ProcessingStatus)
 VALUE (1,'김현수','2023-11-02','열차운행','열차가 10분이나 지연됐습니다. 다음부턴 피해보지 않게 주의해주세요.','처리완료'),
      (1,'김현수','2023-11-10','열차서비스','화장실이 청결하지 않았습니다. 신경써주세요','처리완료'),
       (2,'김주영','2023-11-11','분실물','에어팟을 잃어버렸는데 습득하시면 연락 부탁드립니다.','처리완료'),
       (1,'김현수','2023-11-16','열차서비스','객차 내에서 불쾌한 냄새가 납니다. 신경써주세요','처리완료'),
       (7,'장해영','2023-11-17','결제','카카오페이 결제 시 오류가 나는데 왜 그런건가요?','처리완료'),
       (4,'박정은','2023-11-20','열차운행','열차가 1시간 지연되어 보상 부탁드립니다.','처리완료'),
       (2,'강수흔','2023-11-23','열차운행','서울-전주행 평일 14시 기차는 이제 더이상 운행 안 하는건가요?','처리완료'),
       (7,'김현수','2023-11-25','열차서비스','객차 내에서 시끄럽게 통화하는 승객들 관리해주세요.','처리완료'),
       (9,'김현수','2023-12-10','열차운행','10시 기차이고, 10시 40초쯤에 도착했는데 열차가 떠나네요? 10시 1분도 안됐는데 이러면 안 되는 거 아닌가요?','처리중'),
       (9,'최종환','2023-12-11','분실물','모자를 분실했습니다. 습듯 시 연락 부탁드립니다.','진행중');

 INSERT INTO ConvenienceFacility(StationID,toilet,convenienceStore,restaurant,cafe,giftshop,ticketStore,ParkingArea,ATM)
VALUE (1,4,5,12,10,3,2,2,3),
     (2,4,2,5,5,1,1,1,2),
      (3,3,3,10,8,3,2,1,2),
      (4,2,2,6,2,1,1,1,1),
      (5,1,2,1,3,1,1,1,1),
      (6,4,4,10,10,4,2,2,4),
      (7,1,2,8,6,2,1,1,2),
      (8,1,1,0,1,1,1,1,1),
      (9,2,2,4,5,2,1,1,1),
      (10,2,3,5,6,1,1,1,2);
import mysql.connector
import itertools
import heapq
from datetime import datetime


# MySQL 연결 설정
db_connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="gloria823!",
    database="train"
)

def create_graph(db_cursor):
    graph = {}
    db_cursor.execute("SELECT StartID, EndID FROM DetailedRoute")
    for start_id, end_id in db_cursor:
        graph.setdefault(start_id, []).append(end_id)
        graph.setdefault(end_id, []).append(start_id)
    return graph

def find_shortest_path(graph, start, end):
    queue = [(0, start, [])]
    visited = set()
    while queue:
        (cost, node, path) = heapq.heappop(queue)
        if node not in visited:
            visited.add(node)
            path = path + [node]

            if node == end:
                return path

            for next_node in graph.get(node, []):
                if next_node not in visited:
                    heapq.heappush(queue, (cost + 1, next_node, path))
    return []

def create_routes_and_connections(db_connection):
    try:
        db_cursor = db_connection.cursor(buffered=True)

        # 그래프 생성
        graph = create_graph(db_cursor)

        # 모든 역의 ID 가져오기
        db_cursor.execute("SELECT StationID FROM Station ORDER BY StationID")
        all_stations = [station[0] for station in db_cursor]

        # 모든 가능한 Route 및 Connected_Route 생성
        for start_id, end_id in itertools.permutations(all_stations, 2):
            shortest_path = find_shortest_path(graph, start_id, end_id)
            if shortest_path:
                route_id = int(f"{start_id:02d}{end_id:02d}")

                # Route 테이블에 경로 추가
                insert_route_query = "INSERT IGNORE INTO Route (RouteID, StartID, EndID) VALUES (%s, %s, %s)"
                db_cursor.execute(insert_route_query, (route_id, start_id, end_id))

                # Connected_Route에 상세 경로 추가
                for num, node in enumerate(shortest_path[:-1], start=1):
                    detailed_route_id_query = """
                        SELECT DetailedRouteID FROM DetailedRoute
                        WHERE StartID = %s AND EndID = %s
                    """
                    db_cursor.execute(detailed_route_id_query, (node, shortest_path[num]))
                    result = db_cursor.fetchone()
                    if result:
                        detailed_route_id = result[0]

                        insert_connected_route_query = """
                            INSERT INTO Connected_Route (RouteID, num, DetailedRouteID)
                            VALUES (%s, %s, %s)
                        """
                        db_cursor.execute(insert_connected_route_query, (route_id, num, detailed_route_id))
                    else:
                        print(f"No detailed route found for StartID {node} and EndID {shortest_path[num]}")

        db_connection.commit()
        print("모든 최단 경로가 성공적으로 생성되었습니다.")

    except mysql.connector.Error as error:
        print(f"데이터 생성 중 오류 발생: {error}")
        db_connection.rollback()

    finally:
        if db_cursor:
            db_cursor.close()

create_routes_and_connections(db_connection)
db_cursor = db_connection.cursor()
def get_passenger_info():
    try:
        print("승객 정보 입력:")
        name = input("이름: ")

        # Passenger 테이블에 삽입
        insert_passenger_query = """
        INSERT INTO Passenger (Name) VALUES (%s)
        """
        db_cursor.execute(insert_passenger_query, (name,))
        db_connection.commit()

        print("승객 정보가 저장되었습니다.")
        return db_cursor.lastrowid   # 자동 증가하는 PassengerID 반환

    except Exception as e:
        db_connection.rollback()
        print(f"승객 정보 입력 중 오류 발생: {e}")
        return None

def get_route_info():
    try:
        print("\n경로 정보 입력:")
        start = input("출발역: ")
        end = input("도착역: ")

        # 사용 가능한 노선을 얻기 위한 쿼리
        get_routes_query = """
        SELECT RouteID
        FROM DetailedRoute
        WHERE Start = %s AND End = %s
        """
        db_cursor.execute(get_routes_query, (start, end))
        routes = db_cursor.fetchall()

        if not routes:
            print("사용 가능한 경로를 찾을 수 없음.")
            return None

        print("\n사용 가능한 경로:")
        for route in routes:
            print(route[0])

        route_id = int(input("경로 선택(RouteID 입력): "))
        return route_id

    except Exception as e:
        print(f"경로 정보 입력 중 오류 발생: {e}")
        return None

def get_train_info(route_id):
    try:
        print("\n이동 시간 정보 입력:")
        date_str = input("이동 날짜 (YYYY-MM-DD): ")
        travel_date = datetime.strptime(date_str, "%Y-%m-%d").date()

        # 선택한 경로 및 날짜에 대해 사용 가능한 열차를 가져오려는 쿼리
        get_trains_query = """
        SELECT train_id, departure_time, arrival_time
        FROM Timetable
        WHERE TimeID IN (
            SELECT TimeID
            FROM Seat
            WHERE TrainID IN (
                SELECT TrainID
                FROM DetailedRoute
                WHERE RouteID = %s
            )
        ) AND operating_day = %s
        """
        db_cursor.execute(get_trains_query, (route_id, travel_date))
        trains = db_cursor.fetchall()

        if not trains:
            print("이용 가능한 열차를 찾을 수 없습니다.")
            return None

        print("\n이용 가능한 열차:")
        for train in trains:
            print(f"TrainID: {train[0]}, Departure: {train[1]}, Arrival: {train[2]}")

        train_id = int(input("열차 선택(TrainID 입력): "))
        return train_id

    except Exception as e:
        print(f"열차 정보 입력 중 오류 발생: {e}")
        return None

def get_seat_info(train_id, travel_date):
    try:
        print("\n좌석 정보 입력:")

        # 선택한 열차 및 날짜에 사용 가능한 좌석을 확보하기 위한 쿼리
        get_seats_query = """
        SELECT CarriageNum, SeatNum
        FROM Seat
        WHERE TrainID = %s AND TimeID IN (
            SELECT TimeID
            FROM Timetable
            WHERE operating_day = %s
        ) 
        """
        db_cursor.execute(get_seats_query, (train_id, travel_date))
        seats = db_cursor.fetchall()

        if not seats:
            print("사용 가능한 좌석을 찾을 수 없습니다.")
            return None

        print("\n사용 가능한 좌석:")
        for seat in seats:
            print(f"CarriageNum: {seat[0]}, SeatNum: {seat[1]}")

        carriage_num = int(input("캐리지 선택(CarriageNum 입력): "))
        seat_num = int(input("좌석 선택(SeatNum 입력): "))
        return carriage_num, seat_num
    except Exception as e:
        print(f"좌석 정보 입력 중 오류 발생: {e}")
        return None, None


def get_service_info():
    try:
        print("\n서비스 정보 입력:")

        # 사용 가능한 서비스를 가져오려는 쿼리
        get_services_query = """
        SELECT ServiceID, Service_type, Service_cost
        FROM Service_Type
        """
        db_cursor.execute(get_services_query)
        services = db_cursor.fetchall()

        if not services:
            print("사용 가능한 서비스를 찾을 수 없습니다.")
            return None

        print("\n사용 가능한 서비스:")
        for service in services:
            print(f"ServiceID: {service[0]}, Type: {service[1]}, Cost: {service[2]}")

        service_id = int(input("서비스(ServiceID 입력)를 선택하거나 0을 입력하여 건너뜁니다: "))
        return service_id
    except Exception as e:
        print(f"서비스 정보 입력 중 오류 발생: {e}")
        return None

def get_feedback_info():
    try:
        print("\n피드백 정보 입력:")
        name = input("이름: ")
        feedback_contents = input("피드백 내용: ")
        date_str = input("날짜 (YYYY-MM-DD HH:mm:ss): ")
        feedback_date = datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S")

        # 피드백을 위해 이용 가능한 열차 받기
        get_trains_query = """
        SELECT TrainID
        FROM Train
        """
        db_cursor.execute(get_trains_query)
        trains = db_cursor.fetchall()

        if not trains:
            print("이용 가능한 열차를 찾을 수 없습니다.")
            return None

        print("\n피드백 가능한 열차:")
        for train in trains:
            print(train[0])

        train_id = int(input("열차 선택(TrainID 입력): "))

        # 피드백 테이블에 삽입
        insert_feedback_query = """
        INSERT INTO feedback (Feedback_ID, Name, Date, Feedback_contents, TrainID) VALUES (%s, %s, %s, %s, %s)
        """
        db_cursor.execute(insert_feedback_query, ("", name, feedback_date, feedback_contents, train_id))
        db_connection.commit()

        print("피드백 정보가 저장되었습니다.")
        return db_cursor.lastrowid

    except Exception as e:
        db_connection.rollback()
        print(f"피드백 정보 입력 중 오류 발생: {e}")
        return None

def get_fare_amount(fare_id):
    # 운임 정보 조회 (실제 데이터베이스 연동이 필요)
    get_fare_query = """
    SELECT Fare
    FROM Fare
    WHERE FareID = %s
    """
    db_cursor.execute(get_fare_query, (fare_id,))
    return db_cursor.fetchone()[0]

def get_promotion_amount(promotion_id):
    # 프로모션 정보 조회 (실제 데이터베이스 연동이 필요)
    get_promotion_query = """
    SELECT PromotionAmount
    FROM Promotion
    WHERE PromotionID = %s
    """
    db_cursor.execute(get_promotion_query, (promotion_id,))
    return db_cursor.fetchone()[0]

def get_point_payment_amount(point_payment_id):
    # 포인트 정보 조회 (실제 데이터베이스 연동이 필요)
    get_point_payment_query = """
    SELECT PointsUsed
    FROM PointPay
    WHERE PointPaymentID = %s
    """
    db_cursor.execute(get_point_payment_query, (point_payment_id,))
    return db_cursor.fetchone()[0]

def update_seat_status(train_id, carriage_num, seat_num, time_id):
    # 좌석 테이블 업데이트 (이 코드는 실제로 좌석을 마킹하는 방법에 따라 수정되어야 합니다)
    update_seat_query = """
    UPDATE Seat
    SET IsOccupied = 1
    WHERE TrainID = %s AND CarriageNum = %s AND SeatNum = %s AND TimeID = %s
    """
    seat_values = (train_id, carriage_num, seat_num, time_id)
    db_cursor.execute(update_seat_query, seat_values)
    db_connection.commit()

def insert_service_payment(payment_id, service_id):
    # Service_Payment 테이블에 삽입
    insert_service_payment_query = """
    INSERT INTO Service_Payment (PaymentID, ServiceID)
    VALUES (%s, %s)
    """
    service_payment_values = (payment_id, service_id)
    db_cursor.execute(insert_service_payment_query, service_payment_values)
    db_connection.commit()

def make_payment(passenger_id, train_id, carriage_num, seat_num, time_id, route_id, fare_id, promotion_id=None,
                 point_payment_id=None, service_id=None):
    try:
        fare_amount = get_fare_amount(fare_id)
        promotion_amount = get_promotion_amount(promotion_id)
        point_amount = get_point_payment_amount(point_payment_id)

        # 결제 정보 계산
        total_amount = fare_amount - promotion_amount - point_amount

        # Payment 테이블에 삽입
        insert_payment_query = """
        INSERT INTO Payment (TrainID, CarriageNum, SeatNum, TimeID, PassengerID, RouteID, FareID, PromotionID, PointPaymentID, TotalAmount)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        payment_values = (
            train_id, carriage_num, seat_num, time_id, passenger_id, route_id, fare_id, promotion_id, point_payment_id, total_amount
        )
        db_cursor.execute(insert_payment_query, payment_values)
        db_connection.commit()

        payment_id = db_cursor.lastrowid  # 자동 증가하는 PaymentID 반환

        update_seat_status(train_id, carriage_num, seat_num, time_id)

        if service_id is not None:
            insert_service_payment(payment_id, service_id)

        print(f"결제가 성공적으로 완료되었습니다. PaymentID: {payment_id}, 총액: {total_amount}")

        # 승객이 환불을 요청할지 물어봅니다.
        refund_choice = input("환불을 요청하시겠습니까? (y/n): ").lower()
        if refund_choice == 'y':
            complete_refund(payment_id)

    except Exception as e:
        db_connection.rollback()
        print(f"결제 중 오류 발생: {e}")

def complete_refund(payment_id):
    try:
        # 환불 테이블에 삽입
        insert_refund_query = """
        INSERT INTO Refund (PaymentID)
        VALUES (%s)
        """
        refund_values = (payment_id,)
        db_cursor.execute(insert_refund_query, refund_values)
        db_connection.commit()

        print(f"환불완료.결제ID: {payment_id}")

    except Exception as e:
        db_connection.rollback()
        print(f"환불중 오류 발생: {e}")

def login():
    username = input("사용자 이름을 입력하세요: ")
    return username

def print_timetable(StartID, EndID):
  #  print("1")
    cursor = db_connection.cursor()

    # 출발역과 도착역을 포함하는 route를 찾기
    find_route_query = "SELECT * FROM route WHERE StartID = %s AND EndID = %s"
    cursor.execute(find_route_query, (StartID, EndID))
    routes = cursor.fetchall()

    timetable_list = []

 #   print("2")

    #루트를 통해 커넥티드루트에서 순서 찾기
    for route in routes:
        find_conncected_route_query = "SELECT * FROM connected_route WHERE RouteID = %s"
        cursor.execute(find_conncected_route_query,(route[0],))
        connectedroutes = cursor.fetchall()
        connectedroutes = sorted(connectedroutes, key=lambda x: x[1])  # num이 두 번째 컬럼이므로 key=lambda x: x[1]
        
#        print("3")

        #connectedroute에 있는 모든 detailedroute를 찾기
        for connectedroute in connectedroutes:
            find_detailedroute_query = "SELECT * FROM detailedroute WHERE detailedrouteID = %s"
            cursor.execute(find_detailedroute_query, (connectedroute[2],))
            detailedroutes = cursor.fetchall()

         #   print("4")

            # detailedroute와 연관된 시간표 찾기
            for detailedroute in detailedroutes:
                detailedrouteID = detailedroute[0]  # 디테일루트ID 받아옴
                find_timetable_query = "SELECT * FROM timetable WHERE detailedrouteID = %s"
                cursor.execute(find_timetable_query, (detailedroute[0],))
                timetables = cursor.fetchall()

        #        print("5")

    for timetable in timetables:
        timetable_list.append(timetable)
       # print("6")

    timetable_id_list=[]

    for timetable in timetable_list:
        timetableID = timetable[0]  # Assuming the timetable ID is the first column.
      #  print(f"id는 {timetableID}")
     #   print("d")
        timetable_id_list.append(timetableID)
    

    
    #print("함수의 끝")
    print(f"{timetable_id_list}")







def main():
    while True:
        user = login()

        while user == "user":
            userid = input("사용자 번호를 입력하세요: ")
            print("1. Payment\n"
                  "2. Refund\n"
                  "3. Timetable\n"
                  "4. Seat\n"
                  "5. user information"
                  "0. Logout")
            choice = input("원하는 옵션의 숫자를 입력하세요: ")

            if choice == '1':
                payment()
            elif choice == '2':
                refund()
            elif choice == '3':
                StartID = input("출발역 ID를 입력해주세요: ")
                EndID = input("도착역 ID를 입력해주세요: ")
                print_timetable(StartID, EndID)
            elif choice == '4':
                seat()
            elif choice == '5':
                user_information()
            elif choice == '0':
                break
            else:
                print("잘못된 입력입니다.")

        while user == "admin":
            print("1. Time Table Edit\n"
                  "2. Promotion Edit\n"
                  "3. Train Edit\n"
                  "0. Logout")
            choice = input("원하는 옵션의 숫자를 입력하세요: ")

            if choice == '1':
                time_table_edit()
            elif choice == '2':
                promotion_edit()
            elif choice == '3':
                train_edit()
            elif choice == '0':
                break
            else:
                print("잘못된 입력입니다.")

        if user not in ["user", "admin"]:
            print("잘못된 사용자 이름입니다.")

if __name__ == "__main__":
    main()

"""
try:
    passenger_id = int(input("승객 ID 입력: "))

    get_passenger_info()
    route_id = get_route_info()

    if route_id is not None:
        train_id = get_train_info(route_id)

        if train_id is not None:
            date_str = input("이동 일자 입력 (YYYY-MM-DD): ")
            travel_date = datetime.strptime(date_str, "%Y-%m-%d").date()

            carriage_num, seat_num = get_seat_info(train_id, travel_date)

            if carriage_num is not None and seat_num is not None:
                make_payment(passenger_id, train_id, carriage_num, seat_num, None, route_id, None, None, None)

                service_id = get_service_info()

                if service_id is not None:
                    # 선택한 서비스를 포함하여 결제 완료
                    make_payment(passenger_id, train_id, carriage_num, seat_num, None, route_id, None, None, None,
                                 service_id)

                    # 사용자에게 환불 요청 메시지가 표시됨
                    refund_choice = input("환불을 요청하시겠습니까? (y/n): ").lower()
                    if refund_choice == 'y':
                        payment_id = int(input("환불할 PaymentID 입력: "))
                        complete_refund(payment_id)

except Exception as e:
    print(f"Error: {e}")


finally:
    # MySQL 연결 종료
    db_cursor.close()
    db_connection.close()
    """
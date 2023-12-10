import mysql.connector
import itertools
import heapq
from datetime import datetime

# MySQL 연결 설정
db_connection = mysql.connector.connect(
    host="localhost",
    user="bs06136",
    password="zxc123",
    database="train"
)

try:
    # SQL 파일 열기
    with open('train.sql', 'r') as file:
        sql_script = file.read()

    # SQL 명령어를 ';' 기준으로 분리
    sql_commands = sql_script.split(';')

    # 커서 생성
    cursor = db_connection.cursor()

    # 각 SQL 명령어 실행
    for command in sql_commands:
        if command.strip() != '':
            cursor.execute(command)

    # 변경 사항 저장
    db_connection.commit()

except mysql.connector.Error as error:
    print("Failed to execute script: {}".format(error))

finally:
    # 연결 닫기
    if (db_connection.is_connected()):
        cursor.close()
        db_connection.close()
        print("MySQL connection is closed")


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

try:
    # SQL 파일 열기
    with open('train_data_init.sql.sql', 'r') as file:
        sql_script = file.read()

    # SQL 명령어를 ';' 기준으로 분리
    sql_commands = sql_script.split(';')

    # 커서 생성
    cursor = db_connection.cursor()

    # 각 SQL 명령어 실행
    for command in sql_commands:
        if command.strip() != '':
            cursor.execute(command)

    # 변경 사항 저장
    db_connection.commit()

except mysql.connector.Error as error:
    print("Failed to execute script: {}".format(error))

finally:
    # 연결 닫기
    if (db_connection.is_connected()):
        cursor.close()
        db_connection.close()
        print("MySQL connection is closed")
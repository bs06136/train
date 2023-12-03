
import pymysql

# MySQL 데이터베이스 연결 설정
conn = pymysql.connect(
    host='127.0.0.1',  # MySQL 서버 주소
    user='root',  # MySQL 사용자 이름
    password='zxc123',  # MySQL 사용자 비밀번호
    db='new_schema',  # MySQL 데이터베이스 이름
    charset='utf8mb4'  # 문자 인코딩 설정
)

try:
    # Connection을 통해 Cursor 생성
    with conn.cursor() as cursor:
        # SQL 쿼리 실행
        sql = "SELECT * FROM advisor"  # 사용할 SQL 쿼리
        cursor.execute(sql)

        # 결과 가져오기
        result = cursor.fetchall()
        for row in result:
            print(row)

    # 작업이 성공하면 커밋
    conn.commit()

except pymysql.MySQLError as e:
    print('MySQL Error: ', e)
    conn.rollback()  # 에러 발생 시 롤백

finally:
    # 데이터베이스 연결 종료
    conn.close()

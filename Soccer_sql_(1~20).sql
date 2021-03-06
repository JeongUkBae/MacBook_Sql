
-- SQL_TEST_001
-- 전체 축구팀 목록. 이름 오름차순

SELECT T.team_name "전체 축구팀 목록"
FROM team T 
ORDER BY T.team_name ;

-- SQL_TEST_002
-- 포지션 종류(중복제거,없으면 빈공간)

SELECT DISTINCT POSITION 포지션 
FROM PLAYER;

-- SQL_TEST_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- nvl2()사용

SELECT DISTINCT nvl2(POSITION ,POSITION,'신입') 포지션 
from PLAYER;


-- SQL_TEST_004
-- 수원팀(ID: K02)골키퍼

SELECT P.PLAYER_NAME 이름 
FROM PLAYER P
WHERE P.POSITION like 'GK' AND p.team_id like 'K02'
ORDER BY P.PLAYER_NAME ;


-- SQL_TEST_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
SELECT * FROM PLAYER;

SELECT P.POSITION 포지션, P.PLAYER_NAME 이름
FROM PLAYER P
WHERE P.TEAM_ID LIKE 'K02' and P.HEIGHT >= 170 AND P.PLAYER_NAME LIKE '고%' ;


-- SQL_TEST_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
SELECT * FROM PLAYER;

SELECT CONCAT(P.PLAYER_NAME,'선수')이름, 
    TO_CHAR (nvl2(P.HEIGHT,P.HEIGHT,'0')||'cm') 키, 
    TO_CHAR (nvl2(P.WEIGHT,P.WEIGHT,'0')||'kg' ) 몸무게
FROM PLAYER P
WHERE P.TEAM_ID LIKE 'K02'
ORDER BY p.HEIGHT DESC;


-- SQL_TEST_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 cm 와 kg 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
--nvl2(weight,weight,'0')'kg'

SELECT CONCAT(P.PLAYER_NAME,'선수')이름, 
    TO_CHAR (nvl2(P.HEIGHT,P.HEIGHT,'0')||'cm') 키, 
    TO_CHAR (nvl2(P.WEIGHT,P.WEIGHT,'0')||'kg' ) 몸무게,
    ROUND(WEIGHT/(HEIGHT*HEIGHT)*10000, 2) "BMI 지수"
FROM (SELECT PLAYER_NAME, HEIGHT, WEIGHT
      FROM PLAYER 
      WHERE TEAM_ID LIKE 'K02')P
ORDER BY P.HEIGHT DESC;
-- SQL_TEST_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 
--  포지션이 GK 인  선수
-- 팀명, 사람명 오름차순

SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME 
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE T.TEAM_ID IN('K02','K10') AND POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SQL_TEST_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순

SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 이름,  to_char(P.HEIGHT||'cm') 키 
FROM (SELECT T.TEAM_ID, T.TEAM_NAME
      FROM TEAM T WHERE T.TEAM_ID IN('K02','K10')) T
    JOIN PLAYER P 
        ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME ;


-- SOCCER_SQL_010
-- 모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순

SELECT T.TEAM_NAME 팀명, P.PLAYER_NAME 이름
FROM (SELECT P.TEAM_ID, P.PLAYER_NAME 
        FROM PLAYER P WHERE P.POSITION IS NULL) P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
 
SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움
FROM TEAM T
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY T.TEAM_NAME ;



-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오

SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움, 
        J.AWAYTEAM_ID "원정팀 ID", J.SCHE_DATE 스케줄날짜  
FROM SCHEDULE J
    JOIN STADIUM S
    ON J.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM T 
    ON J.STADIUM_ID LIKE T.STADIUM_ID
WHERE J.SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME; 

-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
SELECT P.PLAYER_NAME 선수명, P.POSITION 포지션,
       TO_CHAR(T.REGION_NAME||' '||T.TEAM_NAME )팀명, 
       S.STADIUM_NAME 스타디움, J.SCHE_DATE 스케줄날짜
FROM ( SELECT J.SCHE_DATE, J.HOMETEAM_ID, J.STADIUM_ID
       FROM SCHEDULE J
       WHERE J.SCHE_DATE LIKE '20120317' AND HOMETEAM_ID LIKE 'K03') J
    JOIN STADIUM S
    ON J.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM T 
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN PLAYER P 
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE POSITION LIKE 'GK'
ORDER BY P.PLAYER_NAME; 


-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
SELECT * FROM SCHEDULE;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;

SELECT * 
FROM SCHEDULE C
WHERE (C.HOME_SCORE-C.AWAY_SCORE) >=3 
ORDER BY C.HOME_SCORE DESC;

SELECT STADIUM_NAME 스타디움, SCHE_DATE 경기날짜 , 
       (T.REGION_NAME||' '|| T.TEAM_NAME) 홈팀,
       (T.REGION_NAME ||' '||(SELECT T.TEAM_NAME
       FROM TEAM T
       WHERE C.AWAYTEAM_ID LIKE T.TEAM_ID
       ))원정팀,
       HOME_SCORE "홈팀 점수", AWAY_SCORE "원정팀 점수"
FROM (SELECT SCHE_DATE, HOME_SCORE, AWAY_SCORE, STADIUM_ID, HOMETEAM_ID, AWAYTEAM_ID
      FROM SCHEDULE C
      WHERE(C.HOME_SCORE-C.AWAY_SCORE) >=3 ) C
      JOIN STADIUM S
      ON C.STADIUM_ID LIKE S.STADIUM_ID
      JOIN TEAM T 
      ON S.HOMETEAM_ID LIKE T.TEAM_ID
ORDER BY HOME_SCORE DESC;


-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

SELECT * FROM STADIUM;
SELECT * FROM TEAM;

SELECT COUNT(*) FROM STADIUM;
SELECT COUNT(HOMETEAM_ID) FROM STADIUM;

SELECT S.STADIUM_NAME, S.STADIUM_ID, S.SEAT_COUNT, 
       S.HOMETEAM_ID, HOMETEAM_ID, S.HOMETEAM_ID, T.E_TEAM_NAME
FROM (SELECT HOMETEAM_ID, STADIUM_ID, STADIUM_NAME, SEAT_COUNT 
      FROM STADIUM )S
     JOIN TEAM T
     ON S.STADIUM_ID LIKE T.STADIUM_ID
WHERE S.HOMETEAM_ID IS NOT NULL;



-- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출

SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT T.TEAM_ID, T.TEAM_NAME, P.PLAYER_NAME, P.HEIGHT
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.TEAM_ID LIKE 'K04'
GROUP BY AVG(P.HEIGHT);    
--WHERE AVG(TEAM_ID);

SELECT * 
FROM PLAYER 
WHERE TEAM_ID LIKE 'K04';

SELECT AVG(HEIGHT)
      FROM PLAYER 
      WHERE TEAM_ID LIKE 'K04';

SELECT TEAM_ID, COUNT(TEAM_ID), AVG(HEIGHT)
FROM PLAYER
GROUP BY TEAM_ID
ORDER BY TEAM_ID;





-- SOCCER_SQL_017
-- 포지션이 MF 인 선수들의  소속팀명 및 선수명, 백넘버 출력

-- SOCCER_SQL_018
-- 가장 키큰 선수 5 추출, 오라클, 단 키 값이 없으면 제외

-- SOCCER_SQL_019
-- 선수 자신이 속한 팀의 평균키보다 작은 선수 정보 출력

-- SOCCER_SQL_020
-- 2012년 5월 한달간 경기가 있는 경기장 조회
-- EXISTS 쿼리는 항상 연관쿼리로 상요한다.
-- 또한 아무리 조건을 만족하는 건이 여러 건이라도
-- 조건을 만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다
--step01_Join1.sql

/*
물리적 조인(Join)
   특정 칼럼(외래키)을 이용하여 두 개 이상의 테이블을 연결하는 DB 기법
  <조인 절차>
  1. 기본키가 포함된 테이블(master table) 생성
  2. 기본키가 포함된 테이블에 레코드 삽입
  3. 외래키가 포함된 테이블(transaction table) 생성
  4. 외래키가 포함된 테이블에 레코드 삽입
  
  * 조인 테이블 삭제 : 위 순서에 역순이다.
  * 강제 테이블 삭제 : drop table 테이블명 cascade constraint;
*/

--1단계: 기본키가 포함된 테이블(원장: master table)생성

CREATE TABLE goods( --상품 테이블
gcode number(2) PRIMARY KEY,
gname VARCHAR(30),
price INT
);

--2단계: 기본키가 포함된 테이블에 레코드 삽입
INSERT INTO goods VALUES(10,'사과',5000);
INSERT INTO goods VALUES(20,'복숭아',8000);
INSERT INTO goods VALUES(30,'포도',3000);

--3단계: 외래키가 포함된 테이블(거래:transaction table)생성
CREATE TABLE sale(
gcode number(2) PRIMARY KEY,
sale_date date,
su number(3),
FOREIGN KEY(gcode) REFERENCES goods(gcode) --외래키 지정
);

--4단계: 외래키가 포함된 테이블에 레코드 삽입
INSERT INTO sale VALUES(10,sysdate,5);
INSERT INTO sale VALUES(20,sysdate,10);
INSERT INTO sale VALUES(30,sysdate,8);

INSERT INTO sale VALUES(40,sysdate,8); --오류: 참조무결성 제약조건 위배

COMMIT; --DB 반영

--5단계: 조인 KEY 이용
SELECT g.gcode, g.gname, s.sale_date, s.su
FROM goods g, sale s
WHERE g.gcode = s.gcode AND s.su >=8; --조인 조건 & 일반 조건





























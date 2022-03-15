-- chap02_SQL_basic/step01_sql_basic.sql
-- id:scott, pw : tiger
SELECT * FROM tab; -- 의사테이블 : 전체 테이블 조회

/*
  SQL(Structured Query Language) : 구조화된 질의 언어 
  - DDL, DML, DCL
  1. DDL : 데이터 정의어 -> DBA, USER(TABLE 생성, 구조변경, 삭제)
  2. DML : 데이터 조작어 -> USER(SELECT, INSERT, DELETE, UPDATE)
  3. DCL : 데이터 제어어 -> DBA(권한설정, 사용자 등록 등) 
*/

-- 1. DDL : 데이터 정의어

-- 1) Table 생성 
/*
 * create table 테이블명(
 *   칼럼명 데이터형 [제약조건],
 *   칼럼명 데이터형
 *   );
 */
 CREATE TABLE test2(
 id VARCHAR(20) primary key,
 passwd VARCHAR(50) not null,
 name VARCHAR(25) not null
 );
-- 테이블 전체 목록 조회
SELECT * FROM tab;
SELECT * FROM test2; -- 특정 테이블 내용 조회

-- 2) Table 구조 변경 
-- (1) 테이블 이름 변경 
-- 형식) alter table 구테이블명 rename to 새테이블명;
ALTER TABLE test2 RENAME TO member;
-- (2) 테이블 칼럼 추가 
-- 형식) alter table 테이블명 add (칼럼명 자료형(n));
ALTER TABLE member ADD(reg_data date); -- 가입일 칼럼 추가
SELECT * FROM member;
--(3) 테이블 칼럼 수정 : 이름변경, type, 제약조건 수정 
-- 형식) alter table 테이블명 modify (칼럼명 자료형(n) 제약조건); 
ALTER TABLE member MODIFY(passwd VARCHAR(25)); -- 크기 변경
-- (4) 테이블 칼럼 삭제 
-- 형식) alter table 테이블명 drop column  칼럼명;
ALTER TABLE member DROP COLUMN passwd; -- 비번 칼럼 제거
-- 3) Table 제거 
-- 형식) drop table 테이블명 purge;
-- purge 속성 : 임시파일 제거 
DROP TABLE member PURGE; --임시파일까찌 제거

-- 2. DML : 데이터 조작어
create table depart(    -- 부서 테이블
dno number(4),          -- 부서 번호
dname varchar(50),      -- 부서명
daddress varchar(100)   -- 부서주소
);

SELECT * FROM depart;

-- 1) insert : 레코드 삽입
-- 형식) insert into 테이블명(칼럼명1, .. 칼럼명n) values(값1, ... 값n);
INSERT INTO depart(dno, dname, daddress) values(1001,'기획실','서울시');
-- 전체 칼럼 입력: 칼럼명 생략
INSERT INTO depart values(1002,'영업부','싱가폴');
-- 부분 칼럼 입력: 칼럼명 필수 입력
INSERT INTO depart(dno, dname) values(1003,'총무부');

-- 2) select : 레코드 검색 
-- 형식) select 칼럼명 from 테이블명 [where 조건식];
SELECT * FROM depart; -- 전체 칼럼 조회
SELECT dno, dname FROM depart; -- 특정 칼럼 조회
SELECT * FROM depart WHERE dno>=1002;
SELECT * FROm depart WHERE daddress is null; -- 주소 없는 레코드 조회
SELECT * FROm depart WHERE daddress is null; -- 주소 있는 레코드 조회

-- 3) update : 레코드 수정 
-- 형식) update 테이블명 set 칼럼명 = 값 where 조건식;
UPDATE depart SET daddress = '대전시' WHERE dno=1003;

-- 4) delete : 레코드 삭제 
-- 형식) delete from 테이블명 where 조건식;
DELETE FROM depart WHERE dno = 1003;

-- 3. DCL : 데이터 제어어
-- 1) 권한 설정 : grant 권한, ... to user;
-- 2) 권한 해제 : revoke 권한, ... to user;

-- SQL> conn system/1234 -- 관리자 모드 DB 접속
-- SQL> grant connect to scott; -- 권한 설정 예
-- SQL> revoke connect to scott; -- 권한 해제 예
-- SQL> creat user 계정 identified by 비번;  -- 일반 사용자 추가

-- 작업내용 DB 반영
COMMIT;

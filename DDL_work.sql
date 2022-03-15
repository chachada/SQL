-- DDL_work.sql

/*
  데이터정의어(DDL): 테이블 생성, 변경, 삭제
  - 자동 커밋(AUTO COMMIT)
*/

--1.의사컬럼(Pseudo Column)
--ROWNUM: 레코드 순번(레코드 입력 순서)
--ROWID: 레코드 식별을 위한 해시값(암호화된 코드)

--예1) 최초 레코드 순번 검색: 의사컬럼 -SELECT,WHERE,ORDER BY절 사용
SELECT ROWNUM, empno, ename, ROWID 
FROM emp WHERE ROWNUM <=5;

SELECT ROWNUM, empno, ename, ROWID 
FROM emp WHERE ROWNUM <=5
ORDER BY ROWNUM DESC;

--예2) 5번~10번째 입사자: 범위 -검색 안됨
SELECT ROWNUM, empno, ename, ROWID 
FROM emp WHERE ROWNUM >=5 AND ROWNUM <=10;

--서브쿼리 + 의사칼럼의 별칭
SELECT rnum,empno,ename
FROM (SELECT emp.*, ROWNUM rnum FROM emp) --테이블->서브쿼리
WHERE rnum BETWEEN 5 and 10;
/*
  emp.*: 테이블.전체칼럼
  주의: 서브쿼리에서 선택한 칼럼만 메인쿼리의 SELECT절에서 사용 가능
  서브쿼리 칼럼 별칭: 메인쿼리의 SELECT,WHERE절에 사용
*/

--테이블 별칭 사용
SELECT e.ename,e.deptno,d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;
--테이블 별칭: SELECT,WHERE절에 사용

--2.실수형 테이블 생성
CREATE TABLE emp01(
empno NUMBER(4),
ename VARCHAR2(20),
sal NUMBER(7,2)); --(전체,소숫점)

INSERT INTO emp01 VALUES(1,'hong',1234.1); --정상
INSERT INTO emp01 VALUES(2,'lee',1234.123); --정상
INSERT INTO emp01 VALUES(3,'kang',123456.123); --오류

--3.서브쿼리 이용한 테이블 생성: 형식1)
CREATE TABLE emp02 --사본: 자료+구조(스키마
AS
SELECT * FROM emp; --원본

--실습: 특정 칼럼 대상 테이블 생성
CREATE TABLE emp03 --사본: 일부분의 자료+구조
AS 
SELECT empno,ename FROM emp;

--<과제1>EMP 테이블을 복사하되 사원번호, 사원이름, 급여 컬럼으로 구성된
--    테이블을 생성하시오.(단 테이블의 이름은 EMP04)
CREATE TABLE emp04
AS
SELECT empno,ename,sal FROM emp;

SELECT * FROM emp04;

--특정 행 대상 테이블 생성
CREATE TABLE emp05
AS
SELECT * FROM emp WHERE deptno = 10;

--문)영업사원만 관리한 테입르 만들기(테이블명: Sales)
CREATE TABLE Sales
AS
SELECT * FROM emp WHERE job = 'SALESMAN';

SELECT * FROM Sales;

--구조(스키마)만 복제
CREATE TABLE emp06
AS
SELECT * FROM emp WHERE 1=0; --조건식: FALSE

--<과제2>DEPT 테이블과 동일한 구조의 빈 테이블을 생성하시오. (테이블의 이름은 DEPT02)
CREATE TABLE dept02
AS
SELECT * FROM dept WHERE 1=1.1;

DESC dept02;

INSERT INTO dept02 VALUES(10,'기획실','서울시');

--4.테이블 제약조건

--1)기본키(primary key): 1개만 지정, 중복불가,null불가
CREATE TABLE test_tab1(
id NUMBER(2) PRIMARY KEY, --칼럼 level
name VARCHAR2(10)
);

CREATE TABLE test_tab2(
id NUMBER(2), 
name VARCHAR2(10),
PRIMARY KEY(id) --테이블 level
);

--2)외래키(FOREIGN KEY)
--A 테이블의 기본키를 B 테이블에서 참조하는 칼럼

--(1)기본키 테이블 생성
CREATE TABLE DEPT_TAB(
deptno NUMBER(2) PRIMARY KEY,
dname CHAR(14),
loc CHAR(13)
);

--(2)레코드 추가
INSERT INTO dept_tab VALUEs(1,'기획부','서울시');
INSERT INTO dept_tab VALUEs(2,'영업부','뉴욕시');
SELECT * FROM dept_tab;

--(3)외래키 테이블 생성
CREATE TABLE EMP_TAB (
EMPNO NUMBER(4) PRIMARY KEY, --기본키
ENAME VARCHAR2(10), --이름
SAL NUMBER(7,2), --급여
DEPTNO NUMBER(2) NOT NULL, --부서번호: 외래키
FOREIGN KEY (DEPTNO) REFERENCES DEPT_TAB (DEPTNO) --외래키 지정
);

--(4)레코드 추가
INSERT INTO emp_tab VALUES(1001,'홍길동',250,2);
INSERT INTO emp_tab VALUES(1002,'이순신',350,1);
INSERT INTO emp_tab VALUES(1003,'강호동',150,3); --오류: 참조무결성 제약조건 위반

--3)유일키(UNIQUE KEY(UK)): 여러개 지정, 중복불가, null허용
CREATE TABLE UNI_TAB1(
deptno NUMBER(2) UNIQUE, --칼럼 level
dname CHAR(14),
loc CHAR(13)
);

INSERT INTO UNI_TAB1 VALUES(1,'AAAA','BBBB');
INSERT INTO UNI_TAB1 VALUES(1,'AAAA','BBBB'); --오류 중복
INSERT INTO UNI_TAB1(dname, loc) VALUES('AAAA','BBBB'); --null 허용
SELECT * FROM uni_tab1

--4)NOT NULL(NN): NULL 허용불가, 칼럼 level만 가능
CREATE TABLE NN_TAB1 (
DEPTNO NUMBER(2) NOT NULL,
DNAME CHAR(14),
LOC CHAR(13)
);

INSERT INTO NN_TAB1(dname,loc) VALUES('AAAA','BBBB'); --오류 발생
INSERT INTO NN_TAB1(deptno,loc) VALUES(10 ,'BBBB'); --정상: dname생략
INSERT INTO NN_TAB1(deptno,dname) VALUES(20,'BBBB'); --정상: loc생략

--5)점검(CHECK): CHECK조건식
CREATE TABLE CK_TAB (
DEPTNO NUMBER(2) NOT NULL CHECK (DEPTNO IN (10,20,30,40,50)),
DNAME CHAR(14),
LOC CHAR(13));

INSERT INTO CK_TAB VALUES(10,'AAAA','BBBB'); -- 레코드 삽입
INSERT INTO CK_TAB VALUES(60,'AAAA','BBBB'); -- 오류: 체크 제약조건 위배


-- 5.테이블 구조 변경(ALTER TABLE 명령문)
SELECT * FROM emp01;

DESC emp01; --테이블 구조

ALTER TABLE emp01 ADD(job varchar(9)); --null 허용

--<과제3>DEPT02 테이블에 문자 타입의 부서장(DMGR) 칼럼을 추가하시오.
SELECT * FROM dept02;
ALTER TABLE dept02 ADD(DMGR varchar2(10));
DESC dept02;

--2)칼럼 수정: 자료형,크기,기본값 변경
ALTER TABLE emp01
MODIFY(JOB VARCHAR2(30)); --크기변경

DESC emp01;

--과제<4>DEPT02 테이블의 부서장(DMGR) 칼럼을 숫자 타입으로 변경하시오
ALTER TABLE dept02
MODIFY (DMGR number(4));

--3)칼럼 삭제
ALTER TABLE emp01
DROP COLUMN JOB;

--4)테이블 이름 변경
ALTER TABLE emp01 RENAME TO emp01_copy;

--6. 전체 레코드 제거(내용 지우기)
TRUNCATE TABLE emp02;

--7. 테이블 제거/임시 파일(테이블 복원 가능)

--1)전체 테이블 목록 보기
SELECT * FROM tab; --의사 테이블

SELECT tname FROM tab; --전체 테이블

SELECT tname FROM tab WHERE tname LIKE 'EMP%'; --조건문 조회

--2)테이블 제거 + 임시파일 제거
DROP TABLE EMP01_COPY purge;

--3)테이블 제거
CREATE TABLE emp01_copy
AS
SELECT * FROM emp; --임시파일 생성


SELECT * FROM tab; --임시파일: 전체 테이블 _임시파일

SELECT * FROM tab;
--8.데이터 사전 & 뷰
--데이터 사전: DB에 저장된 중요 정보(시스템 테이블)
--데이터 사전 뷰: 뷰를 통해서 사전 확인

--관리자용 뷰: DBA_XXXX
--사용자 뷰: USER_XXXX

SHOW USER; --SCOTT 

--1) USER_TABLES: 테이블 목록 보기 뷰(VIEW)
SELECT * FROM USER_TABLES;

SELECT * FROM USER_TABLES
ORDER BY table_name DESC;

--2)USER_RECYCLEBIN: 임시파일 목록 보기 뷰(VIEW)
SELECT * FROM USER_RECYCLEBIN;

--[추가] 임시파일-> 테이블 복원
CREATE TABLE dept_test
AS
SELECT * FROM dept;

DROP TABLE dept_test;CREATE TABLE dept_test,AS,SELECT * FROM dept;,DROP TABLE dept_test;,SELECT * FROM tab;

SELECT * FROM tab;

--테이블 복원: FLASHBACK TABLE "임시파일" TO BEFORE DROP;
FLASHBACK TABLE "BIN$z85JVK/wQxa57Hsim2n7DA==$0" TO BEFORE DROP; --4.테이블복원

SELECT * FROM USER_TABLES; --5.테이블확인

--임시 파일 생성가능
/*
0. Run SQL command 실행

1. 관리자 모드 DB접속
SQL> conn system/1234

2.사용자 권한 설정
SQL> alter user scott default tablespace USERS TEMPORARY tablespace TEMP;
*/






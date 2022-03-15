--Sequence.sql

/*
  시퀀스(sequence)
  -의미: 자동번호생성기(중복불가)
  -용도: 기본키로 지정된 칼럼에 입력할 값 생성
  -ex) 사번, 학번, 게시글번호
*/

--1.시퀀스 생성
CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
MAXVALUE 10000;

--2.테이블 생성
DROP TABLE emp01 purge;

CREATE TABLE emp01(
empno number(4) PRIMARY KEY,
ename VARCHAR(20),
hiredate DATE
);

--3.레코드 추가: 시퀀스 이용
INSERT INTO emp01 VALUES(emp_seq.NEXTVAL,'JULA',SYSDATE);
INSERT INTO emp01 VALUES(emp_seq.NEXTVAL,'HONGKD',SYSDATE);
SELECT * FROM emp01;

--4.데이터 사전 뷰: 시퀀스 정보 확인
SELECT * FROM USER_SEQUENCES; --시퀀스 정보
SELECT * FROM USER_TABLES; --테이블 정보

--5.시퀀스 삭제
DROP SEQUENCE emp_seq;

--<문제>DEPTNO 칼럼에 시퀀스 이용 레코드 삽입

CREATE TABLE DEPT_EXAMPLE(  --테이블 생성
DEPTNO NUMBER(4) PRIMARY KEY,
DNAME VARCHAR(15),
LOC VARCHAR(15)
);

--부서번호 시퀀스 생성
CREATE SEQUENCE deptno_seq
start with 10
increment by 10
maxvalue 60;
);

INSERT INTO DEPT_EXAMPLE VALUES(deptno_seq.NEXTVAL,'인사과','서울');
INSERT INTO DEPT_EXAMPLE VALUES(deptno_seq.NEXTVAL,'경리과','서울');
INSERT INTO DEPT_EXAMPLE VALUES(deptno_seq.NEXTVAL,'총무과','대전');
INSERT INTO DEPT_EXAMPLE VALUES(deptno_seq.NEXTVAL,'기술과','인천');
SELECT * FROM DEPT_EXAMPLE;

--6.시퀀스 수정 : START WITH 수정 불가
ALTER SEQUENCE deptno_seq MAXVALUE 1000;

--7.문자열 + SEQUENCE 숫자 결합
CREATE TABLE board(
bno char(50) PRIMARY KEY, --게시물 번호(NO: 1001)
writer varchar(30) NOT NULL, --작성자
title varchar(100) NOT NULL, --제목
cont varchar(1000) --내용
);

--시퀀스 생성
CREATE SEQUENCE bno_seq
START WITH 1001
INCREMENT BY 1;

-- 게시글 삽입: 게시물 번호(NO:1001)
INSERT INTO board VALUES('NO :'||TO_CHAR(bno_seq.NEXTVAL),'홍길동','테스트1','방가방가');
INSERT INTO board VALUES('NO :'||TO_CHAR(bno_seq.NEXTVAL),'유관순','테스트2','방가방가2');
--TO_CHAR():숫자형 -> 문자형 변환

SELECT * FROM board;






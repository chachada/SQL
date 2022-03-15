--1.레코드 삽입(INSERT)


--2) 서브쿼리 이용

--실습 테이블 생성
DROP TABLE DEPT02 PURGE;



--2.여러 테이블에 레코드 추가
INSERT ALL
INTO EMP_HIR VALUUES(EMPNO,ENAME,

--3. 레코드 수정(UPDATE)

--1)단일 쿼리 사용
SELECT * FROM emp01;

--전체 레코드 수정: WHERE절 생략 시
UPDATE EMP01 SET DEPTNO=30;

UPDATE EMP01 SET SAL = SAL*1.1;

UPDATE EMP01 SET HIREDATE = SYSDATE;

--특정 행 대상으로 수정
DROP TABEL emp01;

CREATE TABLE emp01 --구조 + 내용


--2개 이상 칼럼 수정
UPDATE emp01
SET hiredate = sysdate, sal=50, comm = 4000
WHERE enmae = 'SCOTT';

SELECT * FROM emp01;

--2)서브쿼리 이용 레코드 수정
UPDATE dept01
SET loc = (select loc FROM 


--문7




--4.레코드 삭제(DELETE)

--1)단일 쿼리 이용
DELETE FROM empt01 WHERE deptno=30;

SELECT * FROM dept01;

DELETE FROM dept01; --주의:전체 행 삭제

--문9.SAM01 테이블에서 직책이 정해지지 않은 사원을 삭제하시오.
SELECT * FROM sam01;

DELETE FROM sam01 WHERE job is NULL;

--2)서브 쿼리 이용
DELETE FROM emp01
WHERE deptno = (SELECT deptno FROM dept WHERE dname = 'SALES'); --30

SELECT * FROM emp01;

--DB반영
COMMIT;
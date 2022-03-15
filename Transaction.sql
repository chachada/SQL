--Transaction_wrok.sql

/*
  트랜잭션: db에서 작업수행 단위
  COMMIT or COMMIT wrok: 트랜잭션 db반영
  SAVEPOINT label: 트랜잭션을 저장 역할
  ROLLBACK to label: 트랜잭션을 취소 역할
*/

CREATE TABLE dept_test
AS
SELECT * FROM dept;

SELECT * FROM dept_test;

DELETE FROM dept_test WHERE deptno=40;
SAVEPOINT c0;
COMMIT; --DB반영: 커밋 이전 명령문 복원 불가

--커밋 이후 명령문 복원 가능
DELETE FROM dept_test WHERE deptno=30;
SAVEPOINT c1;

DELETE FROM dept_test WHERE deptno=20;
SAVEPOINT c2;

DELETE FROM dept_test WHERE deptno=10;

SELECT * FROM dept_test;

ROLLBACK TO c2; --1개 복원

ROLLBACK TO c1; --2개 복원

ROLLBACK; --COMMIT 이후 모두 명령문 복원: 3개 복원

DROP TABLE emp purge;

SELECT * FROM USER_TABLES WHERE TABLE_NAME like '%EMP%';
